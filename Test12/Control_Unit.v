module Control_Unit (
    input clk,
    input [15:0] instruction,  // 16-bit instruction
    output reg sub,            // Subtraction signal for ALU
    output reg [2:0] op_select, // Operation select for ALU
    output reg write_enable,   // Write enable for Output Register
    output reg read_enable,    // Read enable for Output Register
    output reg [4:0] output_index // Index for Output Register
);
    always @(*) begin
        // Default values
        op_select = 3'b000;
        sub = 0;
        write_enable = 0;  // Default to 0 to prevent unwanted writes
        read_enable = 0;   // Default to 0 to prevent unintended reads
        output_index = 5'b00000;

        case (instruction[15:12])  // Use the upper 4 bits for opcode
            4'b0000: begin
                op_select = 3'b000; // ADD
                sub = 0;
            end
            4'b0001: begin
                op_select = 3'b001; // SUBTRACT
                sub = 1;
            end
            4'b0100: begin
                op_select = 3'b100; // MULTIPLY
                sub = 0;
            end
            4'b0101: begin
                op_select = 3'b101; // DIVIDE
                sub = 0;
            end
            4'b0110: begin
                // OUTPUT instruction: writing result to Output Register
                write_enable = 1; // Enable write to Output Register
                output_index = instruction[4:0]; // Use bits [4:0] as the index in the Output Register
            end
            4'b0111: begin
                // OUTPUT_READ instruction: outputting the stored value from Output Register
                read_enable = 1;  // Enable reading from Output Register
                output_index = instruction[4:0]; // Use bits [4:0] as the index to read from Output Register
            end
            default: begin
                // Defaults (do nothing)
                op_select = 3'b000;
                sub = 0;
                write_enable = 0;  // Ensure no unintended writes
                read_enable = 0;   // Ensure no unintended reads
            end
        endcase
    end
endmodule
