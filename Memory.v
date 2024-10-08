module memory(clk, WrEn, RdEn, addr, WrData, MemData);
    input clk, WrEn, RdEn;
    input [31:0] addr, WrData;
    output [31:0] MemData;

    reg [31:0] ram [63:0];

    initial begin
        //$readmemh("",ram); //Give the file with memory
            //R-Type
            //ram[0] <= 32'b0000000_00000_00000_000_00000_0000000; //No operation
            ram[0] <= 32'b0000000_11001_10000_000_01101_0110011; //add x13, x16, x25
            ram[4] <= 32'b0100000_00011_01000_000_00101_0110011; //sub x5, x8, x3
            ram[8] <= 32'b0000000_00011_00010_111_00001_0110011; //and x1, x2, x3
            ram[12] <= 32'b0000000_00101_00011_110_00100_0110011; //or x4, x3, x5

            //I-Type
            ram[16] <= 32'b000000000011_10101_000_10110_0010011; //addi x22, x21, 3
            ram[20] <= 32'b000000000001_01000_110_01001_0010011; //ori ,x9, x8, 1

            //L-Type //here funct3 is don't care (so putting XXX)
            ram[24] <= 32'b000000000101_00101_XXX_01000_0000011; //lw x8, 5(x5)   
            ram[28] <= 32'b000000000100_00011_XXX_01001_0000011; //lw x9, 4(x3)

            ram[10] <= 32'd69;
            ram[11] <= 32'd9;

            //S-Type
            ram[32] <= 32'b0000000_10000_11010_010_01100_0100011; //sw x16, 12(x26)
            ram[36] <= 32'b0000000_01110_00110_010_01010_0100011; //sw x14, 10(x6)

            //SB-Type
            ram[40] <= 32'h00948663; //beq x9, x9, 12 
            //branching - if both the reg content is equal then it will go to further address (Here 12 => I_memory[40 + 12])

            ram[52] <= 32'b0000000_11001_10000_000_01101_0110011; //add x13, x16, x25
    end
    
    always@(posedge clk) begin
        if(WrEn)
            ram[addr] <= WrData; 
    end

    assign MemData = (RdEn == 1'b1)? ram[addr] : 32'd0;

endmodule