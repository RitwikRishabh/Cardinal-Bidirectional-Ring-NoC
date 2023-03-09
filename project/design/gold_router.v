`include "buffer.v"
`include "rotatingPrioritizer.v"

module gold_router #(
    parameter PACKET_SIZE = 64
) (
    input clk, reset,
    output polarity,

    input cwsi,                             // Clockwise input send 
    output reg cwri,                        // Clockwise input receive
    input [PACKET_SIZE-1:0] cwdi,           // Clockwise input data 

    input ccwsi,                            // Counter-clockwise input send
    output reg ccwri,                       // Counter-clockwise input receive
    input [PACKET_SIZE-1:0] ccwdi,          // Counter-clockwise input data

    input pesi,                             // Processing element input send
    output reg peri,                        // Processing element input receive
    input [PACKET_SIZE-1:0] pedi,           // Processing element input data

    output reg cwso,                        // Clockwise output send
    input cwro,                             // Clockwise output receive
    output reg [PACKET_SIZE-1:0] cwdo,      // Clockwise output data

    output reg ccwso,                       // Counter-clockwise output send
    input ccwro,                            // Counter-clockwise output receive
    output reg [PACKET_SIZE-1:0] ccwdo,     // Counter-clockwise output data

    output reg peso,                        // Processing element output send                 
    input pero,                             // Processing element output receive
    output reg [PACKET_SIZE-1:0] pedo       // Processing element output data
);

    // Wires for polarity
    reg evenOdd;
    /*  Polarity logic
        Every clock cycle not the polarity signal
    */
    always @(posedge clk) begin
        if (reset) begin
            evenOdd <= 0;
        end
        else begin
            evenOdd <= ~evenOdd;
        end
    end
    assign polarity = evenOdd;

    // Create wires for input side
    reg wrEnableCwiV0, wrEnableCwiV1, wrEnableCcwiV0, wrEnableCcwiV1, wrEnablePeiV0, wrEnablePeiV1;
    reg rdEnableCwiV0, rdEnableCwiV1, rdEnableCcwiV0, rdEnableCcwiV1, rdEnablePeiV0, rdEnablePeiV1;
    wire emptyCwiV0, emptyCwiV1, emptyCcwiV0, emptyCcwiV1, emptyPeiV0, emptyPeiV1;
    wire fullCwiV0, fullCwiV1, fullCcwiV0, fullCcwiV1, fullPeiV0, fullPeiV1;
    wire [PACKET_SIZE-1:0] dataCwiV0, dataCwiV1, dataCcwiV0, dataCcwiV1, dataPeiV0, dataPeiV1;


    // Create 6 single-location input buffers (3 input channels each having 2 virtual channels each)  
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwiV0),
        .rdEnable(rdEnableCwiV0),
        .dataIn(cwdi),
        .dataOut(dataCwiV0),
        .full(fullCwiV0),
        .empty(emptyCwiV0)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwiV1),
        .rdEnable(rdEnableCwiV1),
        .dataIn(cwdi),
        .dataOut(dataCwiV1),
        .full(fullCwiV1),
        .empty(emptyCwiV1)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwiV0),
        .rdEnable(rdEnableCcwiV0),
        .dataIn(ccwdi),
        .dataOut(dataCcwiV0),
        .full(fullCcwiV0),
        .empty(emptyCcwiV0)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwiV1),
        .rdEnable(rdEnableCwiV1),
        .dataIn(ccwdi),
        .dataOut(dataCcwiV1),
        .full(fullCcwiV1),
        .empty(emptyCcwiV1)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeiV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeiV0),
        .rdEnable(rdEnablePeiV0),
        .dataIn(pedi),
        .dataOut(dataPeiV0),
        .full(fullPeiV0),
        .empty(emptyPeiV0)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeiV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeiV1),
        .rdEnable(rdEnablePeiV1),
        .dataIn(pedi),
        .dataOut(dataPeiV1),
        .full(fullPeiV1),
        .empty(emptyPeiV1)
    );
    
    // Decode header information
    // Virtual Channel -- 1 bit
    wire vcCwi, vcCCwi, vcPei;
    assign vcCwi = cwdi[PACKET_SIZE-1];
    assign vcCCwi = ccwdi[PACKET_SIZE-1];
    assign vcPei = pedi[PACKET_SIZE-1];
    // Direction -- 1 bit
    wire dirCwi, dirCcwi, dirPei;
    assign dirCwi = cwdi[PACKET_SIZE-2];
    assign dirCcwi = ccwdi[PACKET_SIZE-2];
    assign dirPei = pedi[PACKET_SIZE-2];
    // Hop Value -- 8 bits
    wire [7:0] hopCwi, hopCcwi, hopPei;
    assign hopCwi = cwdi[PACKET_SIZE-9:PACKET_SIZE-16];
    assign hopCcwi = ccwdi[PACKET_SIZE-9:PACKET_SIZE-16];
    assign hopPei = pedi[PACKET_SIZE-9:PACKET_SIZE-16];

    /*  Write enable logic
        Only enable write once handshaking is complete
    */
    always @(*) begin
        if (!evenOdd) begin
            wrEnableCwiV0 = 0;
            wrEnableCcwiV0 = 0;
            wrEnablePeiV0 = 0;

            // Clockwise
            if (cwsi && cwri) begin
                wrEnableCwiV1 = 1;
            end
            else begin
                wrEnableCwiV1 = 0;
            end
            // Counter-clockwise
            if (ccwsi && ccwri) begin
                wrEnableCcwiV1 = 1;
            end
            else begin
                wrEnableCcwiV1 = 0;
            end
            // Processing Element
            if (pesi && peri) begin
                wrEnablePeiV1 = 1;
            end
            else begin
                wrEnablePeiV1 = 0;
            end
        end
        else begin // if polarity == 1
            wrEnableCwiV1 = 0;
            wrEnableCcwiV1 = 0;
            wrEnablePeiV1 = 0;

            // Clockwise
            if (cwsi && cwri) begin
                wrEnableCwiV0 = 1;
            end
            else begin
                wrEnableCwiV0 = 0;
            end
            // Counter-clockwise
            if (ccwsi && ccwri) begin
                wrEnableCcwiV0 = 1;
            end
            else begin
                wrEnableCcwiV0 = 0;
            end
            // Processing Element
            if (pesi && peri) begin
                wrEnablePeiV0 = 1;
            end
            else begin
                wrEnablePeiV0 = 0;
            end
        end
    end

    /*  Ready signal logic for input buffers
        When empty signal is asserted, buffer is ready
    */ 
    always @(*) begin
        if (!evenOdd) begin
            // Clockwise
            if (emptyCwiV1) begin
                cwri = 1;
            end
            else begin
                cwri = 0;
            end
            // Counter-clockwise
            if (emptyCcwiV1) begin
                ccwri = 1;
            end
            else begin
                ccwri = 0;
            end
            // Processing Element
            if (emptyPeiV1) begin
                peri = 1;
            end
            else begin
                peri = 0;
            end
        end
        else begin // polarity == 1
            // Clockwise
            if (emptyCwiV0) begin
                cwri = 1;
            end
            else begin
                cwri = 0;
            end
            // Counter-clockwise
            if (emptyCcwiV0) begin
                ccwri = 1;
            end
            else begin
                ccwri = 0;
            end
            // Processing Element
            if (emptyPeiV0) begin
                peri = 1;
            end
            else begin
                peri = 0;
            end
        end
    end
    // Create wires for output side
    reg wrEnableCwoV0, wrEnableCwoV1, wrEnableCcwoV0, wrEnableCcwoV1, wrEnablePeoV0, wrEnablePeoV1;
    wire rdEnableCwoV0, rdEnableCwoV1, rdEnableCcwoV0, rdEnableCcwoV1, rdEnablePeoV0, rdEnablePeoV1;
    wire emptyCwoV0, emptyCwoV1, emptyCcwoV0, emptyCcwoV1, emptyPeoV0, emptyPeoV1;
    wire fullCwoV0, fullCwoV1, fullCcwoV0, fullCcwoV1, fullPeoV0, fullPeoV1;
    reg [PACKET_SIZE-1:0] dataInCwoV0, dataInCwoV1, dataInCcwoV0, dataInCcwoV1, dataInPeoV0, dataInPeoV1;
    wire [PACKET_SIZE-1:0] dataOutCwoV0, dataOutCwoV1, dataOutCcwoV0, dataOutCcwoV1, dataOutPeoV0, dataOutPeoV1;

    // Create 6 single-location output buffers (3 output channels each having 2 virtual channels each)

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwoV0),
        .rdEnable(rdEnableCwoV0),
        .dataIn(dataInCwoV0),
        .dataOut(dataOutCwoV0),
        .full(fullCwoV0),
        .empty(emptyCwoV0)
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCwoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCwoV1),
        .rdEnable(rdEnableCwoV1),
        .dataIn(dataInCwoV1),
        .dataOut(dataOutCwoV1),
        .full(fullCwoV1),
        .empty(emptyCwoV1)
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwoV0),
        .rdEnable(rdEnableCcwoV0),
        .dataIn(dataInCcwoV0),
        .dataOut(dataOutCcwoV0),
        .full(fullCcwoV0),
        .empty(emptyCcwoV0)
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufCcwoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnableCcwoV1),
        .rdEnable(rdEnableCcwoV1),
        .dataIn(dataInCcwoV1),
        .dataOut(dataOutCcwoV1),
        .full(fullCcwoV1),
        .empty(emptyCcwoV1)
    );

    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeoV0
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeoV0),
        .rdEnable(rdEnablePeoV0),
        .dataIn(dataInPeoV0),
        .dataOut(dataOutPeoV0),
        .full(fullPeoV0),
        .empty(emptyPeoV0)
    );
    bufferDepth1 #(.WIDTH(PACKET_SIZE)) bufPeoV1
    (
        .clk(clk),
        .reset(reset),
        .wrEnable(wrEnablePeoV1),
        .rdEnable(rdEnablePeoV1),
        .dataIn(dataInPeoV1),
        .dataOut(dataOutPeoV1),
        .full(fullPeoV1),
        .empty(emptyPeoV1)
    );

    //Wires for sending requests from input buffer to output buffer
    reg reqCwiCwo, reqCwiPeo;
    reg reqCcwiCcwo, reqCcwiPeo;
    reg reqPeiCwo, reqPeiCcwo;

    /*  Request Signal Logic
        Every input buffer will send requests to the arbiter of one of the output buffers
        If input buffer is full and the output buffer is empty, then it will send a request to the output buffer
        The target output buffer is determined by direction and hop-value
    */
    always @(*) begin
        {reqCwiCwo, reqCwiPeo, reqCcwiCcwo, reqCcwiPeo, reqPeiCwo, reqPeiCcwo} = 6'b0;
        
        if (evenOdd) begin // Internally service channel 0
            if (fullCwiV0 && dataCwiV0[48] && emptyCwoV0) begin // Bit 48 is the LSB of hop-value
                reqCwiCwo = 1;
            end
            if (fullCwiV0 && !dataCwiV0[48] && emptyPeoV0) begin
                reqCwiPeo = 1;
            end

            if (fullCcwiV0 && dataCcwiV0[48] && emptyCcwoV0) begin
                reqCcwiCcwo = 1;
            end
            if (fullCcwiV0 && !dataCcwiV0[48] && emptyPeoV0) begin
                reqCcwiPeo = 1;
            end

            // Check dir bit for processing element
            if (fullPeiV0 && dataPeiV0[62] && emptyCwoV0) begin // Bit 62 is dir
                reqPeiCwo = 1;
            end
            if (fullPeiV0 && !dataCcwiV0[62] && emptyCcwoV0) begin
                reqPeiCcwo = 1;
            end
        end
        else begin // Internally service channel 1
            if (fullCwiV1 && dataCwiV1[48] && emptyCwoV1) begin // Bit 48 is the LSB of hop-value
                reqCwiCwo = 1;
            end
            if (fullCwiV1 && !dataCwiV1[48] && emptyPeoV1) begin
                reqCwiPeo = 1;
            end

            if (fullCcwiV1 && dataCcwiV1[48] && emptyCcwoV1) begin
                reqCcwiCcwo = 1;
            end
            if (fullCcwiV1 && !dataCcwiV1[48] && emptyPeoV1) begin
                reqCcwiPeo = 1;
            end

            // Check dir bit for processing element
            if (fullPeiV1 && dataPeiV1[62] && emptyCwoV1) begin // Bit 62 is dir
                reqPeiCwo = 1;
            end
            if (fullPeiV1 && !dataCcwiV1[62] && emptyCcwoV1) begin
                reqPeiCcwo = 1;
            end
        end
    end

    // Wires for the 3 arbiters which are made using rotating prioritizers
    wire grantCwiCwo, grantCwiPeo;
    wire grantCcwiCcwo, grantCcwiPeo;
    wire grantPeiCwo, grantPeiCcwo;

    rotatingPrioritizer arbiterCwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCwiCwo),
        .req1(reqPeiCwo),
        .grant0(grantCwiCwo),
        .grant1(grantCwiPeo)
    );

    rotatingPrioritizer arbiterCcwo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCcwiCcwo),
        .req1(reqPeiCcwo),
        .grant0(grantCcwiCcwo),
        .grant1(grantCcwiPeo)
    );

    rotatingPrioritizer arbiterPeo
    (
        .clk(clk),
        .reset(reset),
        .polarity(evenOdd),
        .req0(reqCwiPeo),
        .req1(reqCcwiPeo),
        .grant0(grantPeiCwo),
        .grant1(grantPeiCcwo)
    );

    



    
endmodule