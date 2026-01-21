`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:53:30 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,
    input mem_write,
    input mem_read,
    input [7:0] address,    // 256 bytes
    input [7:0] write_data,
    output [7:0] read_data
);
    reg [7:0] ram [0:255];

    always @(posedge clk) begin
        if (mem_write)
            ram[address] <= write_data;
    end

    assign read_data = mem_read ? ram[address] : 8'b0;
endmodule
