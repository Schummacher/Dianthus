`timescale 1ns/1ns

module lfsr_tv;

wire carry, carry_2;
wire [3:0]random_out, random_out_2;
reg [3:0]reset_in, reset_in_2;
reg rst_n, clk, enable_n;

lfsr U1(
	carry,
	random_out,
	reset_in,
	enable_n,
	rst_n,
	clk);

lfsr U2(
	carry_2,
	random_out_2,
	reset_in_2,
	carry,
	rst_n,
	clk);

initial begin
	clk = 0;
	enable_n = 1;
	#12
	rst_n = 0;
	reset_in = 4'b1001;
	reset_in_2 = 4'b0110;
	#11 rst_n = 1;
	#200
	enable_n = 0;
	#200;
	$stop;
end

always #5 clk = ~clk;

endmodule
