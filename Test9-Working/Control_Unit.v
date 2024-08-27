module Control_Unit (
    input [15:0] instruction,  // 16-bit instruction
    output reg sub,            // Subtraction signal for ALU
    output reg [2:0] op_select // Operation select for ALU
);
    always @(*) begin
        case (instruction[15:12])  // Use the upper 4 bits for opcode
            4'b0000: begin
                op_select = 3'b000; // ADD
                sub = 0;
            end
            4'b0001: begin
                op_select = 3'b001; // SUBTRACT
                sub = 1;
            end
            4'b0010: begin
                op_select = 3'b010; // AND
                sub = 0;
            end
            4'b0011: begin
                op_select = 3'b011; // OR
                sub = 0;
            end
            4'b0100: begin
                op_select = 3'b100; // MULTIPLY
                sub = 0;
            end
            4'b0101: begin
                op_select = 3'b101; // DIVIDE
                sub = 0;
            end
            default: begin
                op_select = 3'b000; // Default to ADD
                sub = 0;
            end
        endcase
    end
endmodule


