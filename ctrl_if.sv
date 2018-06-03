interface ctrl_if(input clk);
   logic rst_n;

   modport TEST(
       input clk,
       output rst_n
   );
   
   modport DUT(
       input clk, rst_n
   );
endinterface //ctrl_if