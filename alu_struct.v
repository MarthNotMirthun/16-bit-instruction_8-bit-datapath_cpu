`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:38:39 PM
// Design Name: 
// Module Name: alu_struct
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


module alu_struct(
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] alu_op,
    output [7:0] result,
    output zero,
    output negative,
    output carry,
    output overflow
);
    // Decode ALU op (one-hot)
    wire is_add = (alu_op == 3'b000);
    wire is_sub = (alu_op == 3'b001);
    wire is_and = (alu_op == 3'b010);
    wire is_or  = (alu_op == 3'b011);
    wire is_xor = (alu_op == 3'b100);
    wire is_not = (alu_op == 3'b101);

    // Sub uses inverted B + carry-in
    wire [7:0] b_xor;
    genvar i;
    generate
        for (i=0; i<8; i=i+1) begin
            xor_gate xb(.a(b[i]), .b(is_sub), .y(b_xor[i]));
        end
    endgenerate

    // Adder
    wire [7:0] add_res;
    wire add_carry;

    adder8 ADD(
        .a(a),
        .b(b_xor),
        .cin(is_sub),
        .sum(add_res),
        .carry(add_carry)
    );

    // Logic ops
    wire [7:0] and_res, or_res, xor_res, not_res;
    generate
        for (i=0; i<8; i=i+1) begin
            and_gate ga(.a(a[i]), .b(b[i]), .y(and_res[i]));
            or_gate  go(.a(a[i]), .b(b[i]), .y(or_res[i]));
            xor_gate gx(.a(a[i]), .b(b[i]), .y(xor_res[i]));
            not_gate gn(.a(a[i]), .y(not_res[i]));
        end
    endgenerate

    // Final result mux (OR of gated results)
    assign result =
          (is_add | is_sub) ? add_res :
          is_and ? and_res :
          is_or  ? or_res  :
          is_xor ? xor_res :
          is_not ? not_res :
          8'b0;

    assign carry = (is_add | is_sub) ? add_carry : 1'b0;
    assign negative = result[7];
    assign zero  = (result == 8'b0);
    
    // overflow only valid for add/sub
    assign overflow =
        (alu_op == 3'b000) ? (a[7] & b[7] & ~result[7]) | (~a[7] & ~b[7] & result[7]) :
        (alu_op == 3'b001) ? (a[7] & ~b[7] & ~result[7]) | (~a[7] & b[7] & result[7]) :
        1'b0;
    
    
endmodule

