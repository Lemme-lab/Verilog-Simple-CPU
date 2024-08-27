module AC_16Bit (
    input clk,                  // Clock signal
    input load,                 // Load signal
    input inc,                  // Increment signal
    input [15:0] alu_result,    // Data input from the ALU
    output reg [15:0] ac_out    // Accumulator output
);

    // Register to hold the accumulator value
    always @(posedge clk) begin
        if (load) begin
            ac_out <= alu_result; // Load ALU result into accumulator
        end else if (inc) begin
            ac_out <= ac_out + 1; // Increment accumulator by 1
        end
    end

endmodule
