module even (clk,rst,n,clk_out);
input clk;
input rst;
input [3:0] n;
output wire clk_out;

reg [2:0]count;//=3'd0;
reg out;//=1'b1;
wire [3:0]a;

assign a=((n/2)-1);

always @ (posedge clk)
begin
if(rst)
  begin
  count <= 0;
  out <= 1'b1;
  end
else
  begin
    if(count == a)
      begin
      count <= 3'd0;
      out <= ~out;
      end
    else
      count <= count + 1;
  end
end

assign clk_out = out;
endmodule





// testbench



module tb ();
reg clk,rst;
reg [3:0] n;
wire clk_out;

even tb1 (clk,rst,n,clk_out);

always #2 clk = ~clk;

initial begin
clk = 1; rst = 1; 

#2 rst=0; n = 12;
end

initial
#200 $finish;

initial begin
$dumpfile("dump_even.vcd");
$dumpvars();
end

endmodule

