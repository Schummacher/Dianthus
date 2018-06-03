module ram(ram_if.DUT rif, ctrl_if.DUT cif);

// output reg [3:0]rif.data_out;
// input [3:0]rif.data_in;
// input [7:0]rif.address;
// input rif.RW, rif.EN, cif.rst_n, cif.clk;

reg [3:0]register[127:0];

always @(posedge cif.clk)
begin
	if(cif.rst_n) begin
		if(rif.EN) begin
			if(rif.RW) begin
				register[rif.address] <= rif.data_in;
			end
			else begin
				rif.data_out <= register[rif.address];
			end
		end
		else begin
			rif.data_out <= rif.data_out;
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
