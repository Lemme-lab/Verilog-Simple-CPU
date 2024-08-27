module ControlUnit (
    input [2:0] op_select,
    output reg alu_sub,
    output reg mem_write
);
    always @(*) begin
        // Control signals based on op_select
        case (op_select)
            3'b000: begin // ADD
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
            3'b001: begin // SUB
                alu_sub = 1'b1;
                mem_write = 1'b0;
            end
            3'b010: begin // AND
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
            3'b011: begin // OR
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
            3'b100: begin // MUL
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
            3'b101: begin // DIV
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
            default: begin
                alu_sub = 1'b0;
                mem_write = 1'b0;
            end
        endcase
    end
endmodule

