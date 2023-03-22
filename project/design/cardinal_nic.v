`include "./design/cardinal_nic_buffer.v"
module cardinal_nic #( 
	parameter PACKET_SIZE = 64
)(
    input clk, reset, nicEn, nicWrEn, net_ro, net_polarity, net_si,
    input [1:0] addr,
    input [PACKET_SIZE-1:0] net_di, d_in,
    output reg [PACKET_SIZE-1:0] d_out, net_do,
    output reg net_so, net_ri
);

//------Buffer Variables---------

//----Output channel Buffer-----
reg [PACKET_SIZE-1:0] buffer_d_in; //Buffer data input
wire [PACKET_SIZE-1:0] buffer_net_do; // Buffer data output
reg outp_buffer_write_en;
wire outp_status_reg;
reg outp_buffer_read_en;

//----Input channel Buffer-----
reg [PACKET_SIZE-1:0] buffer_net_di; //Buffer data input
wire [PACKET_SIZE-1:0] buffer_d_out; // Buffer data output
reg inp_buffer_write_en;
wire inp_status_reg;
reg inp_buffer_read_en;

cardinal_nic_buffer input_channel_buffer(
    .clk(clk), .reset(reset), .write_en(inp_buffer_write_en), .read_en(inp_buffer_read_en),
    .data_in(buffer_net_di), .data_out(buffer_d_out), .status_reg(inp_status_reg)
);
cardinal_nic_buffer output_channel_buffer(
    .clk(clk), .reset(reset), .write_en(outp_buffer_write_en),.read_en(outp_buffer_read_en),
    .data_in(buffer_d_in), .data_out(buffer_net_do), .status_reg(outp_status_reg)
);

//------Communication between Processor and NIC--------

always@(*)
begin
	
  	d_out = 0;
   	buffer_d_in = d_in;
	//inp_buffer_write_en =0;
	outp_buffer_write_en = 0;
	inp_buffer_read_en = 0;
	
	if( nicEn == 1 )
        begin
            if( nicWrEn == 1 ) begin
			
                if( addr == 2'b10 )outp_buffer_write_en = 1; 
                else outp_buffer_write_en = 0;
				
            end
            else begin
			
				if( addr==2'b00 ) begin
                        inp_buffer_read_en = 1;
                        d_out = buffer_d_out;
                end
				
				else if( addr==2'b01 ) d_out[63] = inp_status_reg;
				
				else if( addr==2'b11 )  d_out[63] = outp_status_reg;
				
				else d_out[63] = 1'b0;
				  
            end
        end
    end


//-------NIC to Router-------

 always @(*)
    begin
	
		net_do = 0;
        net_so = 0;
		outp_buffer_read_en = 0;
		
        if(reset)
		begin
			net_so = 1'b0;
		end
		else 
		begin
			if( outp_status_reg == 1 && net_ro == 1 ) 
				begin
					
					if( net_polarity == 1 && buffer_net_do[0] == 0 ) net_so = 1;
					else if(net_polarity == 0 && buffer_net_do[0] == 1) net_so = 1;
					else net_so = 0;
					
				end
			
			if( net_so == 1 && net_ro == 1 )
				begin
					outp_buffer_read_en = 0;
					net_do = buffer_net_do;
				end
		
		end
	end
//------Router to NIC -------
 always @(*)
    begin
        buffer_net_di = net_di; 
		net_ri = 1;
		
		if(reset) begin 
			inp_buffer_write_en =0;
			net_ri = 1;
        end
		else begin
        if(inp_status_reg == 1'b1) net_ri = 1'b0;      
        else net_ri = 1'b1;        

        if(inp_status_reg == 0 && net_si == 1 && net_ri == 1 ) inp_buffer_write_en = 1;
        else inp_buffer_write_en = 0;
	  end
		
    end
	
//-----------------------
endmodule

