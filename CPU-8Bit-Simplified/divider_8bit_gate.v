module divider_8bit (
    input [7:0] dividend,   // 8-bit dividend
    input [7:0] divisor,    // 8-bit divisor
    output reg [7:0] quotient, // 8-bit quotient
    output reg [7:0] remainder // 8-bit remainder
);

    always @(*) begin
        if (divisor != 0) begin
            quotient = dividend / divisor;
            remainder = dividend % divisor;
        end else begin
            quotient = 8'hFF;  // Indicate division by zero
            remainder = 8'hFF; // Indicate division by zero
        end
    end
endmodule
