module ram(data_out, data_in, address, RW, EN, rst_n, clk);
    output reg [0:3]data_out;
    input [0:3]data_in;
    input [0:7]address;
    input RW, EN, rst_n, clk;

    reg [0:3]register;

    always @(posedge clk)
    begin
        if(EN)
            if(RW)
                register = data_in;
            else
                data_out = register;
    end
endmodule
