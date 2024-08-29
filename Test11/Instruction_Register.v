module Instruction_Register (
    input clk,
    input load_instr,                   // Signal to load instruction
    input [4:0] load_instr_address,     // Address to load instruction (5 bits now)
    input [15:0] instruction_input,     // Input for loading instruction
    input [4:0] program_counter,        // Current instruction address (5 bits now)
    output reg [15:0] instruction       // 16-bit instruction (Opcode + Operand Address)
);
    reg [15:0] instructions [31:0]; // 32 instructions, each 16 bits wide (changed to 32 locations)

initial begin
    // Instructions for different operations to be tested twice and their output stored
    instructions[0]  = 16'b0000_0000_0000_0000;  // ADD, Load operand from Address 0 (10)
    instructions[1]  = 16'b0110_0000_0000_0000;  // OUTPUT, Write result to Output Register at Index 0
    instructions[2]  = 16'b0000_0001_0000_0001;  // ADD, Load operand from Address 1 (15)
    instructions[3]  = 16'b0110_0001_0000_0001;  // OUTPUT, Write result to Output Register at Index 1
    instructions[4]  = 16'b0001_0010_0000_0010;  // SUBTRACT, Load operand from Address 2 (16)
    instructions[5]  = 16'b0110_0010_0000_0010;  // OUTPUT, Write result to Output Register at Index 2
    instructions[6]  = 16'b0001_0011_0000_0011;  // SUBTRACT, Load operand from Address 3 (8)
    instructions[7]  = 16'b0110_0011_0000_0011;  // OUTPUT, Write result to Output Register at Index 3
    instructions[8]  = 16'b0100_0100_0000_0100;  // MULTIPLY, Load operand from Address 4 (255)
    instructions[9]  = 16'b0110_0100_0000_0100;  // OUTPUT, Write result to Output Register at Index 4
    instructions[10] = 16'b0100_0101_0000_0101;  // MULTIPLY, Load operand from Address 5 (15)
    instructions[11] = 16'b0110_0101_0000_0101;  // OUTPUT, Write result to Output Register at Index 5
    instructions[12] = 16'b0101_0110_0000_0110;  // DIVIDE, Load operand from Address 6 (10)
    instructions[13] = 16'b0110_0110_0000_0110;  // OUTPUT, Write result to Output Register at Index 6
    instructions[14] = 16'b0101_0111_0000_0111;  // DIVIDE, Load operand from Address 1 (15)
    instructions[15] = 16'b0110_0111_0000_0111;  // OUTPUT, Write result to Output Register at Index 7

    // Read and output the stored values at the end
    instructions[16] = 16'b0111_0000_0000_0000;  // OUTPUT_READ, Output value at Index 0
    instructions[17] = 16'b0111_0001_0000_0001;  // OUTPUT_READ, Output value at Index 1      
    instructions[18] = 16'b0111_0010_0000_0010;  // OUTPUT_READ, Output value at Index 2
    instructions[19] = 16'b0111_0011_0000_0011;  // OUTPUT_READ, Output value at Index 3
    instructions[20] = 16'b0111_0100_0000_0100;  // OUTPUT_READ, Output value at Index 4
    instructions[21] = 16'b0111_0101_0000_0101;  // OUTPUT_READ, Output value at Index 5
    instructions[22] = 16'b0111_0110_0000_0110;  // OUTPUT_READ, Output value at Index 6
    instructions[23] = 16'b0111_0111_0000_0111;  // OUTPUT_READ, Output value at Index 7
end




    always @(posedge clk) begin
        if (load_instr) begin
            // Load instruction into the specified address
            instructions[load_instr_address] <= instruction_input;
        end
    end

    always @(*) begin
        // Fetch the instruction from the instruction memory
        instruction = instructions[program_counter];
    end
endmodule
