`include "AC_16Bit.v"
`include "ALU_16Bit.v"
`include "AR_16Bit.v"
`include "DR_8Bit.v"
`include "IR_4Bit.v"
`include "PC_6Bit.v"
`include "TriStateBuffer.v"

module Calculation_and_Register (
    input clk,                  // Clock signal
    input arload,               // Address Register load signal
    input pcload,               // Program Counter load signal
    input pcinc,                // Program Counter increment signal
    input pcbus,                // Control signal for the tri-state buffer of Program Counter
    input drload,               // Data Register load signal
    input drbus,                // Control signal for the tri-state buffer of Data Register
    input [15:0] D,             // 16-bit Data input for the tri-state buffer
    input membus,               // Control signal for the tri-state buffer
    input [2:0] alusel,         // ALU operation selection input
    input ac_load,              // Accumulator load signal
    input ac_inc,               // Accumulator increment signal
    input irload,               // Instruction Register load signal
    output [15:0] A,            // Output connected to the Address Register output
    output [15:0] ACC,          // Output connected to the Accumulator output
    output [3:0] Instr,        // Output connected to the Instruction Register output
    output [7:0] DR_out        // Debug output for Data Register
);

    // Internal wires
    wire [15:0] databus;     
    wire [15:0] alu_result;     // Output from the ALU
    wire [15:0] address_out;    // Output from the Address Register
    wire [5:0] pc_out;          // Output from the Program Counter (6 bits)
    wire [7:0] dr_out;          // Output from the Data Register (8 bits)
    wire [15:0] pc_data;        // Data from the Program Counter (extended to 16 bits)
    wire [15:0] dr_data;        // Data from the Data Register (extended to 16 bits)
    wire [15:0] mem_data;       // Data from the external input D

    // Instantiate the Address Register (AR_16Bit)
    AR_16Bit address_register (
        .clk(clk),
        .load(arload),
        .bus(databus),
        .or_out(address_out) // Address Register output
    );

    // Instantiate the Program Counter (PC_6Bit)
    PC_6Bit program_counter (
        .clk(clk),
        .pcload(pcload),        // Load control signal for Program Counter
        .pcinc(pcinc),          // Increment control signal for Program Counter
        .bus({10'b0, databus[5:0]}),  // Use only the 6 least significant bits
        .pc_out(pc_out)         // Output from the Program Counter
    );



    // Instantiate the Data Register (DR_8Bit)
    DR_8Bit data_register (
        .clk(clk),
        .drload(drload),        // Load control signal for Data Register
        .bus(databus),          // 16-bit internal data bus
        .dr_out(dr_out)         // Data Register output
    );



    // Use a multiplexer to select which data source drives the databus
    assign databus = (pcbus) ? {10'b0, pc_out} :
                     (drbus) ? {8'b0, dr_out} :
                     (membus) ? D :
                     16'b0; // Default to 0 when no buffer is active

    // Instantiate the ALU (ALU_16Bit)
    ALU_16Bit alu (
        .a(databus),          // Input A of the ALU
        .b(ACC),              // Input B of the ALU (from the Accumulator)
        .sub(alusel[0]),      // Subtract control
        .op_select(alusel),   // ALU operation select (3-bit)
        .result(alu_result),  // ALU result output
        .cout(),              // Carry-out (not used in this module)
        .overflow(),          // Overflow (not used in this module)
        .NO(),                // Negative overflow (not used in this module)
        .ZO()                 // Zero overflow (not used in this module)
    );

    // Instantiate the Accumulator (AC_16Bit)
    AC_16Bit accumulator (
        .clk(clk),
        .load(ac_load),       // Load control signal for Accumulator
        .inc(ac_inc),         // Increment control signal for Accumulator
        .alu_result(alu_result), // ALU result input
        .ac_out(ACC)          // Output from the Accumulator
    );

    // Instantiate the Instruction Register (IR_4Bit)
    IR_4Bit instruction_register (
        .clk(clk),
        .load(irload),        // Load control signal for Instruction Register
        .bus(databus),        // Internal data bus input
        .ir_out(Instr)        // Output of the Instruction Register
    );

    // Output A is connected to the Address Register output
    assign A = address_out;

    // Expose the Data Register output for debugging
    assign DR_out = dr_out;

endmodule