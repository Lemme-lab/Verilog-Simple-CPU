module InstructionMemory (
    input [15:0] address,
    output reg [15:0] instruction
);
    reg [15:0] memory [255:0]; // 256 instructions, each 16-bit

    initial begin
        // Example instructions to add numbers
        memory[0] = 16'b0100000100000000; // LOAD R1, [0]   ; Load data from address 0 to R1
        memory[1] = 16'b0100001000000001; // LOAD R2, [1]   ; Load data from address 1 to R2
        memory[2] = 16'b0000001100100010; // ADD R3, R1, R2 ; Add R1 and R2, store result in R3
        memory[3] = 16'b0110001100000110; // STORE R3, [6]  ; Store R3 result to address 6

        memory[4] = 16'b0100010000000010; // LOAD R4, [2]   ; Load data from address 2 to R4
        memory[5] = 16'b0100010100000011; // LOAD R5, [3]   ; Load data from address 3 to R5
        memory[6] = 16'b0000011001000101; // ADD R6, R4, R5 ; Add R4 and R5, store result in R6
        memory[7] = 16'b0110011000000111; // STORE R6, [7]  ; Store R6 result to address 7

        memory[8] = 16'b0100011100000100; // LOAD R7, [4]   ; Load data from address 4 to R7
        memory[9] = 16'b0100100000000101; // LOAD R8, [5]   ; Load data from address 5 to R8
        memory[10] = 16'b0000100101111000; // ADD R9, R7, R8 ; Add R7 and R8, store result in R9
        memory[11] = 16'b0110100100001000; // STORE R9, [8]  ; Store R9 result to address 8

        // Add more instructions as needed
    end

    always @(address) begin
        instruction = memory[address];
    end
endmodule

