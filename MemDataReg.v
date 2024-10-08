module MemDataReg(clk, rst, data_in, data_out);
    input clk, rst;
    input [31:0] data_in;
    output reg [31:0] data_out;

    always @(posedge clk or posedge rst) begin
        if(rst)
            data_out <= 32'd0;
        else
            data_out <= data_in;
    end
endmodule