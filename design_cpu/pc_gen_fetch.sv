// Code your design here
module pc(clk, rst, pc);
input clk, rst;
output reg [7:0] pc;

always@(posedge clk)
    begin
        if(rst)
            begin
                pc <= 0;
            end
        else
            begin
                pc <= pc + 1;
            end             
    end
endmodule
