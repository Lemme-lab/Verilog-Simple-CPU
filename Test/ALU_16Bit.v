
module ALU_16Bit (
    input [15:0] a,
    input [15:0] b,
    input sub,
    input [2:0] op_select,
    output [15:0] result,
    output cout,
    output overflow,
    output NO,
    output ZO
);
    wire [15:0] sum;
    wire [15:0] and_result_internal;
    wire [15:0] or_result_internal;
    wire [15:0] product;
    wire [15:0] quotient;
    
    wire sum_cout, sum_overflow;
    
    Math_Unit_16Bit adder_subtractor (
        .a(a),
        .b(b),
        .sub(sub),
        .sum(sum),
        .cout(sum_cout),
        .overflow(sum_overflow)
    );
    
    and16_16bit and_gate (
        .a(a),
        .b(b),
        .result(and_result_internal)
    );
    
    or_16bit or_gate (
        .a(a),
        .b(b),
        .result(or_result_internal)
    );
    
    multiplier_16bit_gate multiplier (
        .a(a),
        .b(b),
        .product(product)
    );
    
    divider_16bit_gate divider (
        .a(a),
        .b(b),
        .quotient(quotient)
    );
    
    mux6to1_16bit mux (
        .d0(sum),
        .d1(sum),
        .d2(and_result_internal),
        .d3(or_result_internal),
        .d4(product),
        .d5(quotient),
        .s(op_select),
        .y(result)
    );
    
    assign cout = (op_select == 3'b000 || op_select == 3'b001) ? sum_cout : 1'b0;
    assign overflow = (op_select == 3'b000 || op_select == 3'b001) ? sum_overflow : 1'b0;
    assign NO = (result == 16'b0) ? 1'b1 : 1'b0;
    assign ZO = (result == 16'b0) ? 1'b1 : 1'b0;
    
endmodule
