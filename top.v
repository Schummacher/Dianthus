module top(instrution_bus, rst_n, clk);
	input clk, rst_n;
	input [0:11]instrution_bus;

	wire [0:3]ram_data_bus_c2r;
	wire [0:3]ram_data_bus_r2c;
	wire [0:7]ram_address_bus;
	wire ram_RW;
	wire ram_EN;


	cpu U1(
    	ram_RW,
    	ram_EN,
    	ram_address_bus,
    	ram_data_bus_c2r,
    	ram_data_bus_r2c,
    	instrution_bus,
    	rst_n,
    	clk);

	ram U2(
		ram_data_bus_r2c,
		ram_data_bus_c2r,
		ram_address_bus,
		ram_RW,
		ram_EN,
		rst_n,
		clk);
endmodule //
