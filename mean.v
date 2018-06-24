module mean(
  out,
  in,
  rst_n,
  clk
);

input [7:0] in;
input rst_n, clk;
output reg [7:0] out;

integer N;

reg [7:0]queue[15:0];
reg [11:0]sum;
reg [3:0]counter;

integer i;


always @(posedge clk) begin
  if (rst_n) begin
    sum = sum - queue[counter];
    sum = sum + in;
    queue[counter] = in;
    out = sum[11:4];
    counter = counter + 1;
  end
  else begin
    N = 16;
    counter = 0;
    sum = 0;
    for (i = 0; i < N; i = i + 1) begin :asdfgh
      queue[i] = 0;
    end
  end
end


endmodule // mean