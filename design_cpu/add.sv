/*module add(rs1, rs2, add_rd,co);
  parameter N=16;
  input [N-1:0] rs1, rs2;
  
  output reg [N-1:0] add_rd;
  output reg [N-1:0] co;
 
  genvar i;
   generate
   for(i=0;i<N;i++) begin
     xor x1(add_rd[i];rs1[i],rs2[i]);
     and a1(co[i],rs1[i],rs2[i]);
   end
   endgenerate
endmodule*/
module add(rs1, rs2, rd);
  input [15:0] rs1, rs2;  //rs1,rs2 are 16 bit values
  output reg [15:0] rd;   //rd is 16 bit value

  reg [15:0] operand1, operand2;   
  reg [16:0] result;  
reg carry_out;  

always @(*) begin
operand1 = rs1;  
operand2 = rs2; 
result = operand1 + operand2;
  carry_out = (result > 16'hffff);   //checks if the value stored in the "result" register is greater than the maximum value that can be represented in 16 bits.
rd = result[15:0];
end
endmodule
