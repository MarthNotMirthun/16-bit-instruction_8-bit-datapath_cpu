`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:44:59 PM
// Design Name: 
// Module Name: program_counter
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


module dff(
    input clk,
    input reset,
    input d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset) q <= 1'b0;
        else       q <= d;
    end
endmodule

module program_counter(
    input clk,
    input reset,
    input [7:0] next_pc,
    output [7:0] pc
);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pc_ff
            dff ff(.clk(clk), .reset(reset), .d(next_pc[i]), .q(pc[i]));
        end
    endgenerate
endmodule
