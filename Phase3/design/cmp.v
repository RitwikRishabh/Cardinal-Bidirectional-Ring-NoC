`include "./design/cardinal_ring.v"
`include "./design/cardinal_nic.v"
`include "./design/cpu.v"

module cmp ( clk, reset, 
					  node0_instrIn, node0_dmemDataIn, node0_instrAddr, node0_dmemDataout, node0_dmemAddr, node0_dmemWrEn, node0_dmemEn, 
			          node1_instrIn, node1_dmemDataIn, node1_instrAddr, node1_dmemDataout, node1_dmemAddr, node1_dmemWrEn, node1_dmemEn, 
					  node2_instrIn, node2_dmemDataIn, node2_instrAddr, node2_dmemDataout, node2_dmemAddr,node2_dmemWrEn, node2_dmemEn,
					  node3_instrIn, node3_dmemDataIn, node3_instrAddr, node3_dmemDataout,  node3_dmemAddr, node3_dmemWrEn, node3_dmemEn
					 );

    //******************* PROCESSOR 0 INSTANTIATION *****************//
 	input clk, reset;
	output [0:31] node0_instrAddr;
    input [0:31] node0_instrIn;
    output [0:31] node0_dmemAddr;
    output [0:63] node0_dmemDataout;
    input [0:63] node0_dmemDataIn;
    output node0_dmemEn, node0_dmemWrEn;

    //******************* PROCESSOR 1 INSTANTIATION *****************//
	output [0:31] node1_instrAddr;
    input [0:31] node1_instrIn;
    output [0:31] node1_dmemAddr;
    output [0:63] node1_dmemDataout;
    input [0:63] node1_dmemDataIn;
    output node1_dmemEn, node1_dmemWrEn;

    //******************* PROCESSOR 2 INSTANTIATION *****************//
	output [0:31] node2_instrAddr;
    input [0:31] node2_instrIn;
    output [0:31] node2_dmemAddr;
    output [0:63] node2_dmemDataout;
    input [0:63] node2_dmemDataIn;
    output node2_dmemEn, node2_dmemWrEn;

    //******************* PROCESSOR 3 INSTANTIATION *****************//
	output [0:31] node3_instrAddr;
    input [0:31] node3_instrIn;
    output [0:31] node3_dmemAddr;
    output [0:63] node3_dmemDataout;
    input [0:63] node3_dmemDataIn;
    output node3_dmemEn, node3_dmemWrEn;



    //******************* NIC 0 INSTANTIATION *****************//
    wire [0:1] node0_nicAddr;
    wire [0:63] node0_nicDataIn;
    wire [0:63] node0_nicDataOut;
    wire node0_nicEn, node0_nicWrEn;

    //******************* NIC 1 INSTANTIATION *****************//
    wire [0:1] node1_nicAddr;
    wire [0:63] node1_nicDataIn;
    wire [0:63] node1_nicDataOut;
    wire node1_nicEn, node1_nicWrEn;

    //******************* NIC 2 INSTANTIATION *****************//
    wire [0:1] node2_nicAddr;
    wire [0:63] node2_nicDataIn;
    wire [0:63] node2_nicDataOut;
    wire node2_nicEn, node2_nicWrEn;

    //******************* NIC 3 INSTANTIATION *****************//
    wire [0:1] node3_nicAddr;
    wire [0:63] node3_nicDataIn;
    wire [0:63] node3_nicDataOut;
    wire node3_nicEn, node3_nicWrEn;



    //******************* RING INSTANTIATION ******************//
    wire node0Polarity, node1Polarity, node2Polarity, node3Polarity; 	

    wire node0Pesi, node0Pero; 			
    wire node0Peri, node0Peso; 			
    wire [63:0] node0Pedi;
	wire [63:0] node0Pedo; 	 

    wire node1Pesi, node1Pero; 			
    wire node1Peri, node1Peso; 			
    wire [63:0] node1Pedi;
	wire [63:0] node1Pedo; 

	wire node2Pesi, node2Pero; 			
    wire node2Peri, node2Peso; 			
    wire [63:0] node2Pedi;
	wire [63:0] node2Pedo; 

	wire node3Pesi, node3Pero; 			
    wire node3Peri, node3Peso; 			
    wire [63:0] node3Pedi;
	wire [63:0] node3Pedo; 		

    cpu node0(

        .clk(clk),
        .reset(reset),

        .instrAddr(node0_instrAddr),
        .instrIn(node0_instrIn),

        .dmemAddr(node0_dmemAddr),
        .dmemDataout(node0_dmemDataIn),
        .dmemEn(node0_dmemEn),
        .dmemWrEn(node0_dmemWrEn),
        .dmemDataIn(node0_dmemDataout),

        .nicAddr(node0_nicAddr),
        .nicDataOut(node0_nicDataIn),
        .nicEn(node0_nicEn),
        .nicWrEn(node0_nicWrEn),
        .nicDataIn(node0_nicDataOut)
    );  

   
	cpu node1(

        .clk(clk),
        .reset(reset),

        .instrAddr(node1_instrAddr),
        .instrIn(node1_instrIn),

        .dmemAddr(node1_dmemAddr),
        .dmemDataout(node1_dmemDataIn),
        .dmemEn(node1_dmemEn),
        .dmemWrEn(node1_dmemWrEn),
        .dmemDataIn(node1_dmemDataout),

        .nicAddr(node1_nicAddr),
        .nicDataOut(node1_nicDataIn),
        .nicEn(node1_nicEn),
        .nicWrEn(node1_nicWrEn),
        .nicDataIn(node1_nicDataOut)
    );  

	cpu node2(

        .clk(clk),
        .reset(reset),

        .instrAddr(node2_instrAddr),
        .instrIn(node2_instrIn),

        .dmemAddr(node2_dmemAddr),
        .dmemDataout(node2_dmemDataIn),
        .dmemEn(node2_dmemEn),
        .dmemWrEn(node2_dmemWrEn),
        .dmemDataIn(node2_dmemDataout),

        .nicAddr(node2_nicAddr),
        .nicDataOut(node2_nicDataIn),
        .nicEn(node2_nicEn),
        .nicWrEn(node2_nicWrEn),
        .nicDataIn(node2_nicDataOut)
    );  
	
	cpu node3(

        .clk(clk),
        .reset(reset),

        .instrAddr(node3_instrAddr),
        .instrIn(node3_instrIn),

        .dmemAddr(node3_dmemAddr),
        .dmemDataout(node3_dmemDataIn),
        .dmemEn(node3_dmemEn),
        .dmemWrEn(node3_dmemWrEn),
        .dmemDataIn(node3_dmemDataout),

        .nicAddr(node3_nicAddr),
        .nicDataOut(node3_nicDataIn),
        .nicEn(node3_nicEn),
        .nicWrEn(node3_nicWrEn),
        .nicDataIn(node3_nicDataOut)
    ); 
	
    cardinal_nic nic_node0 (
        .clk        (clk), 
        .reset      (reset),     
		.nicEn      (node0_nicEn),
        .nicWrEn    (node0_nicWrEn),
		.net_ro     (node0Peri), 
		.net_polarity(node0Polarity),
		.net_si     (node0Peso),
        .addr       (node0_nicAddr), 
		.net_di     (node0Pedo),
        .d_in       (node0_nicDataOut), 
        .d_out      (node0_nicDataIn), 
		.net_do     (node0Pedi), 
        .net_so     (node0Pesi), 
        .net_ri     (node0Pero) 
        );

    cardinal_nic nic_node1 (
        .clk        (clk), 
        .reset      (reset),  
		.nicEn      (node1_nicEn), 
        .nicWrEn    (node1_nicWrEn),
		.net_ro     (node1Peri),
        .net_polarity(node1Polarity),
		.net_si     (node1Peso),
        .addr       (node1_nicAddr), 
		.net_di     (node1Pedo),
        .d_in       (node1_nicDataOut), 
        .d_out      (node1_nicDataIn),    
        .net_do     (node1Pedi),
        .net_so     (node1Pesi),
        .net_ri     (node1Pero)
		);
    
    cardinal_nic nic_node2 (
        .clk        (clk), 
        .reset      (reset),     
		.nicEn      (node2_nicEn), 
        .nicWrEn    (node2_nicWrEn),
		.net_ro     (node2Peri),
        .net_polarity(node2Polarity),
		.net_si     (node2Peso),
        .addr       (node2_nicAddr), 
		.net_di     (node2Pedo),
        .d_in       (node2_nicDataOut), 
        .d_out      (node2_nicDataIn),  
		.net_do     (node2Pedi),
        .net_so     (node2Pesi),
		.net_ri     (node2Pero) 
		);

    cardinal_nic nic_node3 (
        .clk        (clk), 
        .reset      (reset),
		.nicEn      (node3_nicEn), 
        .nicWrEn    (node3_nicWrEn),
		.net_ro     (node3Peri),
        .net_polarity(node3Polarity),
		.net_si     (node3Peso),
        .addr       (node3_nicAddr), 
		.net_di     (node3Pedo), 
        .d_in       (node3_nicDataOut), 
        .d_out      (node3_nicDataIn), 
        .net_do     (node3Pedi), 
		.net_so     (node3Pesi),
        .net_ri     (node3Pero)  
		);


     cardinal_ring ringDUT (
        .clk                (clk),
        .reset              (reset), 
		
        .node0Polarity     (node0Polarity), 
        .node1Polarity     (node1Polarity), 
        .node2Polarity     (node2Polarity), 
        .node3Polarity     (node3Polarity), 
		
        .node0Pesi         (node0Pesi), 
        .node0Peri         (node0Peri), 
        .node0Pedi         (node0Pedi), 
        .node0Peso         (node0Peso), 
        .node0Pero         (node0Pero), 
        .node0Pedo         (node0Pedo), 
		
        .node1Pesi         (node1Pesi), 
        .node1Peri         (node1Peri), 
        .node1Pedi         (node1Pedi), 
        .node1Peso         (node1Peso), 
        .node1Pero         (node1Pero), 
        .node1Pedo         (node1Pedo), 
		
        .node2Pesi         (node2Pesi), 
        .node2Peri         (node2Peri), 
        .node2Pedi         (node2Pedi), 
        .node2Peso         (node2Peso), 
        .node2Pero         (node2Pero), 
        .node2Pedo         (node2Pedo), 
		
        .node3Pesi         (node3Pesi), 
        .node3Peri         (node3Peri), 
        .node3Pedi         (node3Pedi), 
        .node3Peso         (node3Peso), 
        .node3Pero         (node3Pero), 
        .node3Pedo         (node3Pedo)
		);


endmodule
