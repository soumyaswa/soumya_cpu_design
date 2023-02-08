module rs1_demux_1x4(out_opcode,rs1_reg_val,add_rs1,sub_rs1,mul_rs1,div_rs1);
  input [1:0]out_opcode;
  input [15:0]rs1_reg_val;
  output reg [15:0]add_rs1,sub_rs1,mul_rs1,div_rs1;
  
  always@(*)begin
    if(out_opcode==00)
    add_rs1 = rs1_reg_val;
    else if(out_opcode==01)
    sub_rs1 = rs1_reg_val;
    else if(out_opcode==10)
    mul_rs1 = rs1_reg_val;
    else if(out_opcode==11)
    div_rs1 = rs1_reg_val;
  end
  
  
endmodule
