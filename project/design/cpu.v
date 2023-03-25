// Module is in big endian so all multi-bit ports and wires are instatiated as [0:MSB]
`include "./design/REGFILE32x64.v"
`include "./design/alu.v"

module cpu #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter INSTR_WIDTH = 32
) (
    input clk, reset, // synchronous active high

    input [0:INSTR_WIDTH-1] instrIn,
    output [0:INSTR_WIDTH-1] instrAddr,

    input [0:DATA_WIDTH-1] dmemDataIn,
    output [0:DATA_WIDTH-1] dmemDataout,
    output [0:ADDR_WIDTH-1] dmemAddr,
    output dmemEn, dmemWrEn,

    input [0:DATA_WIDTH-1] nicDataIn,
    output [0:DATA_WIDTH-1] nicDataOut,
    output [0:1] nicAddr,
    output nicEn, nicWrEn
);
//---------------------------------Defines---------------------------------//
    // Wires
    wire stall;
    reg branch;
    reg [0:ADDR_WIDTH-1] branchAddr;
    // Opcodes
    localparam RTYPE_ALU     = 6'b101010; // ALU operations
    localparam RTYPE_BEZ     = 6'b100010; // Branch equal zero
    localparam RTYPE_BNEZ    = 6'b100011; // Branch equal not zero
    localparam RTYPE_NOP     = 6'b111100; // NOP
    localparam MTYPE_LW      = 6'b100000; // Load Word
    localparam MTYPE_SW      = 6'b100001; // Store Word

    //ALU function codes
    localparam VADD     = 6'b000110;
    localparam VSUB     = 6'b000111;
    localparam VMULEU   = 6'b001000;
    localparam VMULOU   = 6'b001001;
    localparam VSLL     = 6'b001010;
    localparam VSRL     = 6'b001011;
    localparam VSRA     = 6'b001100;
    localparam VDIV     = 6'b001110;
    localparam VMOD     = 6'b001111;
    localparam VSQEU    = 6'b010000;
    localparam VSQOU    = 6'b010001;
    localparam VSQRT    = 6'b010010;

    // PPP modes
    localparam aModePPP = 3'b000;
    localparam uModePPP = 3'b001;
    localparam dModePPP = 3'b010;
    localparam eModePPP = 3'b011;
    localparam oModePPP = 3'b100;
//-------------------------------End Defines-------------------------------//

//---------------------------------IF Stage--------------------------------//
    // Program Counter
    reg [0:INSTR_WIDTH-1] pc;
    assign instrAddr = pc;

    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end
        else begin
            if (stall) begin
                pc <= pc;
            end
            else if (branch) begin
                pc <= branchAddr;
            end
            else begin
                pc <= pc + 4;
            end
        end
    end

    // Stage Register update
    reg [0:INSTR_WIDTH-1] regIF_ID;
    always @(posedge clk) begin
        if (reset) begin
            regIF_ID <= 0;
        end
        else begin
            if (stall) begin
                regIF_ID <= regIF_ID;
            end
            else if (branch) begin
                // Need to flush IF/ID register
                regIF_ID[0:5] <= RTYPE_NOP; // Big endian
            end
            else begin
                regIF_ID <= instrIn;
            end
        end
    end
//-------------------------------End IF Stage------------------------------//

//---------------------------------ID Stage--------------------------------//
    // Decode Instructions
    wire [0:5] opcodeID, functionCodeID;
    wire [0:4] rDid, rAid, rBid;
    wire [0:2] pppID;
    wire [0:1] wwID;
    wire [0:15] immediateAddrID;

    assign opcodeID           = regIF_ID[0:5];
    assign rDid               = regIF_ID[6:10];
    assign rAid               = regIF_ID[11:15];
    assign rBid               = regIF_ID[16:20];
    assign pppID              = opcodeID == MTYPE_LW ? 3'b000 : regIF_ID[21:23];
    assign wwID               = regIF_ID[24:25];
    assign functionCodeID     = regIF_ID[26:31];
    assign immediateAddrID    = regIF_ID[16:31];

    // Reg file
    reg [0:$clog2(ADDR_WIDTH)-1] regFileRdAddr0, regFileRdAddr1;
    wire [0:DATA_WIDTH-1] regFileRdDataOut0, regFileRdDataOut1;
    wire regFileWrEnWB; // Write Enable from WB stage
    wire [0:2] pppWB;
    wire [0:$clog2(ADDR_WIDTH)-1] regFileWrAddrWB;
    wire [0:DATA_WIDTH-1] regFileDataInWB;

    REGFILE32x64 regFile(
        .clk(clk),
        .reset(reset),
        .wrEn(regFileWrEnWB),
        .wrAddr(regFileWrAddrWB),
        .dataIn(regFileDataInWB),
        .ppp(pppWB),
        .rdAddr0(regFileRdAddr0),
        .rdAddr1(regFileRdAddr1),
        .dataOut0(regFileRdDataOut0),
        .dataOut1(regFileRdDataOut1)
    );

    always @(*) begin
        if (opcodeID == MTYPE_SW || opcodeID == RTYPE_BEZ || opcodeID == RTYPE_BNEZ) begin
            regFileRdAddr0 = rDid;
        end
        else begin
            regFileRdAddr0 = rAid;
        end
        regFileRdAddr1 = rBid;
    end

    // Control Unit
    reg dmemEnID, dmemWrEnID, nicEnID, nicWrEnID, regFileWrEnID;
    always @(*) begin       
        case (opcodeID)
            RTYPE_ALU : begin
                regFileWrEnID = 1;
            end
            MTYPE_LW: begin
                regFileWrEnID = 1;
                dmemEnID = 1;
            end
            MTYPE_SW: begin
                dmemWrEnID = 1;
                dmemEnID = 1;
            end
            default: 
            {dmemEnID, dmemWrEnID, nicEnID, nicWrEnID, regFileWrEnID} = 5'b00000;
        endcase
    end

    // Stall signals destination register cannot be R0
    // Stall due to LW and SW
    wire stallLWSWid;
    assign stallLWSWid = (opcodeID == MTYPE_SW) || (opcodeID == MTYPE_LW) && (rDid != 0);
    // Stall due to DIV and MOD 
    wire stallDIVMODid;
    assign stallDIVMODid = (opcodeID == RTYPE_ALU) && ((functionCodeID == VDIV) || (functionCodeID == VMOD));
    // Stall due to MULT, SQAURE
    wire stallMULTSQid;
    assign stallMULTSQid = (opcodeID == RTYPE_ALU) && ((functionCodeID == VMULEU) || (functionCodeID == VMULOU) || 
                                (functionCodeID == VSQEU) || (functionCodeID == VSQOU)) && (rDid != 0);
    // Stall due to ADD, SUB
    wire stallADDSUBid;
    assign stallADDSUBid = (opcodeID == RTYPE_ALU) && ((functionCodeID == VADD) && (functionCodeID == VSUB)) && (rDid != 0);
    // Stall due to SQRT
    wire stallSQRTid;
    assign stallSQRTid = (opcodeID == RTYPE_ALU) && (functionCodeID == VSQRT) && (rDid != 0);
    // Stall due to SLL, SRL, SRA
    wire stallSLLSRLSRAid;
    assign stallSLLSRLSRAid = (opcodeID == RTYPE_ALU) && ((functionCodeID == VSLL) || (functionCodeID == VSRL) ||
                                (functionCodeID == VSRA)) && (rDid != 0);
    
    // HDU
    reg hduRAid, hduRBid;
    wire [0:$clog2(INSTR_WIDTH)-1] rDex;
    wire regFileWrEnEx;
    always @(*) begin
        hduRAid = 0;
        hduRBid = 0;
        if ((regFileWrEnEx) && (rDex != 0)) begin
            if (rDex == regFileRdAddr0) begin
                hduRAid = 1;
            end
            if (rDex == regFileRdAddr1) begin
                hduRBid = 1;
            end
        end
    end

    // FU
    reg [0:DATA_WIDTH-1] regFileRdDataOut0ID, regFileRdDataOut1ID, regFileWrDataInEX;
    wire [0:2] pppEX;
    always @(*) begin
        regFileRdDataOut0ID = regFileRdDataOut0;
        regFileRdDataOut1ID = regFileRdDataOut1;

        if (hduRAid) begin
            if (pppEX == aModePPP) begin
                regFileRdDataOut0ID = regFileWrDataInEX;
            end
            else if (pppEX == uModePPP) begin
                regFileRdDataOut0ID[0:31] = regFileWrDataInEX[0:31];
            end
            else if (pppEX == dModePPP) begin
                regFileRdDataOut0ID[32:63] = regFileWrDataInEX[32:63];
            end
            else if (pppEX == eModePPP) begin
                regFileRdDataOut0ID[0:7] = regFileWrDataInEX[0:7];
                regFileRdDataOut0ID[16:23] = regFileWrDataInEX[16:23];
                regFileRdDataOut0ID[32:39] = regFileWrDataInEX[32:39];
                regFileRdDataOut0ID[48:55] = regFileWrDataInEX[48:55];
            end
            else if (pppEX == oModePPP) begin
                regFileRdDataOut0ID[8:15] = regFileWrDataInEX[8:15];
                regFileRdDataOut0ID[24:31] = regFileWrDataInEX[24:31];
                regFileRdDataOut0ID[40:47] = regFileWrDataInEX[40:47];
                regFileRdDataOut0ID[56:63] = regFileWrDataInEX[56:63];
            end
        end

        if (hduRBid) begin
            if (pppEX == aModePPP) begin
                regFileRdDataOut1ID = regFileWrDataInEX;
            end
            else if (pppEX == uModePPP) begin
                regFileRdDataOut1ID[0:31] = regFileWrDataInEX[0:31];
            end
            else if (pppEX == dModePPP) begin
                regFileRdDataOut1ID[32:63] = regFileWrDataInEX[32:63];
            end
            else if (pppEX == eModePPP) begin
                regFileRdDataOut1ID[0:7] = regFileWrDataInEX[0:7];
                regFileRdDataOut1ID[16:23] = regFileWrDataInEX[16:23];
                regFileRdDataOut1ID[32:39] = regFileWrDataInEX[32:39];
                regFileRdDataOut1ID[48:55] = regFileWrDataInEX[48:55];
            end
            else if (pppEX == oModePPP) begin
                regFileRdDataOut1ID[8:15] = regFileWrDataInEX[8:15];
                regFileRdDataOut1ID[24:31] = regFileWrDataInEX[24:31];
                regFileRdDataOut1ID[40:47] = regFileWrDataInEX[40:47];
                regFileRdDataOut1ID[56:63] = regFileWrDataInEX[56:63];
            end
        end
    end

    // Branch
    always @(*) begin
        branch = 0;
        branchAddr = {16'b0, immediateAddrID};

        if ((opcodeID == RTYPE_BEZ) && (regFileRdDataOut0ID == 0)) begin
            branch = 1;
        end
        if ((opcodeID == RTYPE_BNEZ) && (regFileRdDataOut0ID != 0)) begin
            branch = 1;
        end
    end

    
    // Assign data memory outputs
    assign dmemEn = dmemEnID;
    assign dmemWrEn = dmemWrEnID;
    assign dmemAddr = branchAddr;
    assign dmemDataout = regFileRdDataOut0ID;

    // ID/EX Stage Register
    reg [0:156] regID_EX;

    always @(posedge clk) begin
        if (reset) begin
            regID_EX <= 0;
        end
        else begin
            if (!stall) begin
                // Data
                regID_EX[0:63] <= regFileRdDataOut0ID;
                regID_EX[64:127] <= regFileRdDataOut1ID;
                // Control
                regID_EX [128:132] <= {dmemEnID, dmemWrEnID, nicEnID, nicWrEnID, regFileWrEnID};
                regID_EX [133:137] <= rDid;
                regID_EX [138:140] <= pppID;
                regID_EX [141:142] <= wwID;
                regID_EX [143:148] <= functionCodeID;
                regID_EX [149:150] <= immediateAddrID[14:15]; // NIC address
                // Stall
                regID_EX [151] <= stallLWSWid;
                regID_EX [152] <= stallADDSUBid;
                regID_EX [153] <= stallMULTSQid;
                regID_EX [154] <= stallDIVMODid;
                regID_EX [155] <= stallSQRTid;
                regID_EX [156] <= stallSLLSRLSRAid;
            end
        end
    end
//-------------------------------End ID Stage------------------------------//

//---------------------------------EX Stage--------------------------------//
    // Create wires
    wire dmemEnEX, dmemWrEnEX, nicEnEX, nicWrEnEX;
    wire stallLWSWex, stallADDSUBex, stallMULTSQex, stallDIVMODex, stallSQRTex, stallSLLSRLSRAex;
    wire [0:5] functionCodeEX;
    wire [0:1] wwEX;
    wire [0:1] nicAddrEX;

    //Assign wires to stage reg
    assign rDex = regID_EX[133:137];
    assign pppEX = regID_EX[138:140];
    assign wwEX = regID_EX[141:142];
    assign functionCodeEX = regID_EX[143:148];

    assign nicAddrEX = regID_EX[149:150];
    assign nicDataOut = regID_EX[0:63];
    assign {dmemEnEX, dmemWrEnEX, nicEnEX, nicWrEnEX, regFileWrEnEx} = regID_EX [128:132];

    assign stallLWSWex = regID_EX[151];
    assign stallADDSUBex = regID_EX[152];
    assign stallMULTSQex = regID_EX[153];
    assign stallDIVMODex = regID_EX[154];
    assign stallSQRTex = regID_EX[155];
    assign stallSLLSRLSRAex = regID_EX[156];

    // Assign output control signals
    assign nicEn = nicEnEX;
    assign nicWrEn = nicWrEnEX;

    // ALU
    wire [0:DATA_WIDTH-1] rAex, rBex, aluDataOut;
    assign rAex = regID_EX[0:63];
    assign rBex = regID_EX[64:127];

    alu #(
        .DATA_WIDTH(DATA_WIDTH)
    )
    cardinalALU(
        .rAex(rAex),
        .rBex(rBex),
        .functionCodeEX(functionCodeEX),
        .wwEX(wwEX),
        .rDex(aluDataOut)
    );

    // Generate stalls
    // 1 clock stall for memory access
    wire stallMem;
    reg memCounter;
    always @(posedge clk) begin
        if (reset) begin
            memCounter <= 0;
        end
        else begin
            if (stallLWSWex) begin
                memCounter <= memCounter + 1;
            end
        end
    end
    assign stallMem = stallLWSWex && !memCounter ? 1'b1 : 1'b0;

    // 5 clock stall for div and mod and sqrt
    wire stall5DivModSqrt;
    reg [0:2] stall5Counter;
    always @(posedge clk) begin
        if (reset) begin
            stall5Counter <= 0;
        end
        else begin
            if (stallDIVMODex || stallSQRTex) begin
                if (stall5Counter == 4) begin
                    stall5Counter <= 0;
                end
                else begin
                    stall5Counter <= stall5Counter + 1;
                end
            end
        end
    end
    assign stall5DivModSqrt = (((stallDIVMODex) || (stallSQRTex)) && (stall5Counter <= 3)) ? 1'b1 : 1'b0;

    // 4 clock stall for mult square
    wire stall4MultSq;
    reg [0:1] stall4Counter;
    always @(posedge clk) begin
        if (reset) begin
            stall4Counter <= 0;
        end
        else begin
            if (stallMULTSQex) begin
                stall4Counter <= stall4Counter + 1;
            end
        end
    end
    assign stall4MultSq = ((stallMULTSQex) && (stall4Counter <= 2)) ? 1'b1 : 1'b0;

    // 3 clock stall for add sub and shift operations
    wire stall3;
    reg [0:1] stall3Counter;
    always @(posedge clk) begin
        if (reset) begin
            stall3Counter <= 0;
        end
        else begin
            if (stallDIVMODex || stallSQRTex) begin
                if (stall3Counter == 2) begin
                    stall3Counter <= 0;
                end
                else begin
                    stall3Counter <= stall3Counter + 1;
                end
            end
        end
    end
    assign stall3 = (((stallADDSUBex) || (stallSLLSRLSRAex)) && (stall3Counter <= 1)) ? 1'b1 : 1'b0;

    assign stall = (stallMem) || (stall3) || (stall4MultSq) || (stall5DivModSqrt) ? 1'b1 : 1'b0;

    // Reg file write data
    always @(*) begin
        regFileWrDataInEX = aluDataOut; // default value
        if (dmemEnEX) begin
            regFileWrDataInEX = dmemDataIn;
        end
        else if (nicEnEX) begin
            regFileWrDataInEX = nicDataIn;
        end
    end

    // There is no WB stage so no need for a stage register
    assign regFileDataInWB = regFileWrDataInEX;
    assign regFileWrEnWB = regFileWrEnEx;
    assign pppWB = pppEX;
    assign regFileWrAddrWB = rDex;
    assign nicAddr = nicAddrEX;
//-------------------------------End EX Stage------------------------------//
    
endmodule