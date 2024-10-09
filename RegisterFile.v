module RegistersBlock(clk, wrEn, rdAddr1, rdAddr2, wrAddr, wrData, rdData1, rdData2);
    input clk,wrEn;
    input [31:0] wrData;
    input [4:0] rdAddr1, rdAddr2, wrAddr;
    output [31:0] rdData1, rdData2;

    reg [31:0] reg_array [0:31]; // Explicitly defined memory range from [0:31]

    initial begin
        $readmemh("C:/Users/Rohan/Desktop/verilog codes/RISC MultiCycle/reg_init.mem", reg_array, 0, 31); // Specify range 0 to 31
        // reg_array[0] = 0;
        // reg_array[1] = 4;
        // reg_array[2] = 2;
        // reg_array[3] = 7;
        // reg_array[4] = 53;
        // reg_array[5] = 5;
        // reg_array[6] = 3;
        // reg_array[7] = 6;
        // reg_array[8] = 12;
        // reg_array[9] = 83;
        // reg_array[10] = 82;
        // reg_array[11] = 72;
        // reg_array[12] = 19;
        // reg_array[13] = 47;
        // reg_array[14] = 48;
        // reg_array[15] = 95;
        // reg_array[16] = 255;
        // reg_array[17] = 83;
        // reg_array[18] = 75;
        // reg_array[19] = 96;
        // reg_array[20] = 67;
        // reg_array[21] = 14;
        // reg_array[22] = 46;
        // reg_array[23] = 17;
        // reg_array[24] = 64;
        // reg_array[25] = 32;
        // reg_array[26] = 7;
        // reg_array[27] = 43;
        // reg_array[28] = 56;
        // reg_array[29] = 30;
        // reg_array[30] = 21;
        // reg_array[31] = 10;
    end

    always @(posedge clk) begin
        if(wrEn && (wrAddr != 0))
            reg_array[wrAddr] <= wrData;
    end

    assign rdData1 = (rdAddr1 == 0) ? 0 : reg_array[rdAddr1];
    assign rdData2 = (rdAddr2 == 0) ? 0 : reg_array[rdAddr2];
    
endmodule