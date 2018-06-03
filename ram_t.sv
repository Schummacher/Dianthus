`timescale 1ns/1ns

module ram_t;
    bit clk;
    wire rst_n;

    always #5 clk = ~clk;

    initial begin
        clk = 1;
    end

    ram_if rif();
    ctrl_if cif(clk);
    ram U1(rif, cif);
    ram_tb U2(rif, cif);
    
endmodule