`include "mul.sv"
`include "div.sv"
`include "comp.sv"
`include "add.sv"
`include "sub.sv"

module divider_fsm_tb;

// Parameters
parameter N = 16;
parameter MAX_TEST_CASES = 5;

// Inputs
reg clk;
reg reset;
reg unsigned [N-1:0] dividend;
reg unsigned [N-1:0] divisor;

// Outputs
wire [N-1:0] quotient;
wire [N-1:0] remainder;
wire done;

// Instantiate the module under test
divider_fsm #(N) dut (
.clk(clk),
.reset(reset),
.dividend(dividend),
.divisor(divisor),
.quotient(quotient),
.remainder(remainder),
.done(done)
);

// Define variables
integer i;
integer expected_quotient;
integer expected_remainder;
integer done_out;


// Initialize inputs
initial begin
clk = 0;
reset = 0;
dividend = 0;
divisor = 0;
#10;
reset = 1;
#10;
reset = 0;
end

// Generate test cases
initial begin
for (i = 0; i < MAX_TEST_CASES; i = i + 1) begin
// Generate random dividend and divisor
dividend = 2/*$random*/ ;
divisor = 12/*$random*/ ;

// Avoid divide by zero errors
if (divisor == 0) begin
divisor = 1;
end
  // Calculate expected quotient and remainder
  expected_quotient = dividend / divisor;
  expected_remainder = dividend % divisor;

// give the output
  if (expected_remainder ==0) begin
     done_out = 0;
     
  end
  else begin
       done_out = 1;
      
end

// Wait for the module to finish
repeat (10) begin
#1 clk = ~clk;
end



  $display("output: dividend =%d divisor=%d quotient=%d remainder=%d done=%d", dividend,divisor, expected_quotient, expected_remainder, done_out);
end
$finish;


end

endmodule


/*module top;
  reg [15:0]rs1,rs2;
  wire [15:0]rd,add_rd,co;
  
  reg [3:0]a,b;
  wire [7:0] p;
  
  bit [15:0] greater,equal,less; 
  division dut(rs1,rs2,greater,equal,less); 
  
  //multiplier_4x4 mul_dut(a,b,p);

  //add add_dut(rs1,rs2,add_rd,co);
  //sub sub_dut(rs1,rs2,rd); 
  //mul mul_dut(rs1,rs2,rd);
  //div div_dut(rs1, rs2, rd1,rd2);
 // div div_dut(rs1, rs2, rd);
  initial begin
    repeat(1)begin
      rs1=12;
      rs2=2;
      #1;
      $display("rs1=%d, rs2=%d, greater=%d, equal=%d ,less=%d", rs1,rs2,greater,equal,less); */
     // $display("rs1=%d, rs2=%d, rd=%d", rs1,rs2,rd); 
    //  $display("division output: rs1=%d, rs2=%d, rd1=%d, rd2=%d", rs1,rs2,rd1,rd2); 
      
      /*a=12;
      b=2;
      #5;
      $display("a=%d, b=%d, p=%b", a,b,p);*/
    /*end
    
  end
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(1);
  end
  
endmodule*/



