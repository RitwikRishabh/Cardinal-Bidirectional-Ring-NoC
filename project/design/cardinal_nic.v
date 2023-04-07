`include "./design/buffer.v"
module cardinal_nic #( 
	parameter PACKET_SIZE = 64
)(
    input clk, reset,

	input [0:1] addr,
	input [0:PACKET_SIZE-1] d_in,
	input nicEn,
	input nicEnWr,
	output reg [0:PACKET_SIZE-1] d_out;

	input net_si,
	input [0:PACKET_SIZE-1] net_di
	input net_ro,
	input net_polarity,
	output reg net_ri,
	output reg net_so,
	output reg [0:PACKET_SIZE-1] net_do,
);

	//------Buffer Variables---------

	reg [PACKET_SIZE-1:0] inBufDataIn, outBufDataIn; //Buffer data input
	wire [PACKET_SIZE-1:0] inBufDataOut, outBufDataOut; // Buffer data output
	wire inBufFull, outBufFull;
	reg inBufRdEn, outBufRdEn;
	reg inBufWrEn, outBufWrEn;

	bufferDepth1 inBuffer(
		.clk(clk),
		.reset(reset),
		.wrEnable(inBufWrEn),
		.rdEnable(inBufRdEn),
		.dataIn(inBufDataIn),
		.data_out(inBufDataOut),
		.full(inBufFull),
		.empty()
	);
	bufferDepth1 outBuffer(
		.clk(clk),
		.reset(reset),
		.wrEnable(outBufWrEn),
		.rdEnable(outBufRdEn),
		.dataIn(outBufDataIn),
		.data_out(outBufDataOut),
		.full(outBufFull),
		.empty()
	);

	//------Communication between Processor and NIC--------

	always@(*) begin
		outBufWrEn = 0;
		inBufRdEn = 0;
		d_out = 0;
		outBufDataIn = d_in;

		if(nicEn == 1) begin
			if(nicWrEn == 1) begin
				if(addr == 2'b10) begin
					outBufWrEn = 1; 
				end
			end
			else begin
				if(addr==2'b00) begin
					inBufWrEn = 1;
					d_out = inBufDataOut;
				end
				else if(addr==2'b01) begin
					d_out[63] = inBufFull;
				end
				else if(addr==2'b11) begin
					d_out[63] = outBufFull;
				end				
			end
		end
	end


	//-------NIC to Router-------

	always @(*) begin
		
		net_do = outBufDataOut;
		net_so = 0;
		if(outBufFull == 1 && net_ro == 1) begin
			if( net_polarity == 1 && outBufDataOut[0] == 0 ) begin
				net_so = 1;
			end
			else if(net_polarity == 0 && outBufDataOut[0] == 1) begin
				net_so = 1;
			end
		end
		
		if(net_so == 1 && net_ro == 1) begin
				outBufRdEn = 1;
		end
		else begin
			outBufRdEn = 0;
		end
	end
	//------Router to NIC -------
	always @(*) begin
			inBufDataIn = net_di; 
			if(inBufFull == 0) begin
				net_ri = 1;
			end      
			else begin
				net_ri = 0;
			end

			if(inBufFull == 0 && net_si == 1) begin
				inBufWrEn = 1;
			end
			else begin
				inBufWrEn = 0;
			end
	end
			
		
	//-----------------------
endmodule

