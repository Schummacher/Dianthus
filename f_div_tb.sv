module f_divi_tb;

reg clk, rst_n;
wire out;

f_divi #(2)U1(out, clk, rst_n);

initial begin
	rst_n = 0;
	clk = 1;
	#10 rst_n = 1;
	#1000 $stop();
end

always #5 clk = ~clk;

endmodule
