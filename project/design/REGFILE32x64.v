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
    reg [0:$clog2(DEPTH)] resetRegCount; // Variable to reset the regfile
//----------------------------------End Instantiate Memory------------------------//

//------------------------------------Read Data-----------------------------------//
    always @(*) begin // Asynchronous Read
        regFile[0] = 0; // R0 hardcoded to 0;
        dataOut0 = regFile[rdAddr0];
        dataOut1 = regFile[rdAddr1];
        // If read and write address match then bypass
        if (wrEn && (wrAddr == rdAddr0)) begin
            case (ppp)
                aModePPP : begin
                    dataOut0 = dataIn;
                end
                uModePPP : begin
                    dataOut0[0:31] = dataIn[0:31];
                end
                dModePPP : begin
                    dataOut0[32:63] = dataIn[32:63];
                end
                eModePPP : begin
                    dataOut0[0:7] = dataIn[0:7];
                    dataOut0[16:23] = dataIn[16:23];
                    dataOut0[32:39] = dataIn[32:39];
                    dataOut0[48:55] = dataIn[48:55];
                end
                oModePPP : begin
                    dataOut0[8:15] = dataIn[8:15];
                    dataOut0[24:31] = dataIn[24:31];
                    dataOut0[40:47] = dataIn[40:47];
                    dataOut0[56:63] = dataIn[56:63];
                end
            endcase
        end
        if (wrEn && (wrAddr == rdAddr1)) begin
            case (ppp)
                aModePPP : begin
                    dataOut1 = dataIn;
                end
                uModePPP : begin
                    dataOut1[0:31] = dataIn[0:31];
                end
                dModePPP : begin
                    dataOut1[32:63] = dataIn[32:63];
                end
                eModePPP : begin
                    dataOut1[0:7] = dataIn[0:7];
                    dataOut1[16:23] = dataIn[16:23];
                    dataOut1[32:39] = dataIn[32:39];
                    dataOut1[48:55] = dataIn[48:55];
                end
                oModePPP : begin
                    dataOut1[8:15] = dataIn[8:15];
                    dataOut1[24:31] = dataIn[24:31];
                    dataOut1[40:47] = dataIn[40:47];
                    dataOut1[56:63] = dataIn[56:63];
                end
            endcase
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
                case (ppp)
                    aModePPP : begin
                        regFile[wrAddr] <= dataIn;
                    end
                    uModePPP : begin
                        regFile[wrAddr][0:31] <= dataIn[0:31];
                    end
                    dModePPP : begin
                        regFile[wrAddr][32:63] <= dataIn[32:63];
                    end
                    eModePPP : begin
                        regFile[wrAddr][0:7] <= dataIn[0:7];
                        regFile[wrAddr][16:23] <= dataIn[16:23];
                        regFile[wrAddr][32:39] <= dataIn[32:39];
                        regFile[wrAddr][48:55] <= dataIn[48:55];
                    end
                    oModePPP : begin
                        regFile[wrAddr][8:15] <= dataIn[8:15];
                        regFile[wrAddr][24:31] <= dataIn[24:31];
                        regFile[wrAddr][40:47] <= dataIn[40:47];
                        regFile[wrAddr][56:63] <= dataIn[56:63];
                    end
                endcase
            end
        end
    end
//----------------------------------End Write Data--------------------------------//

    
endmodule