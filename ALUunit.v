module ALUunit(a, b, ALU_Result, aluControl, zero);
    input [31:0] a,b;
    input [3:0] aluControl;
    output reg [31:0] ALU_Result;
    output reg zero;

    always @(aluControl or a or b) begin
        case (aluControl)
            4'b0000:begin 
                        zero <= 0; 
                        ALU_Result <= a & b;
                    end 
            4'b0001:begin 
                        zero <= 0; 
                        ALU_Result <= a | b;
                    end
            4'b0010:begin 
                        zero <= 0; 
                        ALU_Result <= a + b;
                    end
            4'b0110:begin 
                        ALU_Result <= a - b;
                    end                    
        endcase
    end

    always@(ALU_Result) begin
        if(ALU_Result == 1'b0)
            zero <= 1; 
    end

endmodule