`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:51:48 PM
// Design Name: 
// Module Name: register_file
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


module reg8(
    input clk,
    input we,
    input [7:0] d,
    output [7:0] q
);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            dff ff(
                .clk(clk & we),
                .reset(1'b0),
                .d(we ? d[i] : q[i]),
                .q(q[i])
            );
        end
    endgenerate
endmodule


module register_file(
    input clk,
    input reg_write,
    input [2:0] rs,
    input [2:0] rt,
    input [2:0] rd,
    input [7:0] write_data,
    output [7:0] read_data1,
    output [7:0] read_data2
);
    wire [7:0] regs [0:7];
    wire [7:0] we;

    assign we = reg_write ? (8'b00000001 << rd) : 8'b0;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            reg8 r(.clk(clk), .we(we[i]), .d(write_data), .q(regs[i]));
        end
    endgenerate

    assign read_data1 = regs[rs];
    assign read_data2 = regs[rt];
endmodule
