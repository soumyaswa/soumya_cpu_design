module rs2_mux_16x1(rs2_sel,rs2,rs2_out);
  input [3:0]rs2_sel;
  input [15:0]rs2;
  output rs2_out;
  
  assign rs2_out=rs2[rs2_sel];
  
  
endmodule
