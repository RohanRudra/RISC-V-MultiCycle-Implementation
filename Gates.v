module and_gate(a,b,out);
    input a,b;
    output out;

    assign out = a & b;
endmodule

module or_gate(a,b,out);
    input a,b;
    output out;

    assign out = a | b;
endmodule