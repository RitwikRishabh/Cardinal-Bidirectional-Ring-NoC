`include "./design/cardinal_nic.v"
`include "./design/cpu.v"
`include "./design/cardinal_ring.v"
module cardinal_cmp #(
    parameter INST_WIDTH =  32,
    parameter DATA_WIDTH =  64,
    parameter ADDR_WIDTH =  32
)(
    input clk, reset,
    input [0:INST_WIDTH - 1] node0_inst_in, node1_inst_in, node2_inst_in, node3_inst_in,
    input [0:DATA_WIDTH - 1] node0_d_in, node1_d_in, node2_d_in, node3_d_in,
    output [0:ADDR_WIDTH - 1] node0_pc_out, node1_pc_out, node2_pc_out, node3_pc_out,
    output [0:DATA_WIDTH - 1] node0_d_out, node1_d_out, node2_d_out, node3_d_out,
    output [0:ADDR_WIDTH - 1] node0_addr_out, node1_addr_out, node2_addr_out, node3_addr_out,
    output node0_memEn, node1_memEn, node2_memEn, node3_memEn,
    output node0_memWrEn, node1_memWrEn, node2_memWrEn, node3_memWrEn
 );

    // Connections between NIC and processor
    wire nic_En_0, nic_En_1, nic_En_2, nic_En_3;
    wire nic_WrEn_0, nic_WrEn_1, nic_WrEn_2, nic_WrEn_3;
    wire [0:1] nic_addr_0, nic_addr_1, nic_addr_2, nic_addr_3;
    wire [0:DATA_WIDTH - 1] nic_di_0, nic_di_1, nic_di_2, nic_di_3;
    wire [0:DATA_WIDTH - 1] nic_do_0, nic_do_1, nic_do_2, nic_do_3;  

    // Connections between NIC and Ring NoC
    wire net_si_0, net_si_1, net_si_2, net_si_3;
    wire net_ri_0, net_ri_1, net_ri_2, net_ri_3;
    wire [0:DATA_WIDTH - 1] net_di_0, net_di_1, net_di_2, net_di_3;
    wire net_so_0, net_so_1, net_so_2, net_so_3;
    wire net_ro_0, net_ro_1, net_ro_2, net_ro_3;
    wire [0:DATA_WIDTH - 1] net_do_0, net_do_1, net_do_2, net_do_3;
    wire net_polarity_0, net_polarity_1, net_polarity_2, net_polarity_3;

    // Instantiation of 4 NICs:
    cardinal_nic nic0
    (
        .clk(clk),
        .reset(reset),

        .addr(nic_addr_0),
        .d_in(nic_di_0),
        .d_out(nic_do_0),
        .nicEn(nic_En_0),
        .nicEnWr(nic_WrEn_0),
        
        .net_si(net_si_0),
        .net_ri(net_ri_0),
        .net_di(net_di_0),
        
        .net_so(net_so_0),
        .net_ro(net_ro_0),
        .net_do(net_do_0),
        .net_polarity(net_polarity_0)
    );

    cardinal_nic nic1
    (
        .clk(clk),       
        .reset(reset),

        .addr(nic_addr_1),
        .d_in(nic_di_1),
        .d_out(nic_do_1),
        .nicEn(nic_En_1),
        .nicEnWr(nic_WrEn_1),
        
        .net_si(net_si_1),
        .net_ri(net_ri_1),
        .net_di(net_di_1),
        
        .net_so(net_so_1),
        .net_ro(net_ro_1),
        .net_do(net_do_1),
        .net_polarity(net_polarity_1)
    );

    cardinal_nic nic2
    (
        .clk(clk),
        .reset(reset),

        .addr(nic_addr_2),
        .d_in(nic_di_2),
        .d_out(nic_do_2),
        .nicEn(nic_En_2),
        .nicEnWr(nic_WrEn_2),
        
        .net_si(net_si_2),
        .net_ri(net_ri_2),
        .net_di(net_di_2),
        
        .net_so(net_so_2),
        .net_ro(net_ro_2),
        .net_do(net_do_2),
        .net_polarity(net_polarity_2)
    );

    cardinal_nic nic3
    (
        .clk(clk),
        .reset(reset),

        .addr(nic_addr_3),
        .d_in(nic_di_3),
        .d_out(nic_do_3),
        .nicEn(nic_En_3),
        .nicEnWr(nic_WrEn_3),
        
        .net_si(net_si_3),
        .net_ri(net_ri_3),
        .net_di(net_di_3),
        
        .net_so(net_so_3),
        .net_ro(net_ro_3),
        .net_do(net_do_3),
        .net_polarity(net_polarity_3)
    );

    // Instantiation of 4 processor cores
    cpu cpu0
    (
        .clk(clk),
        .reset(reset),
        
        .instrAddr(node0_pc_out),
        .instrIn(node0_inst_in),

        .dmemAddr(node0_addr_out),
        .dmemDataout(node0_d_out),
        .dmemDataIn(node0_d_in),
        .dmemEn(node0_memEn),
        .dmemWrEn(node0_memWrEn),

        .nicAddr(nic_addr_0),
        .nicDataOut(nic_di_0),
        .nicDataIn(nic_do_0),
        .nicEn(nic_En_0),
        .nicWrEn(nic_WrEn_0)
    );

    cpu cpu1
    (
        .clk(clk),
        .reset(reset),
        
        .instrAddr(node1_pc_out),
        .instrIn(node1_inst_in),

        .dmemAddr(node1_addr_out),
        .dmemDataout(node1_d_out),
        .dmemDataIn(node1_d_in),
        .dmemEn(node1_memEn),
        .dmemWrEn(node1_memWrEn),

        .nicAddr(nic_addr_1),
        .nicDataOut(nic_di_1),
        .nicDataIn(nic_do_1),
        .nicEn(nic_En_1),
        .nicWrEn(nic_WrEn_1) 
    );

    cpu cpu2
    (
        .clk(clk),
        .reset(reset),
        
        .instrAddr(node2_pc_out),
        .instrIn(node2_inst_in),

        .dmemAddr(node2_addr_out),
        .dmemDataout(node2_d_out),
        .dmemDataIn(node2_d_in),
        .dmemEn(node2_memEn),
        .dmemWrEn(node2_memWrEn),

        .nicAddr(nic_addr_2),
        .nicDataOut(nic_di_2),
        .nicDataIn(nic_do_2),
        .nicEn(nic_En_2),
        .nicWrEn(nic_WrEn_2) 
    ); 

    cpu cpu3
    (
        .clk(clk),
        .reset(reset),
        
        .instrAddr(node3_pc_out),
        .instrIn(node3_inst_in),

        .dmemAddr(node3_addr_out),
        .dmemDataout(node3_d_out),
        .dmemDataIn(node3_d_in),
        .dmemEn(node3_memEn),
        .dmemWrEn(node3_memWrEn),

        .nicAddr(nic_addr_3),
        .nicDataOut(nic_di_3),
        .nicDataIn(nic_do_3),
        .nicEn(nic_En_3),
        .nicWrEn(nic_WrEn_3) 
    );   

    // Instantiation of Ring NoC:
    cardinal_ring ring_0
    (
        .clk(clk),
        .reset(reset),

        .node0Pesi(net_so_0),
        .node0Peri(net_ro_0),
        .node0Pedi(net_do_0),
        .node0Peso(net_si_0),
        .node0Pero(net_ri_0),
        .node0Pedo(net_di_0),
        .node0Polarity(net_polarity_0),

        .node1Pesi(net_so_1),
        .node1Peri(net_ro_1),
        .node1Pedi(net_do_1),
        .node1Peso(net_si_1),
        .node1Pero(net_ri_1),
        .node1Pedo(net_di_1),
        .node1Polarity(net_polarity_1),  

        .node2Pesi(net_so_2),
        .node2Peri(net_ro_2),
        .node2Pedi(net_do_2),
        .node2Peso(net_si_2),
        .node2Pero(net_ri_2),
        .node2Pedo(net_di_2),
        .node2Polarity(net_polarity_2),    

        .node3Pesi(net_so_3),
        .node3Peri(net_ro_3),
        .node3Pedi(net_do_3),
        .node3Peso(net_si_3),
        .node3Pero(net_ri_3),
        .node3Pedo(net_di_3),
        .node3Polarity(net_polarity_3)
    );
endmodule