module Instruction_Register (
    input [3:0] program_counter,  // Current instruction address
    output reg [15:0] instruction // 16-bit instruction (Opcode + Addresses)
);
    reg [15:0] instructions [15:0]; // 16 instructions, each 16 bits wide

    initial begin
instructions[0] = 16'b0000_0000_0001_0000; // ADD, Address A = 0, Address B = 1
instructions[1] = 16'b0001_0010_0011_0000; // SUBTRACT, Address A = 2, Address B = 3
instructions[2] = 16'b0010_0100_0101_0000; // AND, Address A = 4, Address B = 5
instructions[3] = 16'b0011_0110_0111_0000; // OR, Address A = 6, Address B = 7
instructions[4] = 16'b0100_1000_0001_0000; // MULTIPLY, Address A = 8, Address B = 1
instructions[5] = 16'b0101_1010_0011_0000; // DIVIDE, Address A = 10, Address B = 3

    end

    always @(*) begin
        instruction = instructions[program_counter];
    end
endmodule

