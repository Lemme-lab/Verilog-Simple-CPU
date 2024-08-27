module or16_16Bit (
    input [15:0] a,  // 16-bit input
    output y         // 1-bit output
);

    // Perform bitwise OR operation across all bits of the input
    assign y = |a;    // Reduction OR operator

endmodule
