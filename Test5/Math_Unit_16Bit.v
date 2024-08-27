
module Math_Unit_16Bit (
    input [15:0] a,     // First 16-bit input
    input [15:0] b,     // Second 16-bit input
    input sub,          // Subtract control signal (1 for subtraction, 0 for addition)
    output [15:0] sum,  // 16-bit sum output
    output cout,        // Carry output from the most significant bit
    output overflow,    // Overflow detection
    output NO,          // Negative Out
    output ZO           // Zero Out
);

    wire [15:0] b_xor;      // XOR-ed version of b (for subtraction)
    wire carry_in;         // Carry input to the adder
    wire or_result;        // Result of OR reduction

    // XOR b with the subtraction signal to handle both addition and subtraction
    assign b_xor = b ^ {16{sub}};

    // Carry input to the adder is the subtraction signal
    assign carry_in = sub;

    // Full adder instance
    full_adder_16bit adder (
        .a(a),
        .b(b_xor),
        .cin(carry_in),
        .sum(sum),
        .cout(cout)
    );

    // Overflow detection: Overflow occurs if carry-in to MSB differs from carry-out of MSB
    assign overflow = (a[15] & b_xor[15] & ~sum[15]) |
                      (~a[15] & ~b_xor[15] & sum[15]);

    // Negative Out (NO): High if the most significant bit (sign bit) of the result is 1
    assign NO = sum[15];

    // Zero Out (ZO): High if all bits in the result are 0
    // Instantiate the or16_to_1 module to perform OR reduction
    or16_16Bit orGate (
        .a(sum),
        .y(or_result)
    );
    
    assign ZO = ~or_result;

endmodule