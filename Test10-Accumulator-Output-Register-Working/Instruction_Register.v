module Instruction_Register (
    input [3:0] program_counter,  // Current instruction address
    output reg [15:0] instruction // 16-bit instruction (Opcode + Operand Address)
);
    reg [15:0] instructions [15:0]; // 16 instructions, each 16 bits wide

    initial begin
instructions[0] = 16'b0000_0001_0000_0000;  // ADD, Load operand from Address 1 (15)
instructions[1] = 16'b0100_0001_0000_0000;  // MULTIPLY, Load operand from Address 1 (15)
instructions[2] = 16'b0101_0000_0110_0000;  // DIVIDE, Load operand from Address 6 (10)
instructions[3] = 16'b0110_0000_0000_0001;  // OUTPUT, Write result to Output Register at Index 1 (Keeps write_enable high)
instructions[4] = 16'b0000_0000_0000_0000;  // ADD (just an example for when write_enable should be toggled low)
instructions[5] = 16'b0110_0000_0000_0010;  // OUTPUT, Write new result to Output Register at Index 2 (Toggles write_enable back to high)
    end

    always @(*) begin
        instruction = instructions[program_counter];
    end
endmodule

