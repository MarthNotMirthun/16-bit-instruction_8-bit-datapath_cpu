`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:36:57 PM
// Design Name: 
// Module Name: mux8_1
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


module mux8_1(input [7:0] a, input [7:0] b, input sel, output [7:0] y);
    genvar i;
    generate
        for(i=0;i<8;i=i+1) begin : mux_loop
            mux2 m(.a(a[i]), .b(b[i]), .sel(sel), .y(y[i]));
        end
    endgenerate
endmodule
