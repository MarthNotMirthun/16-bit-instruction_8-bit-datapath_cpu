`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:54:58 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input  [15:0] instr,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg alu_src,        // 0 = reg, 1 = immediate
    output reg branch,

    output reg [2:0] alu_op    // directly from function field
);
    wire [3:0] opcode = instr[15:12];
    wire [2:0] funct  = instr[11:9];

    always @(*) begin
        // defaults (safe)
        reg_write  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        mem_to_reg = 1'b0;
        alu_src    = 1'b0;
        branch     = 1'b0;
        alu_op     = 3'b000;

        case (opcode)

            // ============================
            // R-TYPE INSTRUCTIONS
            // ============================
            4'b0000: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;      // second operand from register
                alu_op    = funct;     // function selects ALU operation
            end

            // ============================
            // LOAD
            // ============================
            4'b0001: begin
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                mem_to_reg = 1'b1;
                alu_src    = 1'b1;     // base + immediate
                alu_op     = 3'b000;   // ADD for address calc
            end

            // ============================
            // STORE
            // ============================
            4'b0010: begin
                mem_write = 1'b1;
                alu_src   = 1'b1;      // base + immediate
                alu_op    = 3'b000;    // ADD for address calc
            end

            // ============================
            // BRANCH
            // ============================
            4'b0011: begin
                branch  = 1'b1;
                alu_src = 1'b0;        // compare registers
                alu_op  = funct;       // condition via ALU (ex: SUB / CMP)
            end

            default: begin
                // NOP / invalid instruction
            end

        endcase
    end
endmodule

