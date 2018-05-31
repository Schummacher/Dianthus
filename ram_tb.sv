`timescale 1ns/1ns
module ram_tb;
	wire [3:0]data_out;
	reg [3:0]data_in;
	reg [7:0]address;
	reg RW, EN, rst_n, clk;
	ram U1(data_out, data_in, address, RW, EN, rst_n, clk);
	
	initial begin
		clk = 1;
		rst_n = 1;
		#11
		rst_n = 0;
		#10
		rst_n = 1;
		EN = 1;
		RW = 1;
		address = 0'h00;
		data_in = 0'b1100;
		#10
		address = 0'h01;
		data_in = 0'b0011;
		#10
		rst_n = 0;
		#100 $stop;
	end

	always #5 clk = ~clk;
endmodule
