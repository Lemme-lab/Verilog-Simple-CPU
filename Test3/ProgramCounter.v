module ProgramCounter (
    input clk,
    input reset,
    input [15:0] next_pc,
    output reg [15:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'b0;
        end else begin
            pc <= next_pc;
        end
    end
endmodule
