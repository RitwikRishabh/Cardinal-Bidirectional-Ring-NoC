`timescale 1ns/1ps

module tb_rotating_prioritizer;
    reg req0, req1, clk, reset, polarity;
    wire grant0, grant1;

    localparam CLK_PERIOD = 5;

    rotating_prioritizer dut(
        .clk(clk),
        .reset(reset),
        .req0(req0),
        .req1(req1),
        .polarity(polarity),
        .grant0(grant0),
        .grant1(grant1)
        );

    always begin
        #(CLK_PERIOD / 2) clk = ~clk;
    end
    always begin
        #(CLK_PERIOD) polarity = ~polarity;
    end
    initial begin
        
        clk = 0;
        reset = 1;
        polarity = 0;
        $monitor("%b, %b", grant0, grant1);

        # (3 * CLK_PERIOD);
        reset = 0;
        req0 = 1;
        # (2 * CLK_PERIOD);
        req0 = 0;
        req1 = 1;
        # (2 * CLK_PERIOD);
        req0 = 1;
        # (5 * CLK_PERIOD);
        $finish;
    end
endmodule