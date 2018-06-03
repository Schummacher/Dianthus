module ram_tb(ram_if.TEST rif, ctrl_if.TEST cif);	

	
	initial begin
		cif.rst_n = 1;
		#11
		cif.rst_n = 0;
		#10
		cif.rst_n = 1;
		rif.EN = 1;
		rif.RW = 1;
		rif.address = 0'h00;
		rif.data_in = 0'b1100;
		#10
		rif.address = 0'h01;
		rif.data_in = 0'b0011;
		#10
		cif.rst_n = 0;
		#100 $stop;
	end
endmodule
