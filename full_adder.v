`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:31:38 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(input a, input b, input cin, output sum, output cout);
    wire axb, aandb, axb_and_cin;

    xor_gate xor1(.a(a), .b(b), .y(axb));
    xor_gate xor2(.a(axb), .b(cin), .y(sum));

    and_gate and1(.a(a), .b(b), .y(aandb));
    and_gate and2(.a(axb), .b(cin), .y(axb_and_cin));
    or_gate  or1(.a(aandb), .b(axb_and_cin), .y(cout));
endmodule
