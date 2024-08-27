module full_adder (
    input a,           // First input bit
    input b,           // Second input bit
    input cin,         // Carry input
    output sum,        // Sum output
    output cout        // Carry output
);

    assign sum = a ^ b ^ cin;          // Sum is XOR of a, b, and cin
    assign cout = (a & b) | (cin & (a ^ b));  // Carry-out logic

endmodule
