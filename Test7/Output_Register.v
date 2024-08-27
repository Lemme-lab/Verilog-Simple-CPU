module Output_Register (
    input clk,
    input reset,
    input [15:0] result_in,
    output reg [15:0] result_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            result_out <= 16'b0;
        else
            result_out <= result_in;
    end
endmodule
