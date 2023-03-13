module cardinal_nic_buffer(
    clk, reset, write_en, read_en, data_in, data_out, status_reg
);

parameter BUFFER_WIDTH = 64;

input clk, reset; // synchronous active high reset
input write_en;
input read_en;
input [0:BUFFER_WIDTH - 1] data_in;
output reg [0:BUFFER_WIDTH - 1] data_out;
output reg status_reg; //channel status register flag to indicate if channel buffer is full or empty


always @(posedge clk) begin
    if (reset) begin
        status_reg <= 0;
        data_out <= 0;
    end
    else begin
        case ({write_en, read_en, status_reg})
            3'b000: begin
                status_reg <= 0;
                data_out <= 0;
            end
            3'b001: begin
                status_reg <= 1;
                data_out <= data_out;
            end
            3'b010: begin
                status_reg <= 0;
                data_out <= 0;
            end
            3'b011: begin
                status_reg <= 0;
                data_out <= data_out;
            end
            3'b100: begin
                status_reg <= 1;
                data_out <= data_in;
            end
            3'b101: begin
                status_reg <= 1;
                data_out <= data_out;
            end
            3'b110: begin
                status_reg <= 0;
                data_out <= data_in;
            end
            3'b111: begin
                status_reg <= 0;
                data_out <= data_out;
            end
        endcase
    end
end

endmodule
