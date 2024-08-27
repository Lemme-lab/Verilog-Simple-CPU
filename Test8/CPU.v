module CPU (
    input clk,
    input reset,
    output [15:0] result,
    output cout,
    output overflow,
    output NO,
    output ZO
);
    wire [3:0] program_counter;
    wire [7:0] instruction;
    wire [15:0] a, b;
    wire sub;
    wire [2:0] op_select;

    // Instantiate Program Counter
    Program_Counter pc (
        .clk(clk),
        .reset(reset),
        .program_counter(program_counter)
    );

    // Instantiate Instruction Register
    Instruction_Register ir (
        .program_counter(program_counter),
        .instruction(instruction)
    );

    // Instantiate Data Register
    Data_Register dr (
        .program_counter(program_counter),
        .a(a),
        .b(b)
    );

    // Instantiate Control Unit
    Control_Unit cu (
        .instruction(instruction),
        .sub(sub),
        .op_select(op_select)
    );

    // Instantiate ALU
    ALU_16Bit alu (
        .a(a),
        .b(b),
        .sub(sub),
        .op_select(op_select),
        .result(result),
        .cout(cout),
        .overflow(overflow),
        .NO(NO),
        .ZO(ZO)
    );
endmodule
