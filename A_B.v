module A(clk, rst, in, out);
    input clk,rst;
    input [31:0] in;
    output reg [31:0] out;

    always@(posedge clk or posedge rst) begin
        if(rst)
            out <= 32'd0;
        else
            out <= in;
    end
endmodule

module B(clk, rst, in, out);
    input clk,rst;
    input [31:0] in;
    output reg [31:0] out;

    always@(posedge clk or posedge rst) begin
        if(rst)
            out <= 32'd0;
        else
            out <= in;
    end
endmodule