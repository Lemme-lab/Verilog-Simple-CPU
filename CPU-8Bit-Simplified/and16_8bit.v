module and8_8bit (
    input [7:0] a,   // First 8-bit input
    input [7:0] b,   // Second 8-bit input
    output [7:0] y   // 8-bit output
);
    assign y = a & b; // Perform bitwise AND operation
endmodule

