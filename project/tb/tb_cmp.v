/////////////////////////////////////////////////////////
// Filename       	: cpu_tb.v 				  
// Description    	: Cardinal Processor Simulation Testbenc
// Author         	: Praveen Sharma							  
// Fixed dataIn, dataOut port for DMEM.
// Fixed $readmemh statement for DM.fill
// Fixed minor bugs, related to signal names
/////////////////////////////////////////////////////////
// Test Bench for the Cardinal Processor RTL Verification

`timescale 1ns/10ps

//Define the clock cycle
`define CYCLE_TIME 100
`include "/home/viterbi/01/bgirish/EE577B/Cardinal_Processor/design/dmem.v"
`include "/home/viterbi/01/bgirish/EE577B/Cardinal_Processor/design/imem.v"
`include "/home/viterbi/01/bgirish/EE577B/Cardinal_Processor/design/gscl45nm.v"
`include "/home/viterbi/01/bgirish/EE577B/Cardinal_Processor/design/REGFILE32x64.v"
`include "/home/viterbi/01/bgirish/EE577B/Cardinal_Processor/design/CPU.v"


module tb_cmp;
reg CLK, RESET;

wire [0:31] node0_pc_out;
wire [0:31] node0_inst_in;
wire [0:31] node0_addr_out;
wire [0:63] node0_d_out, node0_d_in;
wire node0_memEn, node0_memWrEn;

wire [0:1] node0_addr_nic;
wire [0:63] node0_din_nic, node0_dout_nic;
wire node0_nicEn, node0_nicWrEn;


integer dmem0_dump_file;		// Channel Descriptor for DMEM0 final dump
integer i;
integer cycle_number;

//// ******************** Module Instantiations ******************** \\\\

// Instruction Memory Instance
imem IM_node0 (
	.memAddr		(node0_pc_out[22:29]),	// Only 8-bits are used in this project
	.dataOut		(node0_inst_in)		// 32-bit  Instruction
	);
	

// Data Memory Instance
dmem DM_node0 (
	.clk 		(CLK),				// System Clock
	.memEn		(node0_memEn),			// data-memory enable (to avoid spurious reads)
	.memWrEn	(node0_memWrEn),		// data-memory Write Enable
	.memAddr	(node0_addr_out[24:31]),	// 8-bit Memory address
	.dataIn		(node0_d_out),			// 64-bit data to data-memory
	.dataOut	(node0_d_in)			// 64-bit data from data-memory
	);	
 
cpu #(
   	 .ADDR_WIDTH(32),
   	 .DATA_WIDTH(64),
   	 .INSTR_WIDTH(32)
     )
	cpu_inst (
		.clk(CLK), 
		.reset(RESET), 
		.instrIn(node0_inst_in), 
		.instrAddr(node0_pc_out),
		.dmemDataIn(node0_d_in),
		.dmemDataout(node0_d_out),
		.dmemAddr(node0_addr_out),
		.dmemEn(node0_memEn),
		.dmemWrEn(node0_memWrEn),
		.nicDataIn(node0_din_nic),
		.nicDataOut(node0_dout_nic),
		.nicAddr(node0_addr_nic),
		.nicEn(node0_nicEn), 
		.nicWrEn(node0_nicWrEn)
);

	
always #(`CYCLE_TIME / 2) CLK <= ~CLK;	

initial begin
    #50000
    $finish;
end
	
initial
begin
	$readmemh("cmp_test.imem.0.fill", IM_node0.MEM); 	// loading instruction memory into node0
	

	$readmemh("cmp_test.dmem.0.fill", DM_node0.MEM); 	// loading data memory into node0
	

	//$readmemh("cmp_test.nic.0.fill", CMP.NIC_NODE0.MEM);	// loading dummy nic 0 memory
	
	
	CLK <= 0;				// initialize Clock
	RESET <= 1'b1;				// reset the CPU 
	repeat(5) @(negedge CLK);		// wait for 5 clock cycles
	RESET <= 1'b0;				// de-activate reset signal after 5ns

	// Convention for the last instruction
	// We would have a last instruction NOP  => 32'h00000000
	wait (node0_inst_in == 32'h00000000);
	// Let us see how much did you stall
	$display("The program completed in %d cycles", cycle_number);
	// Let us now flush the pipe line
	repeat(5) @(negedge CLK); 
	// Open file for output
	dmem0_dump_file = $fopen("cmp_test.dmem0.dump"); // assigning the channel descriptor for output file


	// Let us now dump all the locations of the data memory now
	for (i=0; i<128; i=i+1) 
	begin
		$fdisplay(dmem0_dump_file, "Memory location #%d : %h ", i, DM_node0.MEM[i]);
		
	end
	$fclose(dmem0_dump_file);
	
	$finish;
	
end // initial begin
	
//// ******************** Cycle Counter ******************** \\\\

always @ (posedge CLK)
begin
	if (RESET)
		cycle_number <= 0;
	else
		cycle_number <= cycle_number + 1;
end

endmodule

