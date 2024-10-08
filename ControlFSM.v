module Control_FSM(clk, rst, op, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, 
MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite);

    input rst,clk;
    input [6:0] op;
    output reg PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, RegWrite;
    output reg [1:0] ALUOp, ALUSrcA, ALUSrcB;

    parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011,
              s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111,
              s8 = 4'b1000, s9 = 4'b1001, s10 = 4'b1010; //s10 for error 
    reg [3:0] state, nextState;


    //State transition
    always@(posedge clk or posedge rst) begin
        if(rst)
            state <= s0;
        else
            state <= nextState; 
    end


    //Assigning next state
    always @(*) begin
        case (state)
            s0: nextState = s1;
            s1: case (op)
                    7'b0110011: nextState = s6; //R
                    7'b0000011: nextState = s2; //lw
                    7'b0100011: nextState = s2; //sw
                    7'b1100011: nextState = s8; //beq
                    7'b0010011: nextState = s9; //addi / ori
                endcase
            
            s2: case (op)
                    7'b0000011: nextState = s3; //lw
                    7'b0100011: nextState = s5; //sw   
                endcase

            s3: nextState = s4;
            s4: nextState = s0;
            s5: nextState = s0;
            s6: nextState = s7; //after add store in reg
            s7: nextState = s0;
            s8: nextState = s0;
            s9: nextState = s7; //after addi store in reg
            s10: nextState = s10;
        endcase
    end

    
    //State controls
    always @(*) begin
        case (state)
            s0: begin
                    PCWriteCond = 0;
                    PCWrite = 1;  
                    IorD = 0;
                    MemRead = 1;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 1;
                    PCSource = 0;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'b01;
                    ALUSrcA = 2'b00;
                    RegWrite = 0;
                end

            s1: begin
                    PCWriteCond = 0;
                    PCWrite = 0; 
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'b10;
                    ALUSrcA = 2'b01; //to calculate the immediate for beq from oldPC
                    RegWrite = 0;
                end

            s2: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'b10;
                    ALUSrcA = 2'b10;
                    RegWrite = 0;
                end

            s3: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 1; //give the address(ALU_Out) to fetch data from
                    MemRead = 1;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'bxx; //here it should be xx
                    ALUSrcA = 0;
                    RegWrite = 0;
                end

            s4: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 1;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'bxx; //here it should be xx
                    ALUSrcA = 0;
                    RegWrite = 1;
                    //New RegDst
                end

            s5: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 1;
                    MemRead = 0;
                    MemWrite = 1;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'bxx; //here it should be xx
                    ALUSrcA = 0;
                    RegWrite = 0;
                end

            s6: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b10;
                    ALUSrcB = 2'b00; 
                    ALUSrcA = 2'b10;
                    RegWrite = 0;
                end

            s7: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b00;
                    ALUSrcB = 2'bxx; //here it should be xx
                    ALUSrcA = 0;
                    RegWrite = 1;
                    //New RegDst
                end

            s8: begin
                    PCWriteCond = 1; //if zero register is set
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 1;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 1;
                    PCSource = 1;
                    ALUOp = 2'b01;
                    ALUSrcB = 2'b00;
                    ALUSrcA = 2'b10;
                    RegWrite = 0;
                end

            s9: begin
                    PCWriteCond = 0;
                    PCWrite = 0;
                    IorD = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    MemtoReg = 0;
                    IRWrite = 0;
                    PCSource = 1'bx;
                    ALUOp = 2'b10;
                    ALUSrcB = 2'b10;
                    ALUSrcA = 1;
                    RegWrite = 0;
                end

        endcase
    end

endmodule