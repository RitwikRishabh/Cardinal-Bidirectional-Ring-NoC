module alu #(
    parameter DATA_WIDTH = 64
) (
    input [0:DATA_WIDTH-1] rAex, rBex,
    input [0:5] functionCodeEX,
    input [0:1] wwEX,
    output reg [0:DATA_WIDTH-1] rDex
);
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

//----------------------------------------------Adders----------------------------------------------//
    /*  vaddx - Variable Width Add
        vsubx - Variable Width Sub
        Since both add and subtract use the same adder elements
        we can use a single adder array for both operations
        Because of WW field the maximum number of adders needed
        are 8. So we instantiate 8 8-bit wide adders and combine then based on
        the WW field
    */
    wire [0:7] carryIn, carryOut;
    wire addSub;
    wire [0:DATA_WIDTH-1] sumDiff;

    assign addSub = functionCodeEX == VADD ? 1'b1 : 1'b0; // 1==ADD, 0==SUB

    DW01_addsub #(
        .width(8)
    )
    addSub0
    (
        .A(rAex[0:7]),
        .B(rBex[0:7]),
        .CI(carryIn[0]),
        .CO(carryOut[0]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[0:7])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub1
    (
        .A(rAex[8:15]),
        .B(rBex[8:15]),
        .CI(carryIn[1]),
        .CO(carryOut[1]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[8:15])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub2
    (
        .A(rAex[16:23]),
        .B(rBex[16:23]),
        .CI(carryIn[2]),
        .CO(carryOut[2]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[16:23])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub3
    (
        .A(rAex[24:31]),
        .B(rBex[24:31]),
        .CI(carryIn[3]),
        .CO(carryOut[3]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[24:31])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub4
    (
        .A(rAex[32:39]),
        .B(rBex[32:39]),
        .CI(carryIn[4]),
        .CO(carryOut[4]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[32:39])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub5
    (
        .A(rAex[40:47]),
        .B(rBex[40:47]),
        .CI(carryIn[5]),
        .CO(carryOut[5]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[40:47])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub6
    (
        .A(rAex[48:55]),
        .B(rBex[48:55]),
        .CI(carryIn[6]),
        .CO(carryOut[6]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[48:55])
    );

    DW01_addsub #(
        .width(8)
    )
    addSub7
    (
        .A(rAex[56:63]),
        .B(rBex[56:63]),
        .CI(carryIn[7]),
        .CO(carryOut[7]),
        .ADD_SUB(addSub),
        .SUM(sumDiff[56:63])
    );

    //Check the WW field and connect the carry outs
    assign carryOut[0] = (wwEX == bMode) ? 1'b0 : carryIn[1];
    assign carryOut[1] = (wwEX == bMode) || (wwEX == hMode) ? 1'b0 : carryIn[2];
    assign carryOut[2] = (wwEX == bMode) ? 1'b0 : carryIn[3];
    assign carryOut[3] = (wwEX == bMode) || (wwEX == hMode) || (wwEX == wMode) ? 1'b0 : carryIn[4];
    assign carryOut[4] = (wwEX == bMode) ? 1'b0 : carryIn[5];
    assign carryOut[5] = (wwEX == bMode) || (wwEX == hMode) ? 1'b0 : carryIn[6];
    assign carryOut[6] = (wwEX == bMode) ? 1'b0 : carryIn[7];
    assign carryOut[7] = 1'b0;
//--------------------------------------------End Adders--------------------------------------------//

//--------------------------------------------Multipliers-------------------------------------------//
    /*  
    */
//------------------------------------------End Multipliers-----------------------------------------//

    
endmodule