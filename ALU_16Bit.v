`include "Math_Unit_16Bit.v"
`include "and16_16bit.v"
`include "or_16bit.v"
`include "divider_16bit_gate.v"
`include "multiplier_16bit_gate.v"
`include "mux6to1_16bit.v"

module ALU_16Bit (
    input [15:0] a,
    input [15:0] b,
    input sub,
    input [2:0] op_select,  // 0 - Add, 1 - Subtract, 2 - AND, 3 - OR, 4 - Multiply, 5 - Divide
    output [15:0] result,  // Unified output
    output cout,
    output overflow,
    output NO,
    output ZO
);
    wire [15:0] sum;
    wire [15:0] and_result_internal;
    wire [15:0] or_result_internal;
    wire [15:0] multiply_result;
    wire [15:0] divide_result;
    wire overflow_arithmetic;

    // Instantiate Math_Unit_16Bit for addition and subtraction
    Math_Unit_16Bit math_unit (
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum),
        .cout(cout),
        .overflow(overflow_arithmetic),
        .NO(NO),
        .ZO(ZO)
    );

    // 16-bit AND operation
    and16_16bit andGate (
        .a(a),
        .b(b),
        .y(and_result_internal)
    );

    // 16-bit OR operation
    or_16bit orGate (
        .a(a),
        .b(b),
        .y(or_result_internal)
    );

    // Instantiate Multiplier and Divider
    multiplier_16bit mul (
        .a(a),
        .b(b),
        .product(multiply_result)
    );

    divider_16bit div (
        .dividend(a),
        .divisor(b),
        .quotient(divide_result),
        .remainder() // Assume remainder is not needed for the final result
    );

    // 6-to-1 MUX to select between different operation results
    mux6to1_16bit mux (
        .in0(sum),              // Addition result
        .in1(sum),              // Subtraction result (same as addition when sub=1)
        .in2(and_result_internal), // AND result
        .in3(or_result_internal),  // OR result
        .in4(multiply_result), // Multiplication result
        .in5(divide_result),   // Division result
        .sel(op_select),       // Operation select
        .out(result)           // Unified result output
    );

    // Overflow detection (only for addition and subtraction)
    assign overflow = (op_select == 3'b000 && overflow_arithmetic) || 
                      (op_select == 3'b001 && overflow_arithmetic);

endmodule
