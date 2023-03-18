module REGFILE32x64 #(
    parameter DEPTH = 32,
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input clk, reset, // synchronous active high reset
    input wrEn, // write enable
    // 1 write port 2 read ports
    input [DATA_WIDTH-1:0] dataIn,
    input [ADDR_WIDTH-1:0] wrAddr, rdAddr0, rdAddr1,
    output reg [DATA_WIDTH-1:0] dataOut0, dataOut1
);
//------------------------------------Instantiate Memory--------------------------//
    reg [DATA_WIDTH-1:0] regFile [0:DEPTH-1];
    reg [DEPTH:0] resetRegCount; // Variable to reset the regfile
//----------------------------------End Instantiate Memory------------------------//

//------------------------------------Read Data-----------------------------------//
    always @(*) begin // Asynchronous Read
        regFile[0] = 0; // R0 hardcoded to 0;
        dataOut0 = regFile[rdAddr0];
        dataOut1 = regFile[rdAddr1];
        // If read and write address match then bypass
        if (wrEn && (wrAddr == rdAddr0)) begin
            dataOut0 = dataIn;
        end
        if (wrEn && (wrAddr == rdAddr1)) begin
            dataOut1 = dataIn;
        end
    end
//----------------------------------End Read Data---------------------------------//

//-----------------------------------Write Data-----------------------------------//
    always @(posedge clk) begin
        if (reset) begin
            for (resetRegCount = 1; resetRegCount < DEPTH; resetRegCount = resetRegCount + 1) begin // No need to reset R0 as it is always 0
                regFile[resetRegCount] <= 0;                
            end
        end
        else begin
            if (wrEn && wrAddr != 0) begin //R0 is read only
                regFile[wrAddr] <= dataIn;
            end
        end
    end
//----------------------------------End Write Data--------------------------------//

    
endmodule