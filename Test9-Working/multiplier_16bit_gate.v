module multiplier_16bit (
    input [15:0] a,       // 16-bit multiplicand
    input [15:0] b,       // 16-bit multiplier
    output [15:0] product // 16-bit product
);

    // Internal wires to hold partial products
    wire [15:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;
    wire [15:0] pp8, pp9, pp10, pp11, pp12, pp13, pp14, pp15;

    // Internal wires to hold sums and carries
    wire [15:0] sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7;
    wire carry0, carry1, carry2, carry3, carry4, carry5, carry6;

    // Generate partial products
    assign pp0  = (a & {16{b[0]}});
    assign pp1  = (a & {16{b[1]}}) << 1;
    assign pp2  = (a & {16{b[2]}}) << 2;
    assign pp3  = (a & {16{b[3]}}) << 3;
    assign pp4  = (a & {16{b[4]}}) << 4;
    assign pp5  = (a & {16{b[5]}}) << 5;
    assign pp6  = (a & {16{b[6]}}) << 6;
    assign pp7  = (a & {16{b[7]}}) << 7;
    assign pp8  = (a & {16{b[8]}}) << 8;
    assign pp9  = (a & {16{b[9]}}) << 9;
    assign pp10 = (a & {16{b[10]}}) << 10;
    assign pp11 = (a & {16{b[11]}}) << 11;
    assign pp12 = (a & {16{b[12]}}) << 12;
    assign pp13 = (a & {16{b[13]}}) << 13;
    assign pp14 = (a & {16{b[14]}}) << 14;
    assign pp15 = (a & {16{b[15]}}) << 15;

    // Sum partial products using 16-bit adders
    full_adder_16bit adder0 (.a(pp0), .b(pp1), .cin(1'b0), .sum(sum0), .cout(carry0));
    full_adder_16bit adder1 (.a(pp2), .b(pp3), .cin(carry0), .sum(sum1), .cout(carry1));
    full_adder_16bit adder2 (.a(pp4), .b(pp5), .cin(carry1), .sum(sum2), .cout(carry2));
    full_adder_16bit adder3 (.a(pp6), .b(pp7), .cin(carry2), .sum(sum3), .cout(carry3));
    full_adder_16bit adder4 (.a(sum0), .b(sum1), .cin(carry3), .sum(sum4), .cout(carry4));
    full_adder_16bit adder5 (.a(sum2), .b(sum3), .cin(carry4), .sum(sum5), .cout(carry5));
    full_adder_16bit adder6 (.a(sum4), .b(pp8), .cin(carry5), .sum(sum6), .cout(carry6));
    full_adder_16bit adder7 (.a(sum5), .b(pp9), .cin(carry6), .sum(sum7), .cout());

    // Combine all partial products
    wire [15:0] final_sum;
    assign final_sum = sum6 + sum7 + pp10 + pp11 + pp12 + pp13 + pp14 + pp15;

    // Assign output
    assign product = final_sum[15:0]; // Use the lower 16 bits of the result

endmodule
