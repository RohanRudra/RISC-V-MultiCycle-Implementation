module InstructionReg(clk, rst, IRWrite, instr_in, instr_out);
    input clk, rst, IRWrite;
    input [31:0] instr_in;
    output reg [31:0] instr_out;

    always @(posedge clk or posedge rst) begin
        if(rst)
            instr_out <= 32'd0;
        else
            instr_out <= instr_in;
    end
    
endmodule