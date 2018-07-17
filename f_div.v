module f_divi#(parameter N = 2)(clk_out, clk_in, rst_n);

input clk_in, rst_n;
output reg clk_out;

//parameter N;
`define n N-1

reg [`n : 0] tmp;

always @(posedge clk_in) begin
	if(rst_n) begin
		tmp <= tmp + 1;
	end
	else begin
		tmp <= 0;
	end
end

always @(posedge clk_in) begin
	if(rst_n) begin
		if(tmp == 'b1) begin
			clk_out <= ~clk_out;
		end
		else begin
			clk_out <= clk_out;
		end
	end
	else begin
		clk_out <= 0;
	end
end

endmodule
