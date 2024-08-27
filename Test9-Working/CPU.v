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
    wire [15:0] instruction;
    wire [15:0] a, b;
    wire sub;
    wire [2:0] op_select;
    wire [3:0] address_a, address_b;

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

    // Instantiate Address Register
    Address_Register ar (
        .instruction(instruction),
        .address_a(address_a),
        .address_b(address_b)
    );

    // Instantiate Data Register with Addressable Memory
    Data_Register dr (
        .address_a(address_a),
        .address_b(address_b),
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
