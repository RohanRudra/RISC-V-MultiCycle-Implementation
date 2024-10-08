module Program_Counter(clk, reset, en, PC_in, PC_out);
    input clk, reset, en;
    input [31:0] PC_in;    
    output reg [31:0] PC_out;

    always @(posedge clk or posedge reset) begin
        if(reset)
            PC_out <= 32'd0;
        else if(en)
            PC_out <= PC_in;
    end

endmodule