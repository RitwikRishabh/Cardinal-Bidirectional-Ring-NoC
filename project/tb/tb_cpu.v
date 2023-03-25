`timescale 1ns/1ps
`define CLK_PERIOD 4

`include "./include/dmem.v"
`include "./include/imem.v"

module tb_cpu;

    reg clk, reset;
    wire [0:31] instrIn;
    wire [0:31] instrAddr, dmemAddr;
    reg [0:63] dmemDataIn, nicDataIn;
    wire [0:63] dmemDataOut, nicDataOut;
    wire dmemEn, dmemWrEn, nicEn, nicWrEn;
    wire [0:1] nicAddr;


    cpu cpu_dut (
        .clk(clk),
        .reset(reset),

        .instrIn(instrIn),
        .instrAddr(instrAddr),

        .dmemDataIn(dmemDataIn),
        .dmemAddr(dmemAddr),
        .dmemEn(dmemEn),
        .dmemWrEn(dmemWrEn),
        .dmemDataout(dmemDataOut),

        .nicDataIn(nicDataIn),
        .nicAddr(nicAddr),
        .nicEn(nicEn),
        .nicWrEn(nicWrEn),
        .nicDataOut(nicDataOut)
    );

    imem imem0 (
        .memAddr(instrAddr[22:29]),
        .dataOut(instrIn)
    );

    dmem dmem0 (
        .clk(clk),
        .memEn(dmemEn),
        .memWrEn(dmemWrEn),
        .memAddr(dmemAddr),
        .dataIn(dmemDataIn),
        .dataOut(dmemDataOut)
    );

    integer regFileFP, dmemFP, count;
    initial begin
        regFileFP = $fopen("regFileContents.out", "w");
        dmemFP = $fopen("dmemContens.out", "w");
        $readmemh("./include/dmem.fill", dmem0.MEM);
        $readmemh("./include/imem_1.fill", imem0.MEM);

        clk = 1;
        reset = 1;

        #(3.5 * `CLK_PERIOD)
        reset = 0;

        wait(instrIn == 0);
        repeat(8) #(`CLK_PERIOD);

        for (count = 0; count < 32; count = count + 1) begin
            $fdisplay(regFileFP, "%b", cpu_dut.regFile.regFile[count]);
        end

        for (count = 0; count < 5; count = count + 1) begin
            $fdisplay(dmemFP, "%b", dmem0.MEM[count]);
        end
    end

    initial begin
        #50000;
        $stop;
    end

    always begin
        #(0.5 * `CLK_PERIOD)
        clk = ~clk;
    end
    

endmodule