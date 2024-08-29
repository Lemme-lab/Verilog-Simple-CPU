module or8_8bit (
    input [7:0] a,  // 8-bit input
    output y        // 1-bit output
);

    // Perform bitwise OR operation across all bits of the input using a reduction operator
    assign y = |a;  // Reduction OR operator: outputs 1 if any bit in 'a' is 1, otherwise 0

endmodule
