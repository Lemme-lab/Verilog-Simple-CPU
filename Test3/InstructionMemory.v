module InstructionMemory (
    input [15:0] address,
    output [15:0] instruction
);
    reg [15:0] memory [255:0]; // 256 instructions, each 16-bit

    initial begin
        // Load instructions into memory (could be initialized here or from a file)
        // Example: memory[0] = 16'b0000000000000000;
    end

    assign instruction = memory[address];
endmodule
