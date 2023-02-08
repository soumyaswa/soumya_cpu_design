module rs1_mux_16x1(rs1_sel,rs1,rs1_out);
  input [3:0]rs1_sel;
  input [15:0]rs1;
  output rs1_out;
  
  assign rs1_out=rs1[rs1_sel];
  
  
endmodule
