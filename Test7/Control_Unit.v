module Control_Unit (
    input [15:0] instruction,
    output reg [2:0] op_select,
    output reg sub
);
    // Assuming instruction format: [15:13] - operation code, [12:0] - data
    always @(*) begin
        case (instruction[15:13])
            3'b000: begin // Example: ADD
                op_select = 3'b000;
                sub = 0;
            end
            3'b001: begin // Example: SUB
                op_select = 3'b000;
                sub = 1;
            end
            3'b010: begin // Example: AND
                op_select = 3'b010;
                sub = 0;
            end
            3'b011: begin // Example: OR
                op_select = 3'b011;
                sub = 0;
            end
            3'b100: begin // Example: MUL
                op_select = 3'b100;
                sub = 0;
            end
            3'b101: begin // Example: DIV
                op_select = 3'b101;
                sub = 0;
            end
            default: begin
                op_select = 3'b000;
                sub = 0;
            end
        endcase
    end
endmodule
