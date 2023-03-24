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
	
	// Selective execution 
    localparam  aModePPP = 3'b000,
    localparam  uModePPP = 3'b001,
    localparam  dModePPP = 3'b010,
    localparam  eModePPP = 3'b011,
    localparam  oModePPP = 3'b100;
	
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
    wire [0:4] wwID;
    wire [0:15] immediateAddrID;
	wire [0:2] pppId;
	
    assign opcodeID           = regIF_ID[0:5];
    assign rDid               = regIF_ID[6:10];
    assign rAid               = regIF_ID[11:15];
    assign rBid               = regIF_ID[16:20];
    assign wwID               = regIF_ID[21:25];
    assign functionCodeID     = regIF_ID[26:31];
    assign immediateAddrID    = regIF_ID[16:31];
	assign pppId = (opcodeID == MTYPE_LW) ? 3'b000 : regIF_ID[21:23] ;// ppp is 000 for Load word instruction
	
    // Reg file
    reg [0:$clog2(ADDR_WIDTH)-1] regFileRdAddr0, regFileRdAddr1;
    wire [0:DATA_WIDTH-1] regFileRdDataOut0, regFileRdDataOut1;
    wire regFileWrEnWB; // Write Enable from WB stage
    wire [0:$clog2(ADDR_WIDTH)-1] regFileWrAddrWB;
    wire [0:DATA_WIDTH-1] regFileDataInWB;
	wire [0:2] pppWB;

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
	
    // Stall due to DIV and SQRT 
    wire stallDIVSQRTid;
    assign stallDIVSQRTid = (opcodeID == RTYPE_ALU) && ((functionCodeID == VDIV) || (functionCodeID == VSQRT));
	
    // Stall due to MOD, MULT, SQAURE
    wire stallMULTSQid;
    assign stallMULTSQid = ( (opcodeID == RTYPE_ALU) && ((functionCodeID == VMULEU) || (functionCodeID == VMULOU) || (functionCodeID == VMOD) || 
							(functionCodeID == VSQEU) || (functionCodeID == VSQOU)) && (rDid != 0) ) ? 1'b1 : 1'b0;

    // Stall due to ADD, SUB,SLL, SRL, SRA
    wire stallADDSUBid;
    wire stallADDSUBid;
    assign stallADDSUBid = ( (opcodeID == RTYPE_ALU)  && ((functionCodeID == VADD) || (functionCodeID == VSUB) || (functionCodeID == VSLL) || 
							(functionCodeID == VSRL) || (functionCodeID == VSRA)) && (rDid != 0) ) ? 1'b1 : 1'b0;

    
    // HDU
    reg hduRAid, hduRBid;
	wire RFWrEnex_mem;
    wire [0:4] rDex_mem;
    
	// Checking if senior is 0 for destination reg
   
    always @(*)
	begin
	
        hduRAid = 0;
        hduRBid = 0;
        
        if((RFWrEnex_mem == 1) && (rDex_mem != 0))
        begin
            if(rDex_mem == regFileRdAddr0)begin
                hduRAid = 1;
			end
            if(rDex_mem == regFileRdAddr1)begin
                hduRBid = 1;
			end
        end
	end

//Forwarding Unit
    reg [0:63] RFrDDataOut0_mux, RFrDDataOut1_mux; 
    reg [0:63] RFWrDataInex_mem;
    wire [0:2] pppex_mem;

	always @(*) begin
	
        RFrDDataOut0_mux = regFileRdDataOut0;
        RFrDDataOut1_mux = regFileRdDataOut1;

        if(hduRAid == 1)
            case(pppex_mem)
                aModePPP :begin
                    RFrDDataOut0_mux[0:63] = RFWrDataInex_mem[0:63];
				end
                uModePPP :begin
                    RFrDDataOut0_mux[0:31] = RFWrDataInex_mem[0:31];
				end
                dModePPP :
                    RFrDDataOut0_mux[32:63] = RFWrDataInex_mem[32:63];
				end
                eModePPP :begin
                    RFrDDataOut0_mux[0:7] = RFWrDataInex_mem[0:7];
                    RFrDDataOut0_mux[16:23] = RFWrDataInex_mem[16:23];
                    RFrDDataOut0_mux[32:39] = RFWrDataInex_mem[32:39];
                    RFrDDataOut0_mux[48:55] = RFWrDataInex_mem[48:55];
                end
                oModePPP :begin
                    RFrDDataOut0_mux[8:15] = RFWrDataInex_mem[8:15];
                    RFrDDataOut0_mux[24:31] = RFWrDataInex_mem[24:31];
                    RFrDDataOut0_mux[40:47] = RFWrDataInex_mem[40:47];
                    RFrDDataOut0_mux[56:63] = RFWrDataInex_mem[56:63];
                end
            endcase

			if(hduRBid == 1)
            case(pppex_mem)
                aModePPP :begin
                    RFrDDataOut1_mux[0:63] = RFWrDataInex_mem[0:63];
				end
                uModePPP :begin
                    RFrDDataOut1_mux[0:31] = RFWrDataInex_mem[0:31];
				end
                dModePPP :begin
                    RFrDDataOut1_mux[32:63] = RFWrDataInex_mem[32:63];
				end
                eModePPP :begin
                    RFrDDataOut1_mux[0:7] = RFWrDataInex_mem[0:7];
                    RFrDDataOut1_mux[16:23] = RFWrDataInex_mem[16:23];
                    RFrDDataOut1_mux[32:39] = RFWrDataInex_mem[32:39];
                    RFrDDataOut1_mux[48:55] = RFWrDataInex_mem[48:55];
                end
                oModePPP :begin 
					RFrDDataOut1_mux[8:15] = RFWrDataInex_mem[8:15];
                    RFrDDataOut1_mux[24:31] = RFWrDataInex_mem[24:31];
                    RFrDDataOut1_mux[40:47] = RFWrDataInex_mem[40:47];
                    RFrDDataOut1_mux[56:63] = RFWrDataInex_mem[56:63];
                end
            endcase
    end

    // Bbranch and BranchAddr 
	
    always @(*) begin
	
        branch = 0;
        branchAddr = {32'b0, immediateAddrID};

        if((opcodeID == RTYPE_BEZ) && (RFrDDataOut0_mux == 0))begin
            branch = 1;
        end
        if((opcodeID == RTYPE_BNEZ) && (RFrDDataOut0_mux != 0))begin
            branch = 1;
		end
		
    end
	
	// Use register to solve stalling of data memory input
	reg [0:97] shadowReg;
    always @(posedge clk)
    begin
	
        if(reset)begin
			shadowReg <= 0;
		end
		
        else begin 
		
            if(stall)begin 
			shadowReg <= shadowReg;
			end
			
            else begin
                shadowReg[0] <= dmemWrEnID;
                shadowReg[1] <= dmemEnID;
                shadowReg[2:33] <= {16'b0, immediateAddrID};
                shadowReg[34:97] <= RFrDDataOut0_mux;
            end
        end
    end
	assign dmemEn = stall == 1 ? shadowReg[1] : dmemEnID;
    assign dmemWrEn = stall == 1 ? shadowReg[0] : dmemWrEnID;
    assign dmemAddr = stall == 1 ? shadowReg[2:33] : {16'b0, immediateAddrID};
    assign dmemDataout = stall == 1 ? shadowReg[34:97] : RFrDDataOut0_mux;
	
	 // ID/EXMEM stage reg update
	 
    reg [0:154] IdExMemReg;

    always @(posedge clk)
    begin
        if(reset)
            IdExMemReg <= 0;
        else
            if(stall) IdExMemReg <= IdExMemReg;
            else
            begin
                IdExMemReg[0:63] <= RFrDDataOut0_mux;
                IdExMemReg[64:127] <= RFrDDataOut1_mux;
                IdExMemReg[128] <= stallLWSWid;
                IdExMemReg[129:133] <= rDid;
                IdExMemReg[134:136] <= pppId;
                IdExMemReg[137:138] <= wwId;
                IdExMemReg[139:144] <= functionCodeID;
                IdExMemReg[145:146] <= immediateAddrID[14:15];
                IdExMemReg[147:151] <= {dmemEnID, dmemWrEnID, nicEnID, nicWrEnID, regFileWrEnID};
                IdExMemReg[152] <= stallDIVSQRTid;
                IdExMemReg[153] <= stallMULTSQid;
                IdExMemReg[154] <= stallADDSUBid;
            end
    end
//-------------------------------End ID Stage------------------------------//

//-------------------------------EX_MEM stage-------------------------------
    
    wire dmemEnExMem, dmemWrEnExMem, nicEnExMem, nicWrEnExMem;
    wire stallExMem, ALUstallExMem5, ALUstallExMem4, ALUstallExMem3;
	wire [0:1] nicAddr;
    wire [0:63] RegFilerDDataOutExMem0, RegFilerDDataOutExMem1;
    wire [0:5] functionCodeExMem;
    wire [0:1] wwExMem;

	assign nicDataOut = IdExMemReg[0:63];
    assign stallExMem = IdExMemReg[128];
    assign rDex_mem = IdExMemReg[129:133];
    assign pppex_mem = IdExMemReg[134:136];
    assign wwExMem = IdExMemReg[137:138];
    assign functionCodeExMem = IdExMemReg[139:144];
    assign nicAddr = IdExMemReg[145:146];
    assign {dmemEnExMem, dmemWrEnExMem, nicEnExMem, nicWrEnExMem, RFWrEnex_mem} = IdExMemReg[147:151];
    assign ALUstallExMem5 = IdExMemReg[152];
    assign ALUstallExMem4 = IdExMemReg[153];
    assign ALUstallExMem3 = IdExMemReg[154];
    assign nicEn = nicEnExMem;
    assign nicWrEn = nicWrEnExMem;
    

    // -------------------ALU Instantiation-------------------- 
    wire [0:63] ALUDataInA, ALUDataInB, ALUOutExMem; 
    assign {ALUDataInA, ALUDataInB} = IdExMemReg[0:127];
    alu aluEXMem( .rAex(ALUDataInA), .rBex(ALUDataInB),  .functionCodeEX(functionCodeExMem), .wwEX(wwExMem), .rDex(ALUOutExMem)  );


    // -----------Stall generation----------------
    // Stall if we have LW or SW in EX_MEM stage
 
    reg StallMem;
    reg StallSignalMem; 
	
	// if rD ==0 for LW/ SW, no stall
    always @(posedge clk)
    begin
        if(reset)begin 
			StallMem <= 0;
		end
        else begin
           
            if(stallExMem == 1)begin
                StallMem <= ~ StallMem;
			end
		end
    end
    
    // For LW, if rD !=0 or SW, enable Stall
    always @(*)
    begin
        StallSignalMem = 0;
        if((stallExMem == 1) && (StallMem == 0))begin
            StallSignalMem = 1;
		end
    end
	
	// Stall for DIV & SQRT
	
    reg [0:2] ALUStall5;
    reg ALUStall5Signal;
   
    always @(posedge clk)begin 
	
        if(reset)begin
			ALUStall5 <= 0;
		end
		
        else begin
		
            if(ALUstallExMem5 == 1)begin
			
                if(ALUStall5 == 4)begin
					ALUStall5 <= 0;
				end
                else begin
					ALUStall5 <= ALUStall5 + 1;
				end
				
            end
        end
    end
	
    always @(*)begin
	
        ALUStall5Signal = 0;
		
        if( (ALUstallExMem5 == 1) &&  ( (ALUStall5 == 0) || (ALUStall5 == 1) || (ALUStall5 == 2) || (ALUStall5 == 3)))begin
			ALUStall5Signal = 1;
		end
		
    end	
	
	// Generating stall for MOD, SQ, MULT
	 reg ALUStall4Signal;
	 reg [0:1] ALUStall4;
	 
	always @(posedge clk)begin   
	
        if(reset)begin 
			ALUStall4 <= 0;
		end
        else begin
            if(ALUstallExMem4 == 1)begin
				ALUStall4 <= ALUStall4 + 1;
			end
		end
    end
	
    always @(*)begin
	
        ALUStall4Signal = 0;
		
        if( (ALUstallExMem4 == 1) && ( (ALUStall4 == 0) || (ALUStall4 == 1) || (ALUStall4 == 2) ) )begin
            ALUStall4Signal = 1;
		end
    end

   
	// Generating stall for ADD, SUB, SLL, SRL, SRA
	reg ALUStall3Signal;
	reg [0:1] ALUStall3;

   
    always @(posedge clk)begin 
	
        if(reset)begin
			ALUStall3 <= 0;
		end
        else begin
		
            if(ALUstallExMem3 == 1)begin
			
                if(ALUStall3 == 2)begin 
					ALUStall3 <= 0;
				end
                else begin
					ALUStall3 <= ALUStall3 + 1;
				end
            end
        end
    end
	
    always @(*)begin
	
        ALUStall3Signal = 0;
		
        if( (ALUstallExMem3 == 1) && ( (ALUStall3 == 0) || (ALUStall3 == 1) ))begin
            ALUStall3Signal = 1;
		end
    end

//------------ Stall Signal-------------
 assign stall = ( StallSignalMem  ||  ALUStall3Signal  ||  ALUStall4Signal  || ALUStall5Signal ) ? 1'b1 : 1'b0;
 
 // Writing data from ALU, NIC & DataMem
 
    always @(*)begin
	
        RFWrDataInex_mem = ALUOutExMem;
        if(dmemEnExMem == 1)begin
			RFWrDataInex_mem = dmemDataIn[0:63];
		end
        else begin
            if(nicEnExMem == 1) RFWrDataInex_mem = nicDataIn[0:63];
		end
		
    end
	
// 	Updating Stage reg - EX_mem/WB

	reg [0:72] RegFileExMemWB;
	
    always @(posedge clk) begin
	
        if(reset)begin
            RegFileExMemWB <= 0;
		end
		
        else begin
			if(stall) begin
				RegFileExMemWB[64] <= 0; 
			end
			
			else begin
			
				RegFileExMemWB[0:63] <= RFWrDataInex_mem[0:63];
				RegFileExMemWB[64] <= RFWrEnex_mem;
				RegFileExMemWB[65:67] <= pppex_mem;
				RegFileExMemWB[68:72] <= rDex_mem;
				
			end
		end
    end
//-------------------------------------End of EX_MEM Stage----------------------------------

//---------------------------------------- WB Stage-----------------------------------------

	assign regFileDataInWB = RegFileExMemWB[0:63];
	assign regFileWrEnWB = RegFileExMemWB[64];
	assign pppWB = RegFileExMemWB[65:67];
    assign regFileWrAddrWB = RegFileExMemWB[68:72];        
	
 //--------------------------------------------------------------------------------------------------------------------   
endmodule