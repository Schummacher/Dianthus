module lfsr(
	carry,
	random_out,
	reset_in,
	enable_n,
	rst_n,
	clk);

output reg carry;
output [3:0]random_out;
input [3:0]reset_in;
input rst_n, clk, enable_n;

reg [3:0]tmp;
reg [3:0]tmp_of_carry;

assign random_out = tmp;

always @(posedge clk) begin
	if(rst_n) begin
		if(enable_n) begin
			tmp[0] <= tmp[2] ^ tmp[3];
			tmp[1] <= tmp[0];
			tmp[2] <= tmp[1];
			tmp[3] <= tmp[2];
			if(tmp_of_carry == tmp) begin
				carry <= 0'b1;
			end
			else begin
				carry <= 0'b0;
			end
		end
		else begin
			carry <= 0;
		end
	end
	else begin
		tmp <= reset_in;
		carry <= 4'b0000;
		tmp_of_carry <= reset_in; 
	end
end

endmodule
