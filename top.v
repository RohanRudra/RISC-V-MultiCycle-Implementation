`include "ALU_Control.v"
`include "ALUunit.v"
`include "ControlFSM.v"
`include "Gates.v"
`include "ImmGen.v"
`include "Memory.v"
`include "Muxes.v"
`include "ProgramCounter.v"
`include "RegisterFile.v"

module topFile(clk,reset);

    input clk, reset;
    wire [3:0] alucontrol_top;

    wire [31:0] PC_inTop, PC_outTop, MemAddr_top, MemData_top, WrData_top, rdData1_top, rdData2_top, imm_out_top, 
    AMux_out, BMux_out, ALUResult_top;

    wire zero, PCWriteCond_top, PCWrite_top, IorD_top, MemRead_top, MemWrite_top, MemtoReg_top, IRWrite_top,
    RegWrite_top, PCSource_top, AND_out, OR_out;

    wire [1:0] ALUOp_top, ALUSrcB_top, ALUSrcA_top; 
    reg [31:0] InstrReg, DataReg, A, B, ALUOut, OldPC; 
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            InstrReg <= 32'd0;
            DataReg <= 32'd0;
            OldPC <= 32'd0;
        end

        else if(IRWrite_top) begin
            InstrReg <= MemData_top;
        end

        else begin
            DataReg <= MemData_top; 
            OldPC <= PC_outTop;
        end    
    end

    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            A <= 32'd0;
            B <= 32'd0;
            ALUOut <= 32'd0;
        end
        else begin
            A <= rdData1_top;
            B <= rdData2_top;
            ALUOut <= ALUResult_top;
        end
    end

    Program_Counter PC(.clk(clk), .reset(reset), .en(OR_out), .PC_in(PC_inTop), .PC_out(PC_outTop));
    Mux1 PC_Mux(.sel(IorD_top), .i1(PC_outTop), .i2(ALUOut), .out(MemAddr_top));
    memory Memory(.clk(clk), .WrEn(MemWrite_top), .RdEn(MemRead_top), .addr(MemAddr_top), .WrData(B), .MemData(MemData_top));

    Mux2 MemDataMux(.sel(MemtoReg_top), .i1(ALUOut), .i2(DataReg), .out(WrData_top));
    RegistersBlock registerFile(.clk(clk), .wrEn(RegWrite_top), .rdAddr1(InstrReg[19:15]), .rdAddr2(InstrReg[24:20]), 
    .wrAddr(InstrReg[11:7]), .wrData(WrData_top), .rdData1(rdData1_top), .rdData2(rdData2_top));

    ImmGen ImmeGen(.op(InstrReg[6:0]), .instr(InstrReg), .imm_out(imm_out_top));
    Mux3 A_Mux(.sel(ALUSrcA_top), .i1(PC_outTop), .i2(OldPC), .i3(A), .out(AMux_out));
    Mux4 B_Mux(.sel(ALUSrcB_top), .i1(B), .i2(32'd4), .i3(imm_out_top), .out(BMux_out));
    ALUControl ALU_Control(.fun7(InstrReg[30]), .fun3(InstrReg[14:12]), .ALUOp(ALUOp_top), .control_out(alucontrol_top));
    ALUunit ALU(.a(AMux_out), .b(BMux_out), .ALU_Result(ALUResult_top), .aluControl(alucontrol_top), .zero(zero));
    Mux5 ALU_Mux(.sel(PCSource_top), .i1(ALUResult_top), .i2(ALUOut), .out(PC_inTop));

    Control_FSM ControlFSM(.clk(clk), .rst(reset), .op(InstrReg[6:0]), .PCWriteCond(PCWriteCond_top), .PCWrite(PCWrite_top), 
    .IorD(IorD_top), .MemRead(MemRead_top), .MemWrite(MemWrite_top), .MemtoReg(MemtoReg_top), .IRWrite(IRWrite_top), 
    .PCSource(PCSource_top), .ALUOp(ALUOp_top), .ALUSrcB(ALUSrcB_top), .ALUSrcA(ALUSrcA_top), .RegWrite(RegWrite_top));

    and_gate AND(.a(zero),.b(PCWriteCond_top),.out(AND_out));
    or_gate OR(.a(AND_out),.b(PCWrite_top),.out(OR_out));

endmodule
