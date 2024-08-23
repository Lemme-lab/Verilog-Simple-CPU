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
    input load,             // Signal to load data into the register
    input [2:0] reg_select, // Register select for loading data
    output reg [15:0] result,  // Unified output
    output cout,
    output overflow,
    output NO,
    output ZO,
    output [15:0] accumulator // Add accumulator output port
);
    reg [15:0] register [0:5]; // 6x16-bit registers
    reg [15:0] acc;            // Internal accumulator register

    wire [15:0] sum;
    wire [15:0] and_result_internal;
    wire [15:0] or_result_internal;
    wire [15:0] multiply_result;
    wire [15:0] divide_result;
    wire overflow_arithmetic;
    wire [15:0] mux_result;     // Temporary wire to capture mux output

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
        .out(mux_result)       // Temporary wire for mux output
    );

    // Overflow detection (only for addition and subtraction)
    assign overflow = (op_select == 3'b000 && overflow_arithmetic) || 
                      (op_select == 3'b001 && overflow_arithmetic);

    // Register loading
    always @(posedge load) begin
        if (load) begin
            register[reg_select] <= a;
        end
    end

    // Accumulator logic
    always @(*) begin
        case (op_select)
            3'b000: acc = register[0] + register[1]; // Addition example
            3'b001: acc = register[0] - register[1]; // Subtraction example
            default: acc = 16'h0000; // Default case
        endcase
    end

    // Output result assignment
    always @(*) begin
        if (op_select == 3'b000 || op_select == 3'b001) begin
            // For addition and subtraction, use the accumulator value
            result = acc;
        end else begin
            // For other operations, use the mux result
            result = mux_result;
        end
    end

    // Assign accumulator to output
    assign accumulator = acc;

endmodule
