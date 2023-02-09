// Full Adder module
module full_adder #(parameter N=16)
  (
    input [N-1:0] rs1,
    input [N-1:0] rs2,
    output [N-1:0] mul_rd
  );
  
  // Add inputs rs1 and rs2 to get output mul_rd
  assign  mul_rd = rs1 + rs2;
  
endmodule

// Multiplier module
module mul #(parameter N=16)
  (
    input [N-1:0] rs1,
    input [N-1:0] rs2,
    output [2*N-1:0] mul_rd
  );
  
  // Temporary arrays to store intermediate values
  wire [N][N-1:0] temp1;
  wire [N][2*N-1:0] temp2;
  wire [N][2*N-1:0] temp3;
  
  // Initialize the first bit of the intermediate values
  assign temp1[0] = (rs2[0]) ? rs1 : 0;
  assign temp2[0] = temp1[0] << 0;
  assign temp3[0] = temp2[0];
  
  // Loop through each bit of rs2
  genvar i;
  generate
    for (i=1; i<=N-1; i++)
    begin
      // Calculate intermediate values based on the current bit of rs2
      assign temp1[i] = (rs2[i]) ? rs1 : 0;
      assign temp2[i] = temp1[i] << i;
      
      // Use full_adder module to add intermediate values
      full_adder #(2*N) fa(
        .rs1(temp3[i-1]),
        .rs2(temp2[i]),
        .mul_rd(temp3[i])
      );
    end
  endgenerate
  
  // Assign final output to the last element of temp3
  assign mul_rd = temp3[N-1];
  
endmodule







//NOTE:-- In this design, the multiplier_4x4 module takes two 4-bit inputs a and b, and produces an 8-bit output p. The multiplication is performed by four instances of the and_gate_4x4 module, each of which takes one bit of a and the entire b as inputs, and produces one bit of the output.


/*module multiplier_4x4 ( 
  input [3:0] a,
  input [3:0] b,
  output reg [7:0]  p ); 
  //reg [3:0] w_a;
  //reg [3:0]w_b; 
  //reg [7:0] w_p;
  assign w_a = a;
  assign w_b = b;
  
  and_gate_4x4 and1(a[0],b[0],p[0]);
  //assign p[0]=w_p[0];
 
  and_gate_4x4 and2(a[1],b[1],p[2]); 
  //assign p[1]=w_p[2];
  
  and_gate_4x4 and3(a[2],b[2],p[4]);
  //assign p[2]=w_p[4];
  and_gate_4x4 and4(a[3],b[3],p[6]);
  //assign p[3]=w_p[6];
  //assign p=w_p;
endmodule 


module and_gate_4x4 ( 
  input [3:0]a, 
  input  [3:0]b, 
  output reg[7:0] p ); 
  //assign p = a && b; 	// a=1, b=1001
  genvar i;
  for(i=0;i<4;i++)begin
    and a1(p[i],a[i],b[i]);
    always@(*)
    $display("p=%b",p[i]);
  end
  //always@(*)
    //$display("p=%d",p[i]);
endmodule*/



/*module mul(rs1, rs2, rd);  //two 16-bit inputs rs1 and rs2 and outputs a 32-bit result in rd.
  input [15:0] rs1, rs2;
  output [31:0] rd;
  reg [31:0]rd;
  reg [15:0] multiplicand, multiplier;
  reg [31:0] result;
  integer i;

  always @(*) begin
    multiplicand = rs1;
    multiplier = rs2;
    result = 32'b0;

    for (i = 0; i < 16; i = i + 1) begin
      if (multiplicand[i] == 1'b1)
        result = result + (multiplier << i);  ///The multiplication is performed using a loop that shifts the multiplier to the left by the value of i, and adds the result to result if the corresponding bit in multiplicand is set.
    end

    rd = result + 32'b0;*/
    
    /*while (i<16)                              /////same logic but in while loop.
    {
    if(multiplicand[i] == 1'b1)
      rd = result + (multiplier << i);
      }*/
    
 // end
   
//endmodule


/*Note that this code assumes that the inputs are 16-bit, so it only implements the lower 16 bits of the multiplication operation. To implement a full 32-bit multiplication, the inputs and loop would need to be extended to 32 bits.*/



///given by nitin
/*module full_adder #(parameter N=16)
  (
    input [N-1:0] A,
    input [N-1:0] B,
    output [N-1:0] O
);
  
  
  assign  O = A+B;
  
endmodule

module MUL#(parameter N=16)( 
  input [N-1:0] A,
  input [N-1:0] B,
  output [2*N-1:0] O
);
  
  wire [N][  N-1:0] temp1;// [N];
  wire [N][2*N-1:0] temp2;// [N];
  
  wire [N][2*N-1:0] temp3;// [N];
  
  //always_comb begin
  assign	temp1[0] = B[0] ? A : 0;//& {N{B[0]}};
  assign	temp2[0] = temp1[0] << 0;
  assign	temp3[0] = temp2[0];
  //end
  
  genvar i;
  
  generate
    for(i=1; i<=N-1; i++)begin
      assign temp1[i] = B[i] ? A : 0;
      assign temp2[i] = temp1[i] << i;
      full_adder#(2*N) fa(
        .A(temp3[i-1]),
        .B(temp2[i]),
        .O(temp3[i])
      );
    end
  endgenerate

  assign O = temp3[N-1];
  
endmodule*/


