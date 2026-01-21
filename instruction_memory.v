`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:49:39 PM
// Design Name: 
// Module Name: instruction_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory(
    input  [7:0] address,     // 256 instructions
    output [15:0] instruction
);
    reg [15:0] rom [0:255];

    initial begin
        rom[0] = 16'b0000_001_010_011_000; // ADD R3 = R1 + R2
        rom[1] = 16'b0001_001_010_011_000; // SUB
        rom[2] = 16'b0010_001_000_000_101; // LOAD
        rom[3] = 16'b0011_001_010_000_000; // STORE
    end

    assign instruction = rom[address];
endmodule
