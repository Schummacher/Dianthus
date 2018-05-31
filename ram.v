module ram(data_out, data_in, address, RW, EN, rst_n, clk);

output reg [3:0]data_out;
input [3:0]data_in;
input [7:0]address;
input RW, EN, rst_n, clk;

reg [3:0]register[127:0];

always @(posedge clk)
begin
	if(rst_n) begin
		if(EN) begin
			if(RW) begin
				register[address] <= data_in;
			end
			else begin
				data_out <= register[address];
			end
		end
		else begin
			data_out <= data_out;
		end
	end
	else begin :RAM_reset
		integer rr;
		for(rr = 0; rr < 128; rr = rr + 1) begin
			register[rr] <= 4'b000;
		end
	end
    end
endmodule
