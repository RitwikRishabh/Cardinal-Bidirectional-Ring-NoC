`timescale 1ns/1ps

module tb_cpu_syn;
    reg clk, reset;
    wire [0:31] instrIn;
    wire [0:31] instrAddr, dmemAddr;
    wire [0:1] nicAddr;
    wire [0:63] dmemDataIn, dmemDataout, nicDataIn, nicDataOut;
    wire dmemEn, dmemWrEn, nicEn, nicWrEn;
	reg [0:32] regFileFP, dmemFP;
    integer count;
	
    localparam CLK_PERIOD = 4;

    always begin
        #(CLK_PERIOD * 0.5);
        clk = ~clk;
    end

    cpu cpuDUT(

        .clk(clk),
        .reset(reset),

        .instrAddr(instrAddr),
        .instrIn(instrIn),

        .dmemAddr(dmemAddr),
        .dmemDataout(dmemDataIn),
        .dmemEn(dmemEn),
        .dmemWrEn(dmemWrEn),
        .dmemDataIn(dmemDataout),

        .nicAddr(nicAddr),
        .nicDataOut(nicDataIn),
        .nicEn(nicEn),
        .nicWrEn(nicWrEn),
        .nicDataIn(nicDataOut)
    );  

   imem imem0(
    .memAddr(instrAddr[22:29]),
    .dataOut(instrIn)
   );

   dmem dmem0(
    .clk(clk),
    .memEn(dmemEn),
    .memWrEn(dmemWrEn),
    .memAddr(dmemAddr),
    .dataIn(dmemDataIn),
    .dataOut(dmemDataout)
   );

    

    initial begin
        regFileFP = $fopen("RegfileContents.out", "w");
        dmemFP = $fopen("DataMemoryContents.out", "w");

        $readmemh("./test_cases/dmem.fill", dmem0.MEM);
        $readmemh("./test_cases/imem_1.fill", imem0.MEM);

        clk = 1; reset = 1;

        #(3.5 * CLK_PERIOD);reset = 0;

        // Wait for instruction to be fetched
        //repeat (8) @(posedge clk);
		#16;

        // Capture initial register values
        for (count = 1; count < 32; count = count + 1) begin
            $fdisplay(regFileFP, "R%1d: %h", count, cpuDUT.regFile.regFile[count]);
        end

        // Capture initial data memory values
        for (count = 1; count < 128; count = count + 1) begin
            $fdisplay(dmemFP, "Memory location\t#%1d: %h", count, dmem0.MEM[count]);
        end

        // Execute for some time
        #100;

        // Stop simulation
        $finish;
    end
	initial 
	begin
		$sdf_annotate("./netlist/tb_cpu_syn.sdf", cpuDUT , ,"sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
		$enable_warnings;
		$log("ncsim.log");

		$sdf_annotate("./netlist/tb_imem0_syn.sdf", imem0 , ,"sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
		$enable_warnings;
		$log("ncsim.log");

		$sdf_annotate("./netlist/tb_dmem0_syn.sdf", dmem0 , ,"sdf.log","MAXIMUM","1.0:1.0:1.0", "FROM_MAXIMUM");
		$enable_warnings;
		$log("ncsim.log");
	end
endmodule
