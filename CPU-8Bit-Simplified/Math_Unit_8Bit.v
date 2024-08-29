module Math_Unit_8Bit (
    input [7:0] a,    // First 8-bit input
    input [7:0] b,    // Second 8-bit input
    input sub,        // Subtract control signal (1 for subtraction, 0 for addition)
    output [7:0] sum, // 8-bit sum output
    output cout,      // Carry output from the most significant bit
    output overflow,  // Overflow detection
    output NO,        // Negative Out
    output ZO         // Zero Out
);
    wire [7:0] b_xor; // XOR-ed version of b (for subtraction)
    wire carry_in;    // Carry input to the adder
    wire or_result;   // Result of OR reduction

    // XOR b with the subtraction signal to handle both addition and subtraction
    assign b_xor = b ^ {8{sub}};

    // Carry input to the adder is the subtraction signal
    assign carry_in = sub;

    // Full adder instance
    full_adder_8bit adder (
        .a(a),
        .b(b_xor),
        .cin(carry_in),
        .sum(sum),
        .cout(cout)
    );

    // Overflow detection: Overflow occurs if carry-in to MSB differs from carry-out of MSB
    assign overflow = (a[7] & b_xor[7] & ~sum[7]) |
                      (~a[7] & ~b_xor[7] & sum[7]);

    // Negative Out (NO): High if the most significant bit (sign bit) of the result is 1
    assign NO = sum[7];

    // Zero Out (ZO): High if all bits in the result are 0
    or8_8bit orGate (
        .a(sum),
        .y(or_result)
    );
    
    assign ZO = ~or_result;
endmodule
