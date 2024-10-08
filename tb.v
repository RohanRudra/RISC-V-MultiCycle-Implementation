`include "top.v"

module tb();
    reg clk, reset;

    topFile top(.clk(clk), .reset(reset));

    initial begin
        clk = 0;
        reset = 1;

        #7 reset = 0;
        #2000;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule