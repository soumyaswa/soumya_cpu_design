//refering with nitin's mul code
module full_subtractor #(parameter N=16)
  (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] Diff,
    output Borrow
  );
  
  wire [N-1:0] temp;
  
  assign temp = A - B;
  assign Diff = temp;
  assign Borrow = (A < B);
  
endmodule

module divider#(parameter N=16)( 
  input [N-1:0] Dividend,
  input [N-1:0] Divisor,
  output [N-1:0] Quotient,
  output [N-1:0] Remainder
);
  
  wire [N-1:0] temp_remainder;
  wire [N-1:0] current_dividend;
  wire Quotient_bit;
  
  initial begin
    temp_remainder = Dividend;
    Quotient = 0;
  end
  
  genvar i;
  
  generate
    for(i=N-1; i>=0; i=i-1)begin
      current_dividend = {temp_remainder[N-1:i], Quotient[i-1:0]};  //The result of the concatenation operation is a new N-bit value current_dividend with the higher N-i bits taken from temp_remainder and the lower i bits taken from Quotient. 
      full_subtractor#(N) fs(
        .A(current_dividend),
        .B(Divisor),
        .Diff(temp_remainder),
        .Borrow(Quotient_bit)
      );
      assign Quotient[i] = Quotient_bit;
    end
  endgenerate

  assign Remainder = temp_remainder;
  
endmodule

//NOTE:-The temp_remainder wire keeps track of the intermediate result and Quotient wire keeps track of the quotient bits. The division is performed by shifting the intermediate result and subtracting the divisor until the remainder is less than the divisor. The corresponding quotient bit is then set to 1, and the process repeats until all the bits are processed. The final result, the Remainder, is assigned to the temp_remainder wire.





/*module div(rs1, rs2, rd1,rd2); //This is a Verilog module that implements integer division of two 16-bit input operands rs1_val and rs2_val and produces a 16-bit output rd_val.
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
endmodule*/
