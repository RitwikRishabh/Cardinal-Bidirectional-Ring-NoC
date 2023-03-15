`timescale 1ns/1ps

module tb_gold_router;

    parameter PACKET_SIZE = 64;
    parameter CLK_PERIOD = 4; // 250MHz clock

    reg clk, reset;
    wire polarity;

    reg cwsi, ccwsi, pesi;
    wire cwri, ccwri, peri;
    reg [PACKET_SIZE-1:0] cwdi, ccwdi, pedi;

    reg cwro, ccwro, pero;
    wire cwso, ccwso, peso;
    wire [PACKET_SIZE-1:0] cwdo, ccwdo, pedo;

    integer i;

    gold_router #(
        .PACKET_SIZE(PACKET_SIZE)
    )
    dut
    (
        .clk(clk), .reset(reset), .polarity(polarity),
        .cwsi(cwsi), .cwri(cwri), .cwdi(cwdi),
        .ccwsi(ccwsi), .ccwri(ccwri), .ccwdi(ccwdi),
        .pesi(pesi), .peri(peri), .pedi(pedi),
        .cwso(cwso), .cwro(cwro), .cwdo(cwdo),
        .ccwso(ccwso), .ccwro(ccwro), .ccwdo(ccwdo),
        .peso(peso), .pero(pero), .pedo(pedo)
    );

    always #(0.5 * CLK_PERIOD) clk = ~ clk;

    task initialize();
    begin
        clk = 1;
        reset = 1;
        {cwsi, ccwsi, pesi} = 3'b0;
        {cwro, ccwro, pero} = 3'b111;
        cwdi = 'h11111;
        ccwdi = 'h22222;
        pedi = 'h33333;
        #(5.1 * CLK_PERIOD);
        reset = 0;
    end
    endtask

    task send_Cwi(input sendValid, input dir, input [7:0] hop, input ready);
    begin
        cwsi = sendValid;
        cwdi[62] = dir;
        cwdi[55-:8] = hop;
        cwro = ready;
    end
    endtask

    task send_Ccwi(input sendValid, input dir, input [7:0] hop, input ready);
    begin
        ccwsi = sendValid;
        ccwdi[62] = dir;
        ccwdi[55-:8] = hop;
        ccwro = ready;
    end
    endtask

    task send_Pei(input sendValid, input dir, input [7:0] hop, input ready);
    begin
        pesi = sendValid;
        pedi[62] = dir;
        pedi[55-:8] = hop;
        pero = ready;
    end
    endtask
    
    initial begin : test 
        
        initialize();

        //Test for no contention

        # (1*1*CLK_PERIOD)
        // even polarity
        send_Cwi(1, 0, 8'hf, 1);
        #CLK_PERIOD
        cwsi = 0;
        #(2*CLK_PERIOD)
        // odd polarity
        // cwdi = 'h44444;
        // send_Cwi(1, 0, 8'h7, 1);
        // #CLK_PERIOD
        // cwsi = 0;
        // # (4*CLK_PERIOD)
        // cwro = 0; ccwro = 0;
        // #CLK_PERIOD;
        // // pe input channel for cwi
        // send_Pei(1, 0, 8'h0, 0);
        // cwro = 1;
        // #CLK_PERIOD;
        // pesi = 0;
        // # (2*CLK_PERIOD)
        // cwro = 0;
        // // pe input channel for ccwi
        // send_Pei(1, 1, 8'h0, 0);
        // ccwro = 1;
        // #CLK_PERIOD;
        // pesi = 0;
        // # (2*CLK_PERIOD)
        // ccwro = 0;
        // // pe output channel for cwi
        // send_Cwi(1, 0, 8'h0, 0);
        // pero = 1;
        // #CLK_PERIOD;
        // cwsi = 0;
        // # (2*CLK_PERIOD)
        // pero = 0;
        // // pe output channel for ccwi
        // send_Ccwi(1, 0, 8'h0, 0);
        // pero = 1;
        // #CLK_PERIOD;
        // ccwsi = 0;
        // # (2*CLK_PERIOD)
        // pero = 0;

        // // Test for contention
        // // clockwise contention
        // # (3*CLK_PERIOD)
        // send_Cwi(1, 0, 8'h4, 1);
        // pesi = 1;
        // pedi[62] = 0;
        // #CLK_PERIOD;
        // cwsi = 0;
        // pesi = 0;
        // # (2*CLK_PERIOD)
        // cwro = 0;
        // //grant to the other input buffer
        // # (3*CLK_PERIOD)
        // send_Cwi(1, 0, 8'h4, 1);
        // pesi = 1;
        // pedi[62] = 0;
        // #CLK_PERIOD;
        // cwsi = 0;
        // pesi = 0;
        // # (2*CLK_PERIOD)
        // cwro = 0;
        // // counter clockwise contention
        // # (3*CLK_PERIOD)
        // send_Ccwi(1, 0, 8'h4, 1);
        // pesi = 1;
        // pedi[62] = 1;
        // #CLK_PERIOD;
        // ccwsi = 0;
        // pesi = 0;
        // ccwro = 0;
        // // grant to the other input buffer
        // # (3*CLK_PERIOD)
        // send_Ccwi(1, 0, 8'h4, 1);
        // pesi = 1;
        // pedi[62] = 1;
        // #CLK_PERIOD;
        // ccwsi = 0;
        // pesi = 0;
        // ccwro = 0;
        // // processing element contention
        // # (3*CLK_PERIOD)
        // send_Ccwi(1, 0, 8'h0, 0);
        // send_Cwi(1, 0, 8'h0, 0);
        // pero = 1;
        // #CLK_PERIOD;
        // ccwsi = 0;
        // cwsi = 0;
        // pero = 0;

        #(20 *CLK_PERIOD)
        $stop;
    end

endmodule