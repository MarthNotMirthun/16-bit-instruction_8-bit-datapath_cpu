`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 12:57:16 PM
// Design Name: 
// Module Name: cpu_struct
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


module cpu_struct(
    input clk,
    input reset,
    output [7:0] dbg_pc
);
    // =========================
    // Program Counter
    // =========================
    wire [7:0] pc;
    wire [7:0] pc_next;

    program_counter PC (
        .clk(clk),
        .reset(reset),
        .next_pc(pc_next),
        .pc(pc)
    );
    assign dbg_pc=pc;
    // =========================
    // Instruction Fetch
    // =========================
    wire [15:0] instr;

    instruction_memory IM (
        .address(pc),
        .instruction(instr)
    );

    // =========================
    // Control Signals
    // =========================
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire alu_src;
    wire branch;
    wire [2:0] alu_op;

    control_unit CU (
        .instr(instr),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .branch(branch),
        .alu_op(alu_op)
    );

    // =========================
    // Register File
    // =========================
    wire [7:0] reg_a;
    wire [7:0] reg_b;

    register_file RF (
        .clk(clk),
        .reg_write(reg_write),
        .rs(instr[8:6]),
        .rt(instr[5:3]),
        .rd(instr[2:0]),
        .write_data(mem_to_reg ? mem_data : alu_result),
        .read_data1(reg_a),
        .read_data2(reg_b)
    );

    // =========================
    // Immediate Extension (3-bit ? 8-bit)
    // =========================
    wire [7:0] imm_ext;
    assign imm_ext = {{5{instr[5]}}, instr[5:3]};  // sign-extend

    // =========================
    // ALU Operand Mux
    // =========================
    wire [7:0] alu_b;
    assign alu_b = alu_src ? imm_ext : reg_b;

    // =========================
    // ALU
    // =========================
    wire [7:0] alu_result;
    wire zero_flag;
    wire negative_flag;
    wire carry_flag;
    wire overflow_flag;

    alu_struct ALU (
        .a(reg_a),
        .b(alu_b),
        .alu_op(alu_op),
        .result(alu_result),
        .zero(zero_flag),
        .negative(negative_flag),
        .carry(carry_flag),
        .overflow(overflow_flag)
    );

    // =========================
    // Data Memory
    // =========================
    wire [7:0] mem_data;

    data_memory DM (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(alu_result),
        .write_data(reg_b),
        .read_data(mem_data)
    );

    // =========================
    // Next PC Logic
    // =========================
    wire branch_taken;
    assign branch_taken = branch & zero_flag;

    assign pc_next = branch_taken ? instr[2:0] : (pc + 8'd1);

endmodule

