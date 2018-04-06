module top(out, data_bus, address_bus, rst_n, clk);
	input clk, rst_n;
	input [0:11]data_bus;
	input [0:8]address_bus;
	output reg [0:16]out;

	reg [0:15]en_bus;
	reg [0:3]mov_tmp;

	reg [0:3]R0, R1, R2, R3, R4, R5, R6, R7;
	reg [0:3]A, B, C, D, SL, SH, PL, PH;

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
				4'hF: out = 16'b0000000000000001;
				4'hE: out = 16'b0000000000000010;
				4'hD: out = 16'b0000000000000100;
				4'hC: out = 16'b0000000000001000;
				4'hB: out = 16'b0000000000010000;
				4'hA: out = 16'b0000000000100000;
				4'h9: out = 16'b0000000001000000;
				4'h8: out = 16'b0000000010000000;
				4'h7: out = 16'b0000000100000000;
				4'h6: out = 16'b0000001000000000;
				4'h5: out = 16'b0000010000000000;
				4'h4: out = 16'b0000100000000000;	//LDI
				4'h3: out = 16'b0001000000000000;	//MOV
				4'h2: out = 16'b0010000000000000;	//ADC
				4'h1: out = 16'b0100000000000000;	//ADD
				4'h0: out = 16'b1000000000000000;	//NOP
				default: out = 16'b0000000000000000;
			endcase
		end
		else
			out = 0;
	end

	always @(posedge clk)//adder
	begin
		case(out)
			16'b0100000000000000:A = A + B;
			16'b0001000000000000:
			begin
				case(data_bus[8:11])
					4'h0: mov_tmp = A;
					4'h1: mov_tmp = B;
					4'h2: mov_tmp = C;
					4'h3: mov_tmp = D;
					4'h4: mov_tmp = SL;
					4'h5: mov_tmp = SH;
					4'h6: mov_tmp = PL;
					4'h7: mov_tmp = PH;
					4'h8: mov_tmp = R0;
					4'h9: mov_tmp = R1;
					4'h10: mov_tmp = R2;
					4'h11: mov_tmp = R3;
					4'h12: mov_tmp = R4;
					4'h13: mov_tmp = R5;
					4'h14: mov_tmp = R6;
					4'h15: mov_tmp = R7;
				endcase
				case(data_bus[4:7])
					4'h0: A = mov_tmp;
					4'h1: B = mov_tmp;
					4'h2: C = mov_tmp;
					4'h3: D = mov_tmp;
					4'h4: SL = mov_tmp;
					4'h5: SH = mov_tmp;
					4'h6: PL = mov_tmp;
					4'h7: PH = mov_tmp;
					4'h8: R0 = mov_tmp;
					4'h9: R1 = mov_tmp;
					4'h10: R2 = mov_tmp;
					4'h11: R3 = mov_tmp;
					4'h12: R4 = mov_tmp;
					4'h13: R5 = mov_tmp;
					4'h14: R6 = mov_tmp;
					4'h15: R7 = mov_tmp;
				endcase
			end
			16'b0000100000000000: B = data_bus[4:7];
			default:
			begin
				A = 0;
				B = 0;
				C = 0;
				D = 0;
				SL = 0;
				SH = 0;
				PL = 0;
				PH = 0;
				R0 = 0;
				R1 = 0;
				R2 = 0;
				R3 = 0;
				R4 = 0;
				R5 = 0;
				R6 = 0;
				R7 = 0;
			end
		endcase
	end


endmodule //
