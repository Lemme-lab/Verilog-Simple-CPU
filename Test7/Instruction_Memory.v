module Instruction_Memory (
    input [3:0] address,
    output [15:0] instruction
);
    reg [15:0] memory [0:15]; // Example with 16 instructions

    initial begin
        // Initialize with some example instructions
        memory[0] = 16'b0000000000000000; // Example instruction
        // Add more instructions as needed
    end

    assign instruction = memory[address];
endmodule
