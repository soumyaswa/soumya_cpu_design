`include "div_cycle.sv"

module top;
  
  parameter N=16;
  
  bit clk, rstn, req, ready;
  bit [N-1:0] D, d, Q, R;
  
  //assign clk = #5 ~clk; 
  initial begin
    forever begin
      clk = 0;
      #5;
      clk = 1;
      #5;
    end
  end
  
  Divider#(N) Div(
    .clk(clk),
    .rstn(rstn),
    .req(req),
    .Dividend(D),
    .Divisor(d),
    .Q(Q),
    .R(R),
    .ready(ready),
    .exception()
  );
  
  initial begin
    $monitor("%b, %d",ready, Q);
    rstn = 0;
    @(negedge clk);
    @(negedge clk);
    rstn = 1;
    req = 1;
    D = 15/*16'hFFFF*/;
    d = 2/*2*/;
    fork 
      @(posedge ready);
      repeat(10000) begin
        @(posedge clk);
      end
    join_any
    $display("%fns: %d/%d = %d", $realtime, D, d, Q);
    #100;      
    $finish;
  end
  
  
  initial
    begin
      $dumpfile("abc.vcd");
      $dumpvars();
    end
endmodule

/*module top;
  
  parameter N=16;
  
  bit clk, rstn, req, ready;
  bit [N-1:0] D, d, Q, R;
  integer expected_quotient;
integer expected_remainder;
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  divider #(N) Div (
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
    D = 14;
    d = 2;
    fork 
      @(posedge ready);
      repeat(10) begin
        @(posedge clk);
        if (d == 0) begin
          d = 1;
        end
  // Calculate expected quotient and remainder
        expected_quotient = D / d;
        expected_remainder = D % d;
        // give the output
        if (expected_remainder ==0) begin
          $display("pass");
        end
        else begin
          $display("fail");
        end
        
      end
    join_any
         
    $display("%fns: %d/%d = %d", $realtime, D, d, Q);
    $display("output: D =%d d=%d Q=%d R=%d ", D,d,Q,R);
  //end
    #100;      
    $finish;
  end
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(1);
  end

endmodule*/

/*`timescale 1ns/1ns

module tb_divider;

  parameter N=16;
  
  reg clk, rstn, req;
  reg [N-1:0] D, d;
  wire [N-1:0] Q, R;
  wire ready, exception;
  
  divider #(N) dut (
    .clk(clk),
    .rstn(rstn),
    .req(req),
    .Dividend(D),
    .Divisor(d),
    .Q(Q),
    .R(R),
    .ready(ready),
    .exception(exception)
  );
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    // Reset the design
    rstn = 0;
    req = 0;
    D = 0;
    d = 0;
    #10;
    rstn = 1;
    
    // Test case 1
    D = 65000;
    d = 6700;
    req = 1;
    #100;
    req = 0;
    // Wait for the output
    repeat(10) @(posedge clk);
    // Check the output
    if (Q == 9 || R == 4700 || exception == 0 || ready == 1) begin
      $display("Test case 1 passed .");
    end else begin
      $display("Test case 1 failed.");
    end
    
    // Test case 2
    D = 6700;
    d = 0;
    req = 1;
    #100;
    req = 0;
    // Wait for the output
    repeat(10) @(posedge clk);
    // Check the output
    if (Q == 0 || R == 6700 || exception == 1 || ready == 1) begin
      $display("Test case 2 passed.");
    end else begin
      $display("Test case 2 failed.");
    end
    
    // Test case 3
    D = 6700;
    d = 6700;
    req = 1;
    #100;
    req = 0;
    // Wait for the output
    repeat(10) @(posedge clk);
    // Check the output
    if (Q == 1 || R == 0 || exception == 0 || ready == 1) begin
      $display("Test case 3 passed.");
    end else begin
      $display("Test case 3 failed.");
    end
    
    // End the simulation
    #100;
    $finish;
  end
  
endmodule*/


/*`include "div_new.sv"
module top;
  
  parameter N=16;
  
  bit clk, rstn, req, ready;
  bit [N-1:0] D, d, Q, R;
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  divider #(N) Div (
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
    D = 65000;
    d = 6700;
    fork 
      @(posedge ready);
      repeat(10000) begin
        @(posedge clk);
      end
    join_any
    $display("%fns: %d/%d = %d", $realtime, D, d, Q);
    #100;      
    $finish;
  end
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(1);
  end

endmodule*/
