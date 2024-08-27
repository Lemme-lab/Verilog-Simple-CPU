module ControlUnit (
    input [2:0] opcode,
    output alu_op,
    output read_data,
    output write_data,
    output jump,
    output load_ir
);

reg alu_op;
reg read_data;
reg write_data;
reg jump;
reg load_ir;

always @(*) begin
    case (opcode)
        3'b000: // ADD
            alu_op = 1; // Assuming 1 for addition
            read_data = 1;
            write_data = 1;
            jump = 0;
            load_ir = 0;
        // ... (other opcodes and corresponding control signals)
        default:
            alu_op = 0;
            read_data = 0;
            write_data = 0;
            jump = 0;
            load_ir = 0;
    endcase
end

endmodule