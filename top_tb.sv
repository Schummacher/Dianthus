`timescale 10ns/1ns

module top_tb;
	reg clk;
	reg [0:11]instrution_bus;
	reg rst_n;

	top UUU(instrution_bus, rst_n, clk);


	initial
	begin
		rst_n = 1;
		clk = 0;
		#1 rst_n = 0;
		#12 rst_n = 1;
		#1 instrution_bus = 12'h000;
		#10 instrution_bus = 12'h430;
		#10 instrution_bus = 12'h301;
		#10 instrution_bus = 12'h440;
		#10 instrution_bus = 12'h331;
		#10 instrution_bus = 12'h100;
		#10 instrution_bus = 12'hA00;
		#10 instrution_bus = 12'h600;
		#10 instrution_bus = 12'h500;
		#100 $stop;
	end

	always #5 clk = ~clk;

endmodule
