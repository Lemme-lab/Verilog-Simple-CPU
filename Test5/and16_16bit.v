module and16_16bit (
    input [15:0] a,   // First 16-bit input
    input [15:0] b,   // Second 16-bit input
    output [15:0] y   // 16-bit output
);

    // Perform bitwise AND operation on each bit
    assign y = a & b;

endmodule
