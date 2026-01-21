`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 06:29:29 PM
// Design Name: 
// Module Name: cpu_struct_tb
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


`timescale 1ns/1ps

module cpu_struct_tb;

    reg clk;
    reg reset;

    // Instantiate CPU
    cpu_struct DUT (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc)
    );

    // =========================
    // Clock Generation
    // =========================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz clock
    end

    // =========================
    // Test Sequence
    // =========================
    initial begin
        // Dump waveforms
        $dumpfile("cpu_struct.vcd");
        $dumpvars;

        // Reset
        reset = 1;
        #20;
        reset = 0;

        // Run for several cycles
        repeat (10) begin
            @(posedge clk);
            #1;
            display_state();
        end

        $finish;
    end

    // =========================
    // Debug Task
    // =========================
    task display_state;
        begin
            $display("--------------------------------------------------");
            $display("PC        = %d", DUT.pc);
            $display("INSTR     = %b", DUT.instr);
            $display("R0 = %d  R1 = %d  R2 = %d  R3 = %d",
                     DUT.RF.regs[0],
                     DUT.RF.regs[1],
                     DUT.RF.regs[2],
                     DUT.RF.regs[3]);
            $display("R4 = %d  R5 = %d  R6 = %d  R7 = %d",
                     DUT.RF.regs[4],
                     DUT.RF.regs[5],
                     DUT.RF.regs[6],
                     DUT.RF.regs[7]);
        end
    endtask

endmodule
