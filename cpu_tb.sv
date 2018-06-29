`timescale 1ns/1ns

module cpu_tb;

//port definition of DUT
wire ram_RW, ram_EN;
wire [7:0]ram_address_bus;
wire [3:0]ram_data_bus_out;
wire [3:0]ram_data_bus_in;

reg clk, rst_n;
reg [11:0]instruction_bus;

//instantiating DUT
cpu U1(
	ram_RW,
	ram_EN,
	ram_address_bus,
	ram_data_bus_out,
	ram_data_bus_in,
	instruction_bus,
	rst_n,
	clk);

//test circuit port
wire carry, carry_1, carry_2;
wire [3:0]random_out, random_out_1, random_out_2;
reg [3:0]reset_in;
reg enable_n, enable_n_1, enable_n_2;

//random test vector generation
lfsr U2(
	carry,
	random_out,
	reset_in,
	enable_n,
	rst_n,
	clk);

lfsr U3(
	carry_1,
	random_out_1,
	reset_in,
	enable_n_1,
	rst_n,
	clk);

lfsr U4(
	carry_2,
	random_out_2,
	reset_in,
	enable_n_2,
	rst_n,
	clk);

integer file_cut;


//un_cycle sigal input
initial begin
	rst_n = 0;
	clk = 0;
	enable_n = 0;
	reset_in = 2'b0001;
	#11
	rst_n = 1;
	#22
	rst_n = 1;
	enable_n = 1;
	rst_n = 1;
	#10000
	$stop;
end

//clock generation
always #5 clk = ~clk;

always #1 instruction_bus[3:0] = random_out;
always #1 instruction_bus[7:4] = random_out_1;
always #1 instruction_bus[11:8] = random_out_2;
always #1 enable_n_1 = carry;
always #1 enable_n_2 = carry_1;


always @(posedge clk) begin
	$display(random_out);
end

initial file_cut = $fopen("./qqqwwwqqq.txt", "w");

always @(posedge clk) begin
	$fwrite(file_cut, "clk = %d", clk);
end

endmodule
