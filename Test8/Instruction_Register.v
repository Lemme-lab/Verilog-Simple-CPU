module Instruction_Register (
    input [3:0] program_counter,  // Current instruction address
    output reg [7:0] instruction  // 8-bit instruction
);
    reg [7:0] instructions [15:0]; // 16 instructions

    initial begin
        // Predefined instructions, opcode in upper 4 bits
        instructions[0]  = 8'b00000000; // ADD
        instructions[1]  = 8'b00010000; // SUBTRACT
        instructions[2]  = 8'b00100000; // AND
        instructions[3]  = 8'b00110000; // OR
        instructions[4]  = 8'b01000000; // MULTIPLY
        instructions[5]  = 8'b01010000; // DIVIDE
        // Add more predefined instructions as needed
    end

    always @(*) begin
        instruction = instructions[program_counter];
    end
endmodule
