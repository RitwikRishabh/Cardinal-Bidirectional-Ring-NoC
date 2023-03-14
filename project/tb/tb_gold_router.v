`timescale 1ns/1ps

module tb_gold_router;

    parameter PACKET_SIZE = 64;
    parameter CLK_PERIOD = 5;

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
        #(3.1 * CLK_PERIOD);
    end
    endtask

    // task test_sendCwiCwi();
    //     reset = 0;
    //     cwsi = 1;
    //     cwdi = {1'b0, 1'b1, 6'b0, 8'b11111111, 48'b11111};

    // endtask

    
    initial
    begin : test 
        
        initialize();

        for(i = 0; i < 20; i = i + 1)
        begin
            reset = 0;
    
            ccwsi = 1;
            ccwdi = {1'b0, 1'b1, 6'b0, 8'b1111_1111, 48'b11111};
            ccwdi[63] = i + 1;
            ccwdi[55-:8] = 1;
            ccwdi[62] = 0;

            pesi = 1;
            pedi = {1'b0, 1'b1, 6'b0, 8'b1111_1111, 48'b0};
            pedi[63] = i + 1;
            pedi[55-:8] = 0;
            pedi[62] = 1;

            #(CLK_PERIOD);
        end

        #(10 * CLK_PERIOD) 
        $finish;

    end

endmodule