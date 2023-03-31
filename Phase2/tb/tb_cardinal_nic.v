module tb;
    // Define parameters for packet size, clock cycles, and number of packets
    parameter PACKET_SIZE = 64;
    parameter CLK_CYCLE = 4;
    parameter NUM_OF_PAC = 15;

    // Define register and wire signals for test bench
    reg clk, reset, nicEn, nicWrEn, net_ro, net_polarity, net_si;
    reg [0:1] addr; 
    reg [0:PACKET_SIZE - 1] d_in, net_di;
    wire [0:PACKET_SIZE - 1] d_out, net_do; 
    wire net_so, net_ri;
	
    // Define integer variables for keeping track of data received by processor and router
    integer Processor_data, Router_data;
    integer i;
	reg send_finish; 

    // Create instance of Cardinal NIC module
    cardinal_nic cardinal_nic_inst( clk, reset, nicEn, nicWrEn, net_ro, net_polarity, net_si, addr, net_di, d_in, d_out, net_do, net_so, net_ri );

    // Toggle clock signal every 0.5 clock cycle
    always #(0.5 * CLK_CYCLE) clk = ~ clk;
    always @(posedge clk) begin
        if(reset)begin 
			net_polarity <= 0;
		end
		
        else begin
			net_polarity <= ~ net_polarity;
		end
	end
	
    
    // Open files for storing data received by processor and router
    initial
    begin
        Processor_data = $fopen("Processor_data.out", "w");
        Router_data = $fopen("Router_data.out", "w");
    end
 
    initial begin		
        clk = 1;
        reset = 1;
        nicEn = 1; 
        nicWrEn = 0;
        d_in = 0;
        net_ro = 0;
        net_si = 0;
        net_di = 0;
        send_finish = 0;
        #(5 * CLK_CYCLE);
        reset = 0;

        //--------------------- Sending data from router to NIC-----------------------------
        for(i = 0; i < NUM_OF_PAC; i = i + 1)
        begin
            wait(net_ri == 1)
            #(0.1 * CLK_CYCLE)
            net_si = 1;
            net_di = i;
            #(CLK_CYCLE)
            net_si = 0;
        end
        #(10 * CLK_CYCLE);
        send_finish = 1;
        #(10 * CLK_CYCLE);
	    i = 0;
        while(i < NUM_OF_PAC)
        begin
            #(0.1 * CLK_CYCLE);
            addr = 2'b11;
            #(0.1 * CLK_CYCLE);

            if(d_out[63] == 0)
            begin
                addr = 2'b10;
                nicWrEn = 1;
                d_in = i;
                d_in[0] = i % 2; // Change the VC bit to test conditional sending to router
                i = i + 1;
            end
            #(0.8 * CLK_CYCLE)
            nicWrEn = 0;
        end

        // Close files for storing data received by processor and router        
		#(10 * CLK_CYCLE)
        $fclose(Processor_data | Router_data);

	#20;
        $finish;
	end

    //------------------- Reveiving data at processor side-------------------------
    initial 
    begin : loop_1
        #(3.5 * CLK_CYCLE)
        forever 
        begin 
        
            if(send_finish == 1) disable loop_1;
            addr = 2'b01;
            #(0.1 * CLK_CYCLE) 

            if(d_out[63] == 1) 
            begin
                addr = 2'b00;
                #(0.1 * CLK_CYCLE)
                $fdisplay(Processor_data, "%1d", d_out[32:63]);
            end
            else #(0.1 * CLK_CYCLE);

            #(0.8 * CLK_CYCLE);
        end
    end

    //---------------------------------Receiving data from router side-----------------------

    initial  begin
        #(3.5 * CLK_CYCLE);
        net_ro = 0;
        #100;
        forever @(posedge clk)
        begin
            net_ro = 1;
            #(0.1 * CLK_CYCLE)
            if(net_so == 1)$fdisplay(Router_data, "%1d", net_do[32:63]);
        end
    end

endmodule