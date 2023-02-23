
module divider_fsm #(parameter N=16) (
  input clk,
  input reset,bin,
  input unsigned [N-1:0] dividend,
  input unsigned [N-1:0] divisor,
  output reg [N-1:0] quotient,
  output reg [N-1:0] remainder,
    output reg done
);
  //wire [15:0] quotient;
  //wire [15:0] remainder;
// Define states for the FSM
typedef enum logic [2:0] {
    INIT,
    COMPARE,
    SUBTRACT,
    OUTPUT
} fsm_state_t;

// Define signals for the FSM
  reg signed [15:0] current_dividend;
  reg signed [15:0] current_quotient;
reg [2:0] state;
 

// Instantiate the comparator module
  comp_16_bit #(N) comparator_inst(
    .inp1(current_dividend),
    .inp2(divisor),
    .comp(comp_lt)
   
);

// Instantiate the subtractor module
  subt #(N) subtractor_inst(
    .inp1(current_dividend),
    .inp2(divisor),
    .bin(bin),
    .out(next_dividend),
    .bo()
);

// Initialize the signals and state
initial begin
    current_dividend = dividend;
    current_quotient = 0;
    state = INIT;
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_dividend <= dividend;
        current_quotient <= 0;
        state <= INIT;
        done <= 0;
    end
    else begin
        case (state)
            INIT: begin
                // Move to the COMPARE state
                state <= COMPARE;
            end
            COMPARE: begin
                // Compare the current_dividend and divisor using the comparator module
                if (comp_lt) begin
                    // Move to the OUTPUT state if the current_dividend is less than the divisor
                    state <= OUTPUT;
                end
                else begin
                    // Move to the SUBTRACT state with a delay
                    state <= SUBTRACT;
                end
            end
            SUBTRACT: begin
                // Subtract the divisor from the current_dividend using the subtractor module
                current_dividend <= next_dividend;
                current_quotient <= current_quotient + 1;
                // Move back to the COMPARE state with a delay
                #1;
                state <= COMPARE;
            end
            OUTPUT: begin
                // Output the quotient and remainder
                quotient <= current_quotient;
                remainder <= current_dividend;
                done <= 1;
                // Move back to the INIT state
                state <= INIT;
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
end

endmodule


//---------------comp logic ---------------------
module comp_16_bit #(parameter N=16) (inp1,inp2,comp);
  input [15:0]inp1,inp2;
  output reg comp;
  wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;
  wire y1,y2,y3,y4,y5,y6,a_less,a_greater,equal;
  wire [1:0]op1;
  comp_4_bit c1(.inp1(inp1[3:0]),.inp2(inp2[3:0]),.a_less(t1),.a_greater(t2),.equal(t3));
  comp_4_bit c2(.inp1(inp1[7:4]),.inp2(inp2[7:4]),.a_less(t4),.a_greater(t5),.equal(t6));
  comp_4_bit c3(.inp1(inp1[11:8]),.inp2(inp2[11:8]),.a_less(t7),.a_greater(t8),.equal(t9));
  comp_4_bit c4(.inp1(inp1[15:12]),.inp2(inp2[15:12]),.a_less(t10),.a_greater(t11),.equal(t12));
  
 
  and b1(y1,t2,t6,t9,t12);
  and b2(y2,t1,t6,t9,t12); 
  and b3(y3,t5,t9,t12);
  and b4(y4,t4,t9,t12);
  and b5(y5,t8,t12); 
  and b6(y6,t7,t12);
  and b7(equal,t3,t6,t9,t12); 
  or b8(a_greater,y1,y3,y5,t11);
  or b9(a_less,y2,y4,y6,t10);
  assign op1={a_less,a_greater};
  always@(op1)begin
    case(op1)
      2'b00: begin
        comp = a_less;
        $display("inp1<inp2");
      end
        
      2'b01 : begin
        comp = a_greater;
        $display("inp1>inp2");
      end
      
    endcase
  end
  
endmodule



module comp_4_bit(inp1,inp2,a_less,a_greater,equal);
  input [3:0]inp1,inp2;
  output reg a_less,a_greater,equal;
  wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;
  wire y1,y2,y3,y4,y5,y6;
  
  comp c1(.inp1(inp1[0]),.inp2(inp2[0]),.a_less(t1),.a_greater(t2),.equal(t3));
  comp c2(.inp1(inp1[1]),.inp2(inp2[1]),.a_less(t4),.a_greater(t5),.equal(t6));
  comp c3(.inp1(inp1[2]),.inp2(inp2[2]),.a_less(t7),.a_greater(t8),.equal(t9));
  comp c4(.inp1(inp1[3]),.inp2(inp2[3]),.a_less(t10),.a_greater(t11),.equal(t12));
  
 
  and b1(y1,t2,t6,t9,t12);
  and b2(y2,t1,t6,t9,t12); 
  and b3(y3,t5,t9,t12); 
  and b4(y4,t4,t9,t12);
  and b5(y5,t8,t12);
  and b6(y6,t7,t12);
  
  and b7(equal,t3,t6,t9,t12); 
  or b8(a_greater,y1,y3,y5,t11);
  or b9(a_less,y2,y4,y6,t10);
  
endmodule

//1-bit comp
module comp(inp1,inp2,a_less,a_greater,equal);

  input inp1,inp2;
  output reg a_less,a_greater,equal;
  wire t1,t2;
  
  not n1(t1,inp2);
  and a1(a_greater,t1,inp1);
  xnor x1(equal,inp1,inp2);
  not n2(t2,inp1);
  and a2(a_less,t2,inp2);
endmodule
 

///----------------------sub logic--------------------
module subt #(parameter N=16) (inp1,inp2,bin,out,bo);
  input [N-1:0]inp1,inp2;
  input bin;
  output reg [N-1:0]out;
  output reg bo;
  wire [N:0]b;
  genvar i;
  generate
    assign b[0]=bin;
    for(i=0; i<=N-1; i++)begin
      fullsubtractor f0(.inp1(inp1[i]),.inp2(inp2[i]),.bin(b[i]),.out(out[i]),.bo(b[i+1]));
      
    end
   // assign bo=b[N];
  endgenerate
  assign bo=b[N];
endmodule
//full subtractor

module fullsubtractor(inp1,inp2,bin,out,bo);
  input inp1,inp2,bin;
  output reg out,bo;
  wire b,b1,out1;
  Half_Subtractor h1(.inp1(inp1),.inp2(inp2),.bo(b),.out(out1));
  Half_Subtractor h2(.inp1(sub1),.inp2(bin),.bo(b1),.out(out));
  or last(bo,b1,b);
endmodule
//half subtarctor
module Half_Subtractor(input inp1, inp2,output reg out, bo);
assign out = inp1 ^ inp2;
assign bo = ~inp1 & inp2;
endmodule
