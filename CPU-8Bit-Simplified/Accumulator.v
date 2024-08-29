module Accumulator (
    input clk,
    input reset,
    input [7:0] alu_result,   // Result from the ALU
    output reg [7:0] acc_value // Accumulator value
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            acc_value <= 8'b0;  // Reset the accumulator
        else
            acc_value <= alu_result; // Store ALU result in the accumulator
    end
endmodule

