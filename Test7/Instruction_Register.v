module Instruction_Register (
    input clk,
    input reset,
    input [15:0] instruction_in,
    output reg [15:0] instruction_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            instruction_out <= 16'b0;
        else
            instruction_out <= instruction_in;
    end
endmodule
