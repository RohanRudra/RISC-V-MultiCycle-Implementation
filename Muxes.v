module Mux1(sel, i1, i2, out);
    input [31:0] i1,i2;
    input sel;
    output [31:0] out;

    assign out = (sel == 1'b0) ? i1 : (sel == 1'b1) ? i2 : 32'd0; 
endmodule

module Mux2(sel, i1, i2, out);
    input [31:0] i1,i2;
    input sel;
    output [31:0] out;

    assign out = (sel == 1'b0) ? i1 : (sel == 1'b1) ? i2 : 32'd0; 
endmodule

module Mux3(sel, i1, i2, i3, out);
    input [31:0] i1,i2,i3;
    input [1:0] sel;
    output [31:0] out;

    assign out = (sel == 2'b00) ? i1 : 
                    (sel == 2'b01) ? i2 : 
                        (sel == 2'b10) ? i3 : 32'd0;
endmodule

module Mux4(sel, i1, i2, i3, out);
    input [31:0] i1,i2,i3;
    input [1:0] sel;
    output [31:0] out;

    assign out = (sel == 2'b00) ? i1 : 
                    (sel == 2'b01) ? i2 : 
                        (sel == 2'b10) ? i3 : 32'd0;
endmodule

module Mux5(sel, i1, i2, out);
    input [31:0] i1,i2;
    input sel;
    output [31:0] out;

    assign out = (sel == 1'b0) ? i1 : (sel == 1'b1) ? i2 : 32'd0; 
endmodule