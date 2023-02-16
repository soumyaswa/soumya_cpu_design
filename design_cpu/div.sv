//div using comparator
module comparator #(parameter N=16) (
input [N-1:0] rs1,
input [N-1:0] rs2,
output wire greater,
output wire equal,
output wire less
);
assign greater = (rs1 > rs2);
assign equal = (rs1 == rs2);
assign less = (rs1 < rs2);
endmodule

// Division module
module division #(parameter N=16) (
input [N-1:0] dividend,
input [N-1:0] divisor,
output [N-1:0] quotient,
output [N-1:0] remainder
);
reg [N-1:0] current_dividend;
reg [N-1:0] current_quotient;
integer i;

// Initialize current_dividend and current_quotient
always @(*) begin
current_dividend = dividend;
current_quotient = 0;
end

// Loop through each bit of the dividend
always @(*) begin
for (i=N-1; i>=0; i=i-1) begin
// Shift current_dividend and current_quotient left-----------//the "always" block is triggered whenever any of its inputs change. The "for" loop loops through each bit of the "dividend" array, starting from the most significant bit (index N-1) and going down to the least significant bit (index 0).Within the loop, the "current_dividend" and "current_quotient" arrays are shifted left by one bit using concatenation. The most significant bit of each array is discarded, and a zero is inserted at the least significant bit. This has the effect of multiplying each array by two.

  current_dividend = {current_dividend[N-1], current_dividend[N-2:0]};
  current_quotient = {current_quotient[N-1], current_quotient[N-2:0]};
// /After the arrays are shifted, a "comparator" module is instantiated with the "current_dividend" and "divisor" arrays as inputs. The "greater", "equal", and "less" outputs of the "comparator" module .
  
  comparator #(N) comp1(
	     	.rs1(current_dividend),
		.rs2(divisor),
		.greater(current_dividend >= divisor),
		.equal(current_dividend == divisor),
    		.less(current_dividend <= divisor)
);
  
  
// Increment current_quotient if current_dividend >= divisor  ---//If the "current_dividend" is greater than or equal to the "divisor", the "current_dividend" is subtracted by the "divisor", and the least significant bit of the "current_quotient" is set to 1. This has the effect of subtracting the "divisor" from the "current_dividend" as many times as possible and accumulating the number of times it was subtracted in the "current_quotient".
if (current_dividend >= divisor) begin
current_dividend = current_dividend - divisor;
current_quotient[0] = 1;
end
end
end

assign quotient = current_quotient;
assign remainder = current_dividend;
endmodule





//refering with nitin's mul code
/*module full_subtractor #(parameter N=16)
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
  
endmodule*/

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
