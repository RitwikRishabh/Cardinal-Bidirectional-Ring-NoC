`timescale 1ns/1ps

`define ADDR_WIDTH 5
`define DATA_WIDTH 64
`define CLK_CYCLE 3

module tb_regfile;
    
    reg clk, reset;
    reg WrEn; // write enable 
    reg [0:2] ppp; // ppp value
    reg [0:63] wr_data;
    reg [0:4] rd_addr_0, rd_addr_1, wr_addr;
    wire [0:63] rd_data_0, rd_data_1;

    always #(0.5 * `CLK_CYCLE) clk = ~ clk;

    // Instantiation of DUT
    REGFILE32x64 register_file_dut
    (
        .clk(clk),
        .reset(reset),
        .wrEn(WrEn),
        .ppp(ppp),
        .dataIn(wr_data),
        .wrAddr(wr_addr),
        .rdAddr0(rd_addr_0),
        .rdAddr1(rd_addr_1),
        .dataOut0(rd_data_0),
        .dataOut1(rd_data_1)
    );

    integer out_file;
    initial 
    begin : test 
        integer count;
        reg [0:63] initial_data;

        out_file = $fopen("RF_contents.res","w");
        
        reset = 1;
        clk = 1;
        #(`CLK_CYCLE) 

        reset = 0;
        
        initial_data = 64'hffff_ffff_ffff_ffff;
        WrEn = 0;
        ppp = 3'b000;
        #(0.2 * `CLK_CYCLE)

        // Writes the content of RF into files
        for(count = 0; count < 2 ** `ADDR_WIDTH; count = count + 1)
        begin
            rd_addr_0 = count;
            #(0.3 * `CLK_CYCLE)
            $fdisplay(out_file, "$%1d : %h", count, rd_data_0);
            #(0.7 * `CLK_CYCLE);
        end

        // Tests internal forwarding
        WrEn = 1;
        for(count = 0; count < 2 ** `ADDR_WIDTH; count = count + 1)
        begin
            wr_addr = count;
            wr_data = initial_data;
            rd_addr_0 = count;
            rd_addr_1 = count;
            #(`CLK_CYCLE);
        end

        // Tests selective writing
        initial_data = 64'h1111_1111_1111_1111;
        for(count = 0; count < 2 ** `ADDR_WIDTH; count = count + 1)
        begin
            ppp = count;
            wr_addr = count;
            wr_data = initial_data;
            rd_addr_0 = count;
            rd_addr_1 = count;
            #(`CLK_CYCLE);
        end        

        // Writes the content of RF into files
        for(count = 0; count < 2 ** `ADDR_WIDTH; count = count + 1)
        begin
            rd_addr_0 = count;
            #(0.1 * `CLK_CYCLE)
            $fdisplay(out_file, "$%1d : %h", count, rd_data_0);
        end

        #(5 * `CLK_CYCLE) 
        $fclose(out_file);
        $finish;
    end
endmodule