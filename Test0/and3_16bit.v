module and3_16bit (
    input [15:0] a,   // First 16-bit input
    input [15:0] b,   // Second 16-bit input
    input [15:0] c,   // Third 16-bit input
    output [15:0] y   // 16-bit output
);

    // Perform 3-way AND operation on each bit
    assign y = a & b & c;

endmodule
