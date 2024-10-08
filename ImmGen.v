module ImmGen(op, instr, imm_out);
    input [6:0] op;
    input [31:0] instr;
    output reg [31:0] imm_out;

    always@(*) begin
        case(op)
            7'b0000011: imm_out <= {{20{instr[31]}}, instr[31:20]}; //lw
            7'b0010011: imm_out <= {{20{instr[31]}}, instr[31:20]}; //addi / ori
            7'b0100011: imm_out <= {{20{instr[31]}}, instr[31:25], instr[11:7]}; //sw
            7'b1100011: imm_out <= {{19{instr[31]}}, instr[31], instr[30:25], instr[11:8], 1'b0}; //sb type
        endcase
    end
endmodule