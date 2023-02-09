`include "mul.sv"
`include "div.sv"
`include "add.sv"
`include "sub.sv"
module top;
  reg [15:0]rs1,rs2;
  wire [15:0]rd,add_rd,co,mul_rd;
  
  reg [3:0]a,b;
  wire [7:0] p;

  
  //multiplier_4x4 mul_dut(a,b,p);

  //add add_dut(rs1,rs2,add_rd,co);
  //sub sub_dut(rs1,rs2,rd); 
  //mul mul_dut(rs1,rs2,mul_rd);
  //div div_dut(rs1, rs2, rd1,rd2);
 // div div_dut(rs1, rs2, rd);
  initial begin
    repeat(1)begin
      rs1=12;
      rs2=2;
      #1;
      $display("rs1=%d, rs2=%d, rd=%d", rs1,rs2,rd); 
    //  $display("division output: rs1=%d, rs2=%d, rd1=%d, rd2=%d", rs1,rs2,rd1,rd2); 
      
      /*a=12;
      b=2;
      #5;
      $display("a=%d, b=%d, p=%b", a,b,p);*/
    end
    
  end
  
  initial begin
    $dumpfile("test.vcd");
    $dumpvars(1);
  end
  
endmodule


/*module top;
  
  reg [15:0] Dividend;
  reg [15:0] Divisor;
  wire [15:0] Quotient;
  wire [15:0] Remainder;
  
  divider dut(Dividend,Divisor,Quotient,Remainder);

  
  initial begin
 //   $monitor("%d / %d = %d",a,b,c);
    #1;
    Dividend = 11;
    Divisor = 2;
    #1
    $display("%d, %d",Quotient,Remainder);
    #10;
    $finish;
  end
  
    
  initial begin
     $dumpfile("abc.vcd");
    $dumpvars(0);
  end
endmodule
  
*/
