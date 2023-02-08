/*module sub(rs1,rs2,sub_rd);
  parameter N=16;
  input [N-1:0] rs1, rs2;            
  output reg [N-1:0] sub_rd;

      genvar i;
      for(i=0;i<N;i++)begin
          xor x2(sub_rd[i],rs1[i],rs2[i]);
  end
endmodule*/


module sub(rs1, rs2, rd);
input [15:0] rs1, rs2; //rs1,rs2 are 16-bit values
output reg [15:0] rd; //rd is 16-bit value

reg [15:0] operand1, operand2; //stores the rs1 and rs2 values
reg [16:0] result; //stores result of the subtraction of "operand2" from "operand1"

always @(*) begin
operand1 = rs1; //assigns the input value to operand1
operand2 = rs2; //assigns the input value to operand2
result = operand1 - operand2;
rd = result[15:0];
end
endmodule
