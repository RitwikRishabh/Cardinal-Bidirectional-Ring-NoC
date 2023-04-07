module rotating_prioritizer (
    input clk, reset,
    input polarity,
    input req0, req1,
    output grant0, grant1
);

    reg grantReg0, grantReg1;
    assign grant0 = grantReg0;
    assign grant1 = grantReg1;

    //Register the last grant signal and decrease the priority if any conflicts happen
    reg lastGrant0, lastGrant1;

    /* Fixed Prioritizer
        @input: reqF0, reqF1
        @output: grantF0, grantF1;
        reqF0 is given higher priority
    */
    reg reqF0, reqF1;
    reg grantF0, grantF1;
    
    always @(*) begin
        if (reqF0) begin
            grantF0 = 1;
            grantF1 = 0;
        end
        else begin
            grantF0 = 0;
            grantF1 = reqF1;
        end
    end

    /*  Barrel Shifter  */
    always @(*) begin
        if (polarity) begin
            if (lastGrant1) begin
                {reqF0, reqF1} = {req0, req1};
                {grantReg0, grantReg1} = {grantF0, grantF1};              
            end
            else begin
                {reqF0, reqF1} = {req1, req0};
                {grantReg0, grantReg1} = {grantF1, grantF0};
            end
        end
        else begin // Polarity == 1
            if (lastGrant0) begin
                {reqF0, reqF1} = {req0, req1};
                {grantReg0, grantReg1} = {grantF0, grantF1};              
            end
            else begin
                {reqF0, reqF1} = {req1, req0};
                {grantReg0, grantReg1} = {grantF1, grantF0};
            end
        end
    end

    // Registering the grant request
    always @(posedge clk) begin
        if (reset) begin
            lastGrant0 <= 1; // request 0 has the highest priority after reseting
            lastGrant1 <= 1;
        end
        else begin
            if (polarity) begin
                if (~req0 || ~req1) begin // When no contention happens, we need to reset the priority order
                    lastGrant1 <= 1;
                end
                else begin
                    if (grantReg0) begin
                        lastGrant1 <= 0;
                    end
                    if (grantReg1) begin
                        lastGrant1 <= 1;
                    end
                end
            end
            else begin // Polarity == 1
                if (~req0 || ~req1) begin // When no contention happens, we need to reset the priority order
                    lastGrant0 <= 1;
                end
                else begin
                    if (grantReg0) begin
                        lastGrant0 <= 0;
                    end
                    if (grantReg1) begin
                        lastGrant0 <= 1;
                    end
                end
            end
        end
    end
endmodule