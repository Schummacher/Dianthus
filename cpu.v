module cpu(
    ram_RW, //high is write
    ram_EN,
    ram_address_bus,
    ram_data_bus_out,
    ram_data_bus_in,
    instrution_bus,
    rst_n,
    clk);

    output reg ram_RW, ram_EN;
    output reg [0:7]ram_address_bus;
    output reg [0:3]ram_data_bus_out;
    output [0:3]ram_data_bus_in;

	input clk, rst_n;
	input [0:11]instrution_bus;

	reg [0:16]select;

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
			case (instrution_bus[0:3])
				4'hF: select = 16'b0000000000000001;	//CLI
				4'hE: select = 16'b0000000000000010;	//SBI
				4'hD: select = 16'b0000000000000100;	//PJMP
				4'hC: select = 16'b0000000000001000;	//JMP
				4'hB: select = 16'b0000000000010000;	//XOR
				4'hA: select = 16'b0000000000100000;	//OR
				4'h9: select = 16'b0000000001000000;	//AND
				4'h8: select = 16'b0000000010000000;	//POP
				4'h7: select = 16'b0000000100000000;	//PUSH
				4'h6: select = 16'b0000001000000000;    //OUT
				4'h5: select = 16'b0000010000000000;	//IN
				4'h4: select = 16'b0000100000000000;	//LDI
				4'h3: select = 16'b0001000000000000;	//MOV
				4'h2: select = 16'b0010000000000000;	//ADC
				4'h1: select = 16'b0100000000000000;	//ADD
				4'h0: select = 16'b1000000000000000;	//NOP
				default: select = 16'b0000000000000000;
			endcase
		end
		else
			select = 0;
	end

	always @(posedge clk)//adder
	begin
        ram_EN = 0;
		if(rst_n)
		begin
			case(select)
				16'b0100000000000000:A = A + B;
				16'b0001000000000000:
				begin
					case(instrution_bus[8:11])
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
					case(instrution_bus[4:7])
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
				16'b0000100000000000: B = instrution_bus[4:7];
				16'b0000010000000000:
                begin
                    ram_RW = 0;
                    ram_address_bus = instrution_bus[4:11];
                    ram_EN = 1;
                    D = ram_data_bus_in;
                end
                16'b0000001000000000:
                begin
                    ram_RW = 1;
                    ram_address_bus = instrution_bus[4:11];
                    ram_data_bus_out = C;
                    ram_EN = 1;
                end
				16'b0000000001000000: D = D & C;
				16'b0000000000100000: D = D | C;
				16'b0000000000010000: D = D ^ C;
				default:
				begin
					A = A;
					B = B;
					C = C;
					D = D;
					SL = SL;
					SH = SH;
					PL = PL;
					PH = PH;
					R0 = R0;
					R1 = R1;
					R2 = R2;
					R3 = R3;
					R4 = R4;
					R5 = R5;
					R6 = R6;
					R7 = R7;
				end
			endcase
		end
		else
		begin
			ram_EN = 0;
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
	end

endmodule //
