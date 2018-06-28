module mean_tb;
    
reg [7:0] in;
reg rst_n, clk;
wire [7:0] out;

mean #(16, 8, 4)U1(out, in, rst_n, clk);

initial begin
    clk = 1;
    rst_n = 0;
    in = 1;
    #12 rst_n = 1;
    #10 in = 128;
    #10 in = 124;
    #10 in = 127;
    #10 in = 120;
    #10 in = 124;
    #10 in = 122;
    #10 in = 124;
    #10 in = 126;
    #10 in = 128;
    #10 in = 123;
    #10 in = 128;
    #10 in = 124;
    #10 in = 127;
    #10 in = 120;
    #10 in = 124;
    #10 in = 122;
    #10 in = 124;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    $stop;
end

always #5 clk = ~clk;

endmodule