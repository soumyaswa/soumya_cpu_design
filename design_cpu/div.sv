module div(rs1, rs2, rd1,rd2); //This is a Verilog module that implements integer division of two 16-bit input operands rs1_val and rs2_val and produces a 16-bit output rd_val.
  input [15:0] rs1, rs2;
  output [15:0] rd1,rd2;
   reg [15:0] rd1,rd2;
   reg [31:0] dividend, divisor;
   reg [15:0] quotient, remainder;
integer i;

always @(*) begin
dividend = rs1;
divisor = rs2;
quotient = 0;
remainder = 0;

  for (i = 31; i >= 0; i = i - 1) begin  ///loop is executed 31 times (once for each bit position of the 32-bit dividend and quotient). 
    remainder = (remainder << 1) + (dividend[i] & 1); //In each iteration, the remainder is shifted left by 1 bit and the least significant bit of dividend is added to it.
    quotient[i] = (remainder >= divisor); //If the remainder is greater than or equal to divisor, the corresponding bit of the quotient is set to 1 and the remainder is decremented by divisor.
  if (quotient[i])
    remainder = remainder - divisor;
end

rd1 = quotient;
rd2 = remainder;
  
end
endmodule
