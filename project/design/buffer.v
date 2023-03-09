/*
*/
module bufferDepth1 #(
    parameter WIDTH = 64
) (
    input clk, reset,
    input wrEnable, rdEnable,
    input [WIDTH-1:0] dataIn,

    output [WIDTH-1:0] dataOut,
    output full, empty
);

    reg [WIDTH-1:0] memory;                     // Memory to store the data
    reg fullFlag;                               // Flag indicating buffer is full (1) or empty (0)
    reg [WIDTH-1:0] dataOutTemp;                // Temporary reg to store read data
    
    //----------------------------------------------------Continuous Assignment----------------------------------------------------//
    assign full = fullFlag;
    assign empty = ~fullFlag;
    assign dataOut = dataOutTemp;
    //------------------------------------------------------Procedural Block-------------------------------------------------------//
    
    always @(posedge clk) begin
        if (reset) begin
            memory <= 0;
            fullFlag <= 0;
            dataOutTemp <= 0;
        end
        else begin
            if (wrEnable & (!fullFlag)) begin
                memory <= dataIn;
                fullFlag <= 1;
            end
            if (rdEnable & fullFlag) begin
                dataOutTemp <= memory;
                fullFlag <= 0;
            end
        end
    end
endmodule