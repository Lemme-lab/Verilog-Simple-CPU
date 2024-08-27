`ifndef OR_16BIT_V
`define OR_16BIT_V

module or_16bit (
    input [15:0] a,   // First 16-bit input
    input [15:0] b,   // Second 16-bit input
    output [15:0] y   // 16-bit output
);

    // Perform bitwise OR operation
    assign y = a | b;

endmodule

`endif
