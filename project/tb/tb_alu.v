`timescale 1ns/1ps

module tb_alu;
    reg [0:63] rA, rB;
    reg [0:5] functionCode;
    reg [0:1] ww;
    wire [0:63] rD;
    integer fp;

    //Function Codes
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

    //WW Field
    localparam bMode = 2'b00; // Byte 
    localparam hMode = 2'b01; // Half-word
    localparam wMode = 2'b10; // Word
    localparam dMode = 2'b11; // DWord

    alu aluDUT(
        .rAex(rA),
        .rBex(rB),
        .functionCodeEX(functionCode),
        .wwEX(ww),
        .rDex(rD)
    );

    task sendPacket(input reg [0:5] code, input reg [0:1] mode);
    begin
        #10
        rA = 64'hffffffffffffffff;
        rB = 64'hffffffffffffffff;
        functionCode = code;
        ww = mode;
    end
    endtask

    initial begin
        fp = $fopen("alu.out", "w");
        $fmonitor(fp, "Function Code = %b : rA = %h, rB = %h, ww = %b, rD = %h", functionCode, rA, rB, ww, rD);

        //AND
        sendPacket(VAND, dMode);
        //OR
        sendPacket(VOR, dMode);
        //XOR
        sendPacket(VXOR, dMode);
        //NOT
        sendPacket(VNOT, dMode);
        //MOV
        sendPacket(VMOV, dMode);
        //ADD
        sendPacket(VADD, bMode);
        sendPacket(VADD, hMode);
        sendPacket(VADD, wMode);
        sendPacket(VADD, dMode);
        //SUB
        sendPacket(VSUB, bMode);
        sendPacket(VSUB, hMode);
        sendPacket(VSUB, wMode);
        sendPacket(VSUB, dMode);
        //MULEU
        sendPacket(VMULEU, bMode);
        sendPacket(VMULEU, hMode);
        sendPacket(VMULEU, wMode);
        //MULOU
        sendPacket(VMULOU, bMode);
        sendPacket(VMULOU, hMode);
        sendPacket(VMULOU, wMode);
        //SLL
        sendPacket(VSLL, bMode);
        sendPacket(VSLL, hMode);
        sendPacket(VSLL, wMode);
        sendPacket(VSLL, dMode);
        //SRL
        sendPacket(VSRL, bMode);
        sendPacket(VSRL, hMode);
        sendPacket(VSRL, wMode);
        sendPacket(VSRL, dMode);
        //SRA
        sendPacket(VSRA, bMode);
        sendPacket(VSRA, hMode);
        sendPacket(VSRA, wMode);
        sendPacket(VSRA, dMode);
        //RTTH
        sendPacket(VRTTH, bMode);
        sendPacket(VRTTH, hMode);
        sendPacket(VRTTH, wMode);
        sendPacket(VRTTH, dMode);
        //DIV
        sendPacket(VDIV, bMode);
        sendPacket(VDIV, hMode);
        sendPacket(VDIV, wMode);
        sendPacket(VDIV, dMode);
        //MOD
        sendPacket(VMOD, bMode);
        sendPacket(VMOD, hMode);
        sendPacket(VMOD, wMode);
        sendPacket(VMOD, dMode);
        //SQEU
        sendPacket(VSQEU, bMode);
        sendPacket(VSQEU, hMode);
        sendPacket(VSQEU, wMode);
        //SQOU
        sendPacket(VSQOU, bMode);
        sendPacket(VSQOU, hMode);
        sendPacket(VSQOU, wMode);
        //SQRT
        sendPacket(VSQRT, bMode);
        sendPacket(VSQRT, hMode);
        sendPacket(VSQRT, wMode);
        sendPacket(VSQRT, dMode);

        // $stop;


    end

endmodule