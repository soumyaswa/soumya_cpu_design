module rs2_demux_1x4(out_opcode,rs2_reg_val,add_rs2,sub_rs2,mul_rs2,div_rs2);
  input [1:0]out_opcode;
  input [15:0]rs2_reg_val;
  output reg [15:0]add_rs2,sub_rs2,mul_rs2,div_rs2;
  
    always@(*)begin
      if(out_opcode==00)
    add_rs2 = rs2_reg_val;
      else if(out_opcode==01)
    sub_rs2 = rs2_reg_val;
      else if(out_opcode==10)
    mul_rs2 = rs2_reg_val;
      else if(out_opcode==11)
    div_rs2 = rs2_reg_val;
    end
  
  
endmodule
