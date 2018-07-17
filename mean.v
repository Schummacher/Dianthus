module mean#(
  parameter buf_size = 16,	//The deepth of buf for culculating mean value
  parameter bit_wide = 8,	//Quantum of per bit
  parameter cont_bit = 4	//How many bits of SUM needed 
)
(
  out,
  in,
  rst_n,
  clk
);

`define wide bit_wide - 1
`define size buf_size - 1
`define cont cont_bit - 1

input [`wide:0] in;
input rst_n, clk;
output reg [`wide:0] out;

integer N;

reg [`wide:0]queue[`size:0];
reg [`wide+`cont+1:0]sum;
reg [`cont:0]counter;

integer i;


always @(posedge clk) begin
  if (rst_n) begin
    sum = sum - queue[counter];
    sum = sum + in;
    queue[counter] = in;
    out = sum[`wide+`cont+1:`cont+1];
    counter = counter + 1;
  end
  else begin
    N = `size+1;
    counter = 0;
    sum = 0;
    for (i = 0; i < N; i = i + 1) begin :asdfgh
      queue[i] = 0;
    end
  end
end


endmodule // mean
