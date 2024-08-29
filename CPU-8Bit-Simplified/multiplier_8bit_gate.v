module multiplier_8bit (
    input [7:0] a,       // 8-bit multiplicand
    input [7:0] b,       // 8-bit multiplier
    output [7:0] product // 8-bit product
);

    // Internal wires to hold partial products
    wire [7:0] pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7;

    // Internal wires to hold sums and carries
    wire [7:0] sum0, sum1, sum2, sum3;
    wire [7:0] sum4, sum5, sum6;
    wire carry0, carry1, carry2, carry3, carry4, carry5;

    // Generate partial products
    assign pp0 = (a & {8{b[0]}});     // Partial product for b[0]
    assign pp1 = (a & {8{b[1]}}) << 1; // Partial product for b[1], shifted by 1 bit
    assign pp2 = (a & {8{b[2]}}) << 2; // Partial product for b[2], shifted by 2 bits
    assign pp3 = (a & {8{b[3]}}) << 3; // Partial product for b[3], shifted by 3 bits
    assign pp4 = (a & {8{b[4]}}) << 4; // Partial product for b[4], shifted by 4 bits
    assign pp5 = (a & {8{b[5]}}) << 5; // Partial product for b[5], shifted by 5 bits
    assign pp6 = (a & {8{b[6]}}) << 6; // Partial product for b[6], shifted by 6 bits
    assign pp7 = (a & {8{b[7]}}) << 7; // Partial product for b[7], shifted by 7 bits

    // Sum partial products using 8-bit adders
    full_adder_8bit adder0 (.a(pp0), .b(pp1), .cin(1'b0), .sum(sum0), .cout(carry0));
    full_adder_8bit adder1 (.a(pp2), .b(pp3), .cin(carry0), .sum(sum1), .cout(carry1));
    full_adder_8bit adder2 (.a(pp4), .b(pp5), .cin(carry1), .sum(sum2), .cout(carry2));
    full_adder_8bit adder3 (.a(pp6), .b(pp7), .cin(carry2), .sum(sum3), .cout(carry3));

    full_adder_8bit adder4 (.a(sum0), .b(sum1), .cin(carry3), .sum(sum4), .cout(carry4));
    full_adder_8bit adder5 (.a(sum2), .b(sum3), .cin(carry4), .sum(sum5), .cout(carry5));

    // Final sum gives the 8-bit product
    assign product = sum4 + sum5;  // Use only the lower 8 bits of the final result

endmodule
