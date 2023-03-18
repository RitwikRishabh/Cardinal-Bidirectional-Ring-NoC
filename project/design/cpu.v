// Module is in big endian so all multi-bit ports and wires are instatiated as [0:MSB]
`include "./design/REGFILE32x64.v"
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
    wire branch;
    reg [0:ADDR_WIDTH-1] branchAddr;
    // Opcodes
    localparam RTYPE_ALU     = 6'b101010; // ALU operations
    localparam RTYPE_BEZ     = 6'b100010; // Branch equal zero
    localparam RTYPE_BNEZ    = 6'b100011; // Bracnh equal not zero
    localparam RTYPE_NOP     = 6'b111100; // NOP
    localparam MTYPE_LW      = 6'b100000; // Load Word
    localparam MTYPE_SW      = 6'b100001; // Store Word

    //ALU function codes
    localparam VAND     = 6'b000001;
    localparam VOR      = 6'b000010;
    localparam VXOR     = 6'b000011;
    localparam VNOT     = 6'b000100;
    localparam VMOV     = 6'b000101;
    localparam VADD     = 6'b000110;
    localparam VSUB     = 6'b000111;
    localparam VMULEU   = 6'b001000;
    localparam VMULOU   = 6'b001001;
    localparam VSLL     = 6'b001010;
    localparam VSRL     = 6'b001011;
    localparam VSRA     = 6'b001100;
    localparam VRTTH    = 6'b001101;
    localparam VDIV     = 6'b001110;
    localparam VMOD     = 6'b001111;
    localparam VSQEU    = 6'b010000;
    localparam VSQOU    = 6'b010001;
    localparam VSQRT    = 6'b010010;
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
    wire [0:5] opcode, functionCode;
    wire [0:4] rD, rA, rB;
    wire [0:4] ww;
    wire [0:15] immediateAddr;

    assign opcode           = regIF_ID[0:5];
    assign rD               = regIF_ID[6:10];
    assign rA               = regIF_ID[11:15];
    assign rB               = regIF_ID[16:20];
    assign ww               = regIF_ID[21:25];
    assign functionCode     = regIF_ID[26:31];
    assign immediateAddr    = regIF_ID[16:31];

    // Reg file
    wire [0:$clog2(ADDR_WIDTH)-1] regFileRdAddr0, regFileRdAddr1;
    wire [0:DATA_WIDTH-1] regFileRdDataOut0, regFileRdDataOut1;
    wire regFileWrEnWB; // Write Enable from WB stage
    wire [0:$clog2(ADDR_WIDTH)-1] regFileWrAddrWB;
    wire [0:DATA_WIDTH-1] regFileDataInWB;

    REGFILE32x64 regFile(
        .clk(clk),
        .reset(reset),
        .wrEn(regFileWrEnWB),
        .wrAddr(regFileWrAddrWB),
        .dataIn(regFileDataInWB),
        .rdAddr0(regFileRdAddr0),
        .rdAddr1(regFileRdAddr1),
        .dataOut0(regFileRdDataOut0),
        .dataOut1(regFileRdDataOut1)
    );

    // Control Unit
    reg dmemEnReg, dmemWrEnReg, nicEnReg, nicWrEnReg, regFileWrEn;
    always @(*) begin       
        case (opcode)
            RTYPE_ALU : begin
                regFileWrEn;
            end
            MTYPE_LW: begin
                regFileWrEn = 1;
                dmemEnReg = 1;
            end
            
            default: 
        endcase
    end




//-------------------------------End ID Stage------------------------------//
    
endmodule