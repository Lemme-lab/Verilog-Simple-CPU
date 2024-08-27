module InstructionDecoder (
    input [15:0] instruction,
    output sub,
    output [2:0] op_select
);

    // Decode the instruction based on the opcode
    assign sub = instruction[15];
    assign op_select = instruction[14:12];

endmodule

module ControlUnit (
    input clk,
    input reset_n,
    input [15:0] instruction,
    output reg [15:0] instruction_register,
    output reg [15:0] data_register,
    output reg load_data,
    output reg load_instruction,
    output reg execute
);

    // Register update logic
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            instruction_register <= 16'b0;
            data_register <= 16'b0;
            load_data <= 0;
            load_instruction <= 0;
            execute <= 0;
        end else begin
            if (load_instruction) instruction_register <= instruction;
            if (load_data) data_register <= instruction;
            execute <= 1;
        end
    end

endmodule

module TopLevel (
    input clk,
    input reset_n,
    input [15:0] instruction_in,
    input [15:0] data_in,
    output [15:0] result_out,
    output cout,
    output overflow,
    output NO,
    output ZO
);

    // Instantiate modules
    InstructionDecoder decoder (.instruction(instruction_in), .sub(sub), .op_select(op_select));
    ControlUnit control_unit (.clk(clk), .reset_n(reset_n), .instruction(instruction_in), .instruction_register(instruction_register), .data_register(data_register), .load_data(load_data), .load_instruction(load_instruction), .execute(execute));
    ALU_16Bit alu (.a(instruction_register), .b(data_register), .sub(sub), .op_select(op_select), .result(result_out), .cout(cout), .overflow(overflow), .NO(NO), .ZO(ZO));

    // Connect the control signals to the ALU
    assign alu.a = instruction_register;
    assign alu.b = data_register;
    assign alu.sub = sub;
    assign alu.op_select = op_select;

endmodule