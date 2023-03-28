`include "div_with_bug_fix.sv"
module top;
  
  parameter N=16;
  
  bit clk, rstn, req, ready;
  bit [N-1:0] D, d, Q, R;
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  divider  #(N) Div(
    .clk(clk),
    .rstn(rstn),
    .req(req),
    .Dividend(D),
    .Divisor(d),
    .Q(Q),
    .R(R),
    .ready(ready)
  );
  
  initial begin
    $monitor("%b, %d",ready, Q);
    rstn = 0;
    @(negedge clk);
    @(negedge clk);
    rstn = 1;
    req = 1;
    D = 600;
    d = 599;
    fork 
      @(posedge ready);
      repeat(10000) begin
        @(posedge clk);
      end
    join_any
    $display("%fns: %d/%d = %d", $realtime, D, d, Q);
    $display("%0tns: D=%0d,d=%0d,Q=%0d,R=%0d", $realtime, D, d, Q, R);
    #1000;      
    $finish;
  end
  initial begin 
$dumpfile("abc.vcd");
$dumpvars(0);
end
endmodule
