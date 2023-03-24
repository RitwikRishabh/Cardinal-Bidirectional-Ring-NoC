module REGFILE32x64 #(
    parameter DEPTH = 32,
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input clk, reset, // synchronous active high reset
    input wrEn, // write enable
    // 1 write port 2 read ports
    input [0:DATA_WIDTH-1] dataIn,
    input [0:2] ppp,
    input [0:ADDR_WIDTH-1] wrAddr, rdAddr0, rdAddr1,
    output reg [0:DATA_WIDTH-1] dataOut0, dataOut1
);

    localparam aModePPP = 3'b000;
    localparam uModePPP = 3'b001;
    localparam dModePPP = 3'b010;
    localparam eModePPP = 3'b011;
    localparam oModePPP = 3'b100;

//------------------------------------Instantiate Memory--------------------------//
    reg [0:DATA_WIDTH-1] regFile [DEPTH-1:0];
    reg [0:DEPTH] resetRegCount; // Variable to reset the regfile
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