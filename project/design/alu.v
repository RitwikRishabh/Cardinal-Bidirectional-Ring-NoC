// `include "./include/sim_ver/DW02_mult.v"
// `include "./include/sim_ver/DW_div.v"
// `include "./include/sim_ver/DW_sqrt.v"

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

//--------------------------------------------Multipliers-------------------------------------------//
    /*  vmuleux - Variable width Multiply Even Unsigned
        vmuloux - Variable width Multiply Odd Unsigned
        vsqeux - Variable width Square Even Unsigned
        vsqoux - Variable width Square Odd Unsigned
        As the output size varies with WW field. The minimum size is 16-bit, so we instantiate
        4 8-bit wide multipliers. As there is no way to combine samller bit inputs to get larger
        products, we need to insatntiate 2 16-bit and 1 32-bit multipler as well.
    */

    reg [0:31] multInA, multInB;
    wire [0:63] productB, productH, productW; // Products of byte, half-word and word modes

    // Byte mode multipliers
    DW02_mult #(
        .A_width(8),
        .B_width(8)
    )
    multByte0(
        .A(multInA[0:7]),
        .B(multInB[0:7]),
        .TC(1'b0), //unsigned
        .PRODUCT(productB[0:15])
    );

    DW02_mult #(
        .A_width(8),
        .B_width(8)
    )
    multByte1(
        .A(multInA[8:15]),
        .B(multInB[8:15]),
        .TC(1'b0), //unsigned
        .PRODUCT(productB[16:31])
    );

    DW02_mult #(
        .A_width(8),
        .B_width(8)
    )
    multByte2(
        .A(multInA[16:23]),
        .B(multInB[16:23]),
        .TC(1'b0), //unsigned
        .PRODUCT(productB[32:47])
    );

    DW02_mult #(
        .A_width(8),
        .B_width(8)
    )
    multByte3(
        .A(multInA[24:31]),
        .B(multInB[24:31]),
        .TC(1'b0), //unsigned
        .PRODUCT(productB[48:63])
    );

    // Half word mode multipliers
    DW02_mult #(
        .A_width(16),
        .B_width(16)
    )
    multHalfWord0(
        .A(multInA[0:15]),
        .B(multInB[0:15]),
        .TC(1'b0), //unsigned
        .PRODUCT(productH[0:31])
    );

    DW02_mult #(
        .A_width(16),
        .B_width(16)
    )
    multHalfWord1(
        .A(multInA[16:31]),
        .B(multInB[16:31]),
        .TC(1'b0), //unsigned
        .PRODUCT(productH[32:63])
    );

    // Word multipliers

    DW02_mult #(
        .A_width(32),
        .B_width(32)
    )
    multWord(
        .A(multInA[0:31]),
        .B(multInB[0:31]),
        .TC(1'b0), //unsigned
        .PRODUCT(productW[0:63])
    );

    // Assign the wires based on WW field and the function code
    always @(*) begin
        multInA = 32'bx;
        multInB = 32'bx;
        case (functionCodeEX)
            VMULEU : begin // even
                if (wwEX == bMode) begin
                    multInA = {rAex[0:7], rAex[16:23], rAex[32:39], rAex[48:55]};
                    multInB = {rBex[0:7], rBex[16:23], rBex[32:39], rBex[48:55]};
                end
                else if (wwEX == hMode) begin
                    multInA = {rAex[0:15], rAex[32:47]};
                    multInB = {rBex[0:15], rBex[32:47]};
                end
                else if (wwEX == wMode) begin
                    multInA = rAex[0:31];
                    multInB = rBex[0:31];
                end
            end
            VMULOU : begin // odd
                if (wwEX == bMode) begin
                    multInA = {rAex[8:15], rAex[24:31], rAex[40:47], rAex[56:63]};
                    multInB = {rBex[8:15], rBex[24:31], rBex[40:47], rBex[56:63]};
                end
                else if (wwEX == hMode) begin
                    multInA = {rAex[16:31], rAex[48:63]};
                    multInB = {rBex[16:31], rBex[48:63]};
                end
                else if (wwEX == wMode) begin
                    multInA = rAex[32:63];
                    multInB = rBex[32:63];
                end
            end
            VSQEU : begin // even
                if (wwEX == bMode) begin
                    multInA = {rAex[0:7], rAex[16:23], rAex[32:39], rAex[48:55]};
                    multInB = {rAex[0:7], rAex[16:23], rAex[32:39], rAex[48:55]};
                end
                else if (wwEX == hMode) begin
                    multInA = {rAex[0:15], rAex[32:47]};
                    multInB = {rAex[0:15], rAex[32:47]};
                end
                else if (wwEX == wMode) begin
                    multInA = rAex[0:31];
                    multInB = rAex[0:31];
                end
            end
            VSQOU : begin // odd
                if (wwEX == bMode) begin
                    multInA = {rAex[8:15], rAex[24:31], rAex[40:47], rAex[56:63]};
                    multInB = {rAex[8:15], rAex[24:31], rAex[40:47], rAex[56:63]};
                end
                else if (wwEX == hMode) begin
                    multInA = {rAex[16:31], rAex[48:63]};
                    multInB = {rAex[16:31], rAex[48:63]};
                end
                else if (wwEX == wMode) begin
                    multInA = rAex[32:63];
                    multInB = rAex[32:63];
                end
            end
            default: begin
                multInA = 32'bx;
                multInB = 32'bx;
            end
        endcase
    end
//------------------------------------------End Multipliers-----------------------------------------//

//---------------------------------------------Shifters---------------------------------------------//
    /*  vsllx - Variable Width Shift Left Logical
        vsrlx - Variable Width Shift Right Logical
        vsrax - Variable Width Shift Right Arithmetic
        Logical shifts can be done directly using << and >> opeartors
        For arithmetic shift, a signed register is needed to copy rA value
        and then >>> can be performed
    */
    reg signed [0:DATA_WIDTH-1] rAexSigned;
    always @(*) begin
        rAexSigned = rAex;
    end
//-------------------------------------------End Shifters-------------------------------------------//

//---------------------------------------------Dividers---------------------------------------------//
    /*  vdivux - Variable Width Division Integer Unsigned
        vmodux - Variable Width Modulo Integer Unsigned
        DW_div can do both division and modulo operations by using the rem_mod(0) parameter
    */
    wire [0:DATA_WIDTH-1] divisor, dividend;
    wire [0:DATA_WIDTH-1] quotientB, remainderB; // byte mode
    wire [0:DATA_WIDTH-1] quotientH, remainderH; // half word mode
    wire [0:DATA_WIDTH-1] quotientW, remainderW; // word mode
    wire [0:DATA_WIDTH-1] quotientD, remainderD; // dword mode

    assign dividend = rAex;
    // To not have division by 0 errors we need to drive the divisor to 1 if we're not using the array
    assign divisor = ((functionCodeEX == VDIV) || (functionCodeEX == VMOD)) ? rBex : {64{1'b1}};

    // Byte mode dividers
    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB0(
        .a(dividend[0:7]),
        .b(divisor[0:7]),
        .quotient(quotientB[0:7]),
        .remainder(remainderB[0:7]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB1(
        .a(dividend[8:15]),
        .b(divisor[8:15]),
        .quotient(quotientB[8:15]),
        .remainder(remainderB[8:15]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB2(
        .a(dividend[16:23]),
        .b(divisor[16:23]),
        .quotient(quotientB[16:23]),
        .remainder(remainderB[16:23]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB3(
        .a(dividend[24:31]),
        .b(divisor[24:31]),
        .quotient(quotientB[24:31]),
        .remainder(remainderB[24:31]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB4(
        .a(dividend[32:39]),
        .b(divisor[32:39]),
        .quotient(quotientB[32:39]),
        .remainder(remainderB[32:39]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB5(
        .a(dividend[40:47]),
        .b(divisor[40:47]),
        .quotient(quotientB[40:47]),
        .remainder(remainderB[40:47]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB6(
        .a(dividend[48:55]),
        .b(divisor[48:55]),
        .quotient(quotientB[48:55]),
        .remainder(remainderB[48:55]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(8),
        .b_width(8),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divB7(
        .a(dividend[56:63]),
        .b(divisor[56:63]),
        .quotient(quotientB[56:63]),
        .remainder(remainderB[56:63]),
        .divide_by_0()
    );

    // Half word dividers
    DW_div #(
        .a_width(16),
        .b_width(16),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divH0(
        .a(dividend[0:15]),
        .b(divisor[0:15]),
        .quotient(quotientH[0:15]),
        .remainder(remainderH[0:15]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(16),
        .b_width(16),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divH1(
        .a(dividend[16:31]),
        .b(divisor[16:31]),
        .quotient(quotientH[16:31]),
        .remainder(remainderH[16:31]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(16),
        .b_width(16),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divH2(
        .a(dividend[32:47]),
        .b(divisor[32:47]),
        .quotient(quotientH[32:47]),
        .remainder(remainderH[32:47]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(16),
        .b_width(16),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divH3(
        .a(dividend[48:63]),
        .b(divisor[48:63]),
        .quotient(quotientH[48:63]),
        .remainder(remainderH[48:63]),
        .divide_by_0()
    );

    // Word dividers
    DW_div #(
        .a_width(32),
        .b_width(32),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divW0(
        .a(dividend[0:31]),
        .b(divisor[0:31]),
        .quotient(quotientW[0:31]),
        .remainder(remainderW[0:31]),
        .divide_by_0()
    );

    DW_div #(
        .a_width(32),
        .b_width(32),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divW1(
        .a(dividend[32:63]),
        .b(divisor[32:63]),
        .quotient(quotientW[32:63]),
        .remainder(remainderW[32:63]),
        .divide_by_0()
    );

    // Dword divider
    DW_div #(
        .a_width(64),
        .b_width(64),
        .tc_mode(0), // unsigned
        .rem_mode(0) // mod
    )
    divD0(
        .a(dividend[0:63]),
        .b(divisor[0:63]),
        .quotient(quotientD[0:63]),
        .remainder(remainderD[0:63]),
        .divide_by_0()
    );
//-------------------------------------------End Dividers-------------------------------------------//
    
//-------------------------------------------Sqaure Root--------------------------------------------//
    /*  Variable width Square root Integer Unsigned*/
    // Create output wires
    wire [0:DATA_WIDTH-1] rootB, rootH, rootW, rootD;

    // Root is half the size of the number so we mask the lower half (big endian)
    assign rootB[0:3] = 0;
    assign rootB[8:11] = 0;
    assign rootB[16:19] = 0;
    assign rootB[24:27] = 0;
    assign rootB[32:35] = 0;
    assign rootB[40:43] = 0;
    assign rootB[48:51] = 0;
    assign rootB [56:59] = 0;

    assign rootH[0:7] = 0;
    assign rootH[16:23] = 0;
    assign rootH[32:39] = 0;
    assign rootH[48:55] = 0;

    assign rootW[0:15] = 0;
    assign rootW[32:47] = 0;

    assign rootD[0:31] = 0;

    // Byte sqrt
    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB0(
        .a(rAex[0:7]),
        .root(rootB[4:7])
    );
    
    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB1(
        .a(rAex[8:15]),
        .root(rootB[12:15])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB2(
        .a(rAex[16:23]),
        .root(rootB[20:23])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB3(
        .a(rAex[24:31]),
        .root(rootB[28:31])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB4(
        .a(rAex[32:39]),
        .root(rootB[36:39])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB5(
        .a(rAex[40:47]),
        .root(rootB[44:47])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB6(
        .a(rAex[48:55]),
        .root(rootB[52:55])
    );

    DW_sqrt #(
        .width(8),
        .tc_mode(0) // unsigned
    )
    sqrtB7(
        .a(rAex[56:63]),
        .root(rootB[60:63])
    );

    //Half word sqrt
    DW_sqrt #(
        .width(16),
        .tc_mode(0) // unsigned
    )
    sqrtH0(
        .a(rAex[0:15]),
        .root(rootH[8:15])
    );

    DW_sqrt #(
        .width(16),
        .tc_mode(0) // unsigned
    )
    sqrtH1(
        .a(rAex[16:31]),
        .root(rootH[24:31])
    );

    DW_sqrt #(
        .width(16),
        .tc_mode(0) // unsigned
    )
    sqrtH2(
        .a(rAex[32:47]),
        .root(rootH[40:47])
    );

    DW_sqrt #(
        .width(16),
        .tc_mode(0) // unsigned
    )
    sqrtH3(
        .a(rAex[48:63]),
        .root(rootH[56:63])
    );

    // Word sqrt
    DW_sqrt #(
        .width(32),
        .tc_mode(0) // unsigned
    )
    sqrtW0(
        .a(rAex[0:31]),
        .root(rootW[16:31])
    );

    DW_sqrt #(
        .width(32),
        .tc_mode(0) // unsigned
    )
    sqrtW1(
        .a(rAex[32:63]),
        .root(rootW[48:63])
    );

    // Dword sqrt
    DW_sqrt #(
        .width(64),
        .tc_mode(1'b0) // unsigned
    )
    sqrtD0(
        .a(rAex[0:63]),
        .root(rootD[32:63])
    );
//-----------------------------------------End Sqaure Root------------------------------------------//
    
//--------------------------------------------Output MUX--------------------------------------------//
    /* Conditionally take the output from each of the different blocks
       based on the current operation
    */
    always @(*) begin
        case (functionCodeEX)
            VAND : begin
                rDex = rAex & rBex;
            end
            VOR : begin
                rDex = rAex | rBex;
            end
            VXOR : begin
                rDex = rAex ^ rBex;
            end
            VNOT : begin
                rDex = ~rAex;
            end
            VMOV : begin
                rDex = rAex;
            end
            VADD : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = rAex[0:7] + rBex[0:7];
                    rDex[8:15] = rAex[8:15] + rBex[8:15];
                    rDex[16:23] = rAex[16:23] + rBex[16:23];
                    rDex[24:31] = rAex[24:31] + rBex[24:31];
                    rDex[32:39] = rAex[32:39] + rBex[32:39];
                    rDex[40:47] = rAex[40:47] + rBex[40:47];
                    rDex[48:55] = rAex[48:55] + rBex[48:55];
                    rDex[56:63] = rAex[56:63] + rBex[56:63];
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = rAex[0:15] + rBex[0:15];
                    rDex[16:31] = rAex[16:31] + rBex[16:31];
                    rDex[32:47] = rAex[32:47] + rBex[32:47];
                    rDex[48:63] = rAex[48:63] + rBex[48:63];
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = rAex[0:31] + rBex[0:31];
                    rDex[32:63] = rAex[32:63] + rBex[32:63];
                end
                else if (wwEX == dMode) begin
                    rDex = rAex + rBex;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VSUB : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = rAex[0:7] - rBex[0:7];
                    rDex[8:15] = rAex[8:15] - rBex[8:15];
                    rDex[16:23] = rAex[16:23] - rBex[16:23];
                    rDex[24:31] = rAex[24:31] - rBex[24:31];
                    rDex[32:39] = rAex[32:39] - rBex[32:39];
                    rDex[40:47] = rAex[40:47] - rBex[40:47];
                    rDex[48:55] = rAex[48:55] - rBex[48:55];
                    rDex[56:63] = rAex[56:63] - rBex[56:63];
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = rAex[0:15] - rBex[0:15];
                    rDex[16:31] = rAex[16:31] - rBex[16:31];
                    rDex[32:47] = rAex[32:47] - rBex[32:47];
                    rDex[48:63] = rAex[48:63] - rBex[48:63];
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = rAex[0:31] - rBex[0:31];
                    rDex[32:63] = rAex[32:63] - rBex[32:63];
                end
                else if (wwEX == dMode) begin
                    rDex = rAex - rBex;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VMULEU, VMULOU, VSQEU, VSQOU : begin
                if (wwEX == bMode) begin
                    rDex = productB;
                end
                else if (wwEX == hMode) begin
                    rDex = productH;
                end
                else if (wwEX == wMode) begin
                    rDex = productW;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VSLL : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = rAex[0:7] << rBex[5:7];
                    rDex[8:15] = rAex[8:15] << rBex[13:15];
                    rDex[16:23] = rAex[16:23] << rBex[21:23];
                    rDex[24:31] = rAex[24:31] << rBex[29:31];
                    rDex[32:39] = rAex[32:39] << rBex[37:39];
                    rDex[40:47] = rAex[40:47] << rBex[45:47];
                    rDex[48:55] = rAex[48:55] << rBex[53:55];
                    rDex[56:63] = rAex[56:63] << rBex[61:63];
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = rAex[0:15] << rBex[12:15];
                    rDex[16:31] = rAex[16:31] << rBex[28:31];
                    rDex[32:47] = rAex[32:47] << rBex[44:47];
                    rDex[48:63] = rAex[48:63] << rBex[60:63];
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = rAex[0:31] << rBex[27:31];
                    rDex[32:63] = rAex[32:63] << rBex[59:63];
                end
                else if (wwEX == dMode) begin
                    rDex[0:63] = rAex[0:63] << rBex[58:63];
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VSRL : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = rAex[0:7] >> rBex[5:7];
                    rDex[8:15] = rAex[8:15] >> rBex[13:15];
                    rDex[16:23] = rAex[16:23] >> rBex[21:23];
                    rDex[24:31] = rAex[24:31] >> rBex[29:31];
                    rDex[32:39] = rAex[32:39] >> rBex[37:39];
                    rDex[40:47] = rAex[40:47] >> rBex[45:47];
                    rDex[48:55] = rAex[48:55] >> rBex[53:55];
                    rDex[56:63] = rAex[56:63] >> rBex[61:63];
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = rAex[0:15] >> rBex[12:15];
                    rDex[16:31] = rAex[16:31] >> rBex[28:31];
                    rDex[32:47] = rAex[32:47] >> rBex[44:47];
                    rDex[48:63] = rAex[48:63] >> rBex[60:63];
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = rAex[0:31] >> rBex[27:31];
                    rDex[32:63] = rAex[32:63] >> rBex[59:63];
                end
                else if (wwEX == dMode) begin
                    rDex[0:63] = rAex[0:63] >> rBex[58:63];
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VSRA : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = rAexSigned[0:7] >>> rBex[5:7];
                    rDex[8:15] = rAexSigned[8:15] >>> rBex[13:15];
                    rDex[16:23] = rAexSigned[16:23] >>> rBex[21:23];
                    rDex[24:31] = rAexSigned[24:31] >>> rBex[29:31];
                    rDex[32:39] = rAexSigned[32:39] >>> rBex[37:39];
                    rDex[40:47] = rAexSigned[40:47] >>> rBex[45:47];
                    rDex[48:55] = rAexSigned[48:55] >>> rBex[53:55];
                    rDex[56:63] = rAexSigned[56:63] >>> rBex[61:63];
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = rAexSigned[0:15] >>> rBex[12:15];
                    rDex[16:31] = rAexSigned[16:31] >>> rBex[28:31];
                    rDex[32:47] = rAexSigned[32:47] >>> rBex[44:47];
                    rDex[48:63] = rAexSigned[48:63] >>> rBex[60:63];
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = rAexSigned[0:31] >>> rBex[27:31];
                    rDex[32:63] = rAexSigned[32:63] >>> rBex[59:63];
                end
                else if (wwEX == dMode) begin
                    rDex[0:63] = rAexSigned[0:63] >>> rBex[58:63];
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VRTTH : begin
                if (wwEX == bMode) begin
                    rDex[0:7] = {rAex[4:7], rAex[0:3]};
                    rDex[8:15] = {rAex[12:15], rAex[8:11]};
                    rDex[16:23] = {rAex[20:23], rAex[16:19]};
                    rDex[24:31] = {rAex[28:31], rAex[24:27]};
                    rDex[32:39] = {rAex[36:39], rAex[32:35]};
                    rDex[40:47] = {rAex[44:47], rAex[40:43]};
                    rDex[48:55] = {rAex[52:55], rAex[48:51]};
                    rDex[56:63] = {rAex[60:63], rAex[56:59]};
                end
                else if (wwEX == hMode) begin
                    rDex[0:15] = {rAex[8:15], rAex[0:7]};
                    rDex[16:31] = {rAex[24:31], rAex[16:23]};
                    rDex[32:47] = {rAex[40:47], rAex[32:39]};
                    rDex[48:63] = {rAex[56:63], rAex[48:55]};
                end
                else if (wwEX == wMode) begin
                    rDex[0:31] = {rAex[16:31], rAex[0:15]};
                    rDex[32:63] = {rAex[48:63], rAex[32:47]};
                end
                else if (wwEX == dMode) begin
                    rDex[0:63] = {rAex[32:63], rAex[0:31]};
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VDIV : begin
                if (wwEX == bMode) begin
                    rDex = quotientB;
                end
                else if (wwEX == hMode) begin
                    rDex = quotientH;
                end
                else if (wwEX == wMode) begin
                    rDex = quotientW;
                end
                else if (wwEX == dMode) begin
                    rDex = quotientD;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VMOD : begin
                if (wwEX == bMode) begin
                    rDex = remainderB;
                end
                else if (wwEX == hMode) begin
                    rDex = remainderH;
                end
                else if (wwEX == wMode) begin
                    rDex = remainderW;
                end
                else if (wwEX == dMode) begin
                    rDex = remainderD;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            VSQRT : begin
                if (wwEX == bMode) begin
                    rDex = rootB;
                end
                else if (wwEX == hMode) begin
                    rDex = rootH;
                end
                else if (wwEX == wMode) begin
                    rDex = rootW;
                end
                else if (wwEX == dMode) begin
                    rDex = rootD;
                end
                else begin
                    rDex = 64'bx;
                end
            end
            default : begin
                rDex = rAex;
            end
        endcase
    end
//------------------------------------------End Output MUX------------------------------------------//
endmodule