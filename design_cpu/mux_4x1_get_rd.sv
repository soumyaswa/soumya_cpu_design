module mux_4x1_get_rd(add_rd,sub_rd,mul_rd,div_rd,out_opcode,rd_val);
  input[15:0] add_rd,sub_rd,mul_rd,div_rd;
  input [1:0]out_opcode;
  output reg [15:0]rd_val;
  
  always@(*)begin
    if(out_opcode==00)
      rd_val=add_rd;
    else if(out_opcode==01)
      rd_val=sub_rd;
    else if(out_opcode==10)
      rd_val=mul_rd;
    else if(out_opcode==11)
      rd_val=div_rd;
  end
endmodule
