module Instruction_Register (
    input clk,
    input load,                      // Unified load signal
    input is_instruction,            // Selector signal to differentiate between instruction and data
    input [4:0] load_address,        // Address to load instruction (5 bits now)
    input [7:0] cpu_input,           // Unified input for loading both instruction and data
    input [4:0] program_counter,     // Current instruction address (5 bits now)
    output reg [7:0] instruction     // 8-bit instruction (Opcode + Operand Address)
);
    reg [7:0] instructions [31:0];  // 32 instructions, each 8 bits wide (changed to 32 locations)

    always @(posedge clk) begin
        if (load && is_instruction) begin
            // Load instruction into the specified address
            instructions[load_address] <= cpu_input;
        end
    end

    always @(*) begin
        // Fetch the instruction from the instruction memory
        instruction = instructions[program_counter];
    end
endmodule
