`define ODD4
module test(clk,rst,seq_out);
input clk,rst;
output wire [3:0]seq_out;
reg [3:0]init = 4'd15;
reg [3:0]count = 3'd0;
reg [3:0]cnt_reg = 3'd0;


assign  seq_out = count;

always @ (cnt_reg)
begin
 count = cnt_reg;
end



always @ (posedge clk or negedge rst)
begin
if(!rst)
  begin
    count <= 0; 
    // cnt_reg <= 0; 
  end

else
  begin
      `ifdef SEQ
       begin
         if(cnt_reg < init)
           begin
             if(count==init)
               begin
                 cnt_reg <= cnt_reg + 1;
                 count <= cnt_reg;
               end
             else
               count <= count + 1;               
           end // if end
          else
              begin
              cnt_reg <= 0; count <= 0;
              end 
        end

       `elsif EVN
        begin
          if(cnt_reg < init)
            begin
             if(count==init)
               begin
                 cnt_reg <= cnt_reg + 2;
                 count <= cnt_reg;
               end
             else
                 count <= count + 1;               
            end // if end
            else
              begin
              cnt_reg <= 0; count <= 0;
              end
         end
       
        `elsif ODD
         begin
           if(cnt_reg < init)
           begin
             if(count==init)
               begin
                 cnt_reg <= (cnt_reg == 0) ? (cnt_reg + 1):(cnt_reg + 2);
                 count <= cnt_reg;
               end
             else
               count <= count + 1;               
           end // if end
          else
            begin
            cnt_reg <= 0; count <= 0;
            end
         end


        `elsif ODD4
         begin
           if(cnt_reg < init)
           begin
             if(count==init)
               begin
                 if(cnt_reg == 0 | cnt_reg == 7)
                    cnt_reg <= cnt_reg + 1;
                 else if(cnt_reg == 8)
                    cnt_reg <= cnt_reg + 3;
                 else
                    cnt_reg <= cnt_reg + 2;
               end
             else
               begin
                 if(count == 0 | count == 7)
                    count <= count + 1;
                 else if(count == 8)
                    count <= count + 3;
                 else
                    count <= count + 2;
               end               
           end // if end
          else
            begin
            cnt_reg <= 0; count <= 0;
            end
         end



        `else
         begin
           if(cnt_reg < init)
           begin
             if(count==init)
               begin
                 count <= cnt_reg;
               end
             else
               count <= count + 1;
                          
           end // if end
           else
            begin
            cnt_reg <= 0; count <= 0;
            end
         end
        `endif

  end // top else end

end

endmodule























// testbench


module test_tb();
reg clk;
reg rst;
wire c;

test tb (.clk(clk),.rst(rst),.seq_out(seq_out));

initial begin
clk=1;rst=0;
forever #2 clk = ~clk;
end

initial begin
@ (negedge clk)
rst=1;
end

initial begin
#600;
$finish;
end 

initial
begin 
$dumpfile("dump_seq.vcd");
$dumpvars();
end
 
endmodule

