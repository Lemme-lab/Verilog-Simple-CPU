module divider_16bit (
    input [15:0] dividend,   // 16-bit dividend
    input [15:0] divisor,    // 16-bit divisor
    output reg [15:0] quotient, // 16-bit quotient
    output reg [15:0] remainder // 16-bit remainder
);

    always @(*) begin
        if (divisor != 0) begin
            // Perform division and calculate quotient and remainder
            quotient = dividend / divisor;
            remainder = dividend % divisor;
        end else begin
            // Handle division by zero (undefined behavior)
            quotient = 16'hFFFF; // Or any error signal you want
            remainder = 16'hFFFF; // Or any error signal you want
        end
    end

endmodule
