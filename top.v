module top(A, out, data_bus, address_bus, rst_n, clk);
	input clk, rst_n;
	input [0:11]data_bus;
	input [0:8]address_bus;
	output reg [0:16]out;
	
	reg [0:15]en_bus;
	
	reg [0:3]r0, r1, r2, r3, r4, r5, r6, r7;
	reg [0:3]B, C, D, SL, SH, PL, PH;
	
	output reg [0:3]A;
	
	//ALU
	//0b0000 nop
	//0b0001 add
	//0b0010 addc
	//0b0011 mov
	//0b0100 ldi
	//0b0101 move between register
	//0b0110 ld from flash to register
	always @(posedge clk)
	begin
		if(rst_n)
		begin
			case (data_bus[0:3])
				4'h0: out = 16'b0000000000000001;
				4'h1: out = 16'b0000000000000010;
				4'h2: out = 16'b0000000000000100;
				4'h3: out = 16'b0000000000001000;
				4'h4: out = 16'b0000000000010000;
				4'h5: out = 16'b0000000000100000;
				4'h6: out = 16'b0000000001000000;
				4'h7: out = 16'b0000000010000000;
				4'h8: out = 16'b0000000100000000;
				4'h9: out = 16'b0000001000000000;
				4'h10: out = 16'b0000010000000000;
				4'h11: out = 16'b0000100000000000;
				4'h12: out = 16'b0001000000000000;
				4'h13: out = 16'b0010000000000000;
				4'h14: out = 16'b0100000000000000;
				4'h15: out = 16'b1000000000000000;
				default: out = 16'b0000000000000000;
			endcase
		end
		else
			out = 0;
	end
	
	always @(posedge clk)//adder
	begin
		case(out)
			16'b0000000000000001:r0 = r0 + r1;
			16'b0000000000001000:
			begin
				case(data_bus[4:7])
					4'h0: case(data_bus[8:11])
						4'h0: A = A;
						4'h1: A = B;
						4'h2: A = C;
						4'h3: A = D;
					endcase
					4'h1: case(data_bus[8:11])
						4'h0: B = A;
						4'h1: B = B;
						4'h2: B = C;
						4'h3: B = D;
					endcase
					4'h2: case(data_bus[8:11])
						4'h0: C = A;
						4'h1: C = B;
						4'h2: C = C;
						4'h3: C = D;
					endcase
					4'h3: case(data_bus[8:11])
						4'h0: D = A;
						4'h1: D = B;
						4'h2: D = C;
						4'h3: D = D;
					endcase
				endcase
			end
			16'b0000000000010000: B = data_bus[4:7];
		endcase	
	end
	
	
endmodule //

