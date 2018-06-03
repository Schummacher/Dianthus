interface ram_if();
    logic [3:0]data_out;
	logic [3:0]data_in;
	logic [7:0]address;
	logic RW, EN;

	modport TEST (
		input data_out,
		output data_in, address, RW, EN
	);

	modport DUT (
		output data_out,
		input data_in, address, RW, EN
	);

	modport MONIT (
		input data_out,
		output data_in, address, RW, EN
	);
endinterface //ram_if