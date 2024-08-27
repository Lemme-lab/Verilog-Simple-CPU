module InstructionRegister (
    input clk,
    input reset,
    input [15:0] in,
    output [15:0] out
);

reg [15:0] ir;

always @(posedge clk, posedge reset) begin
    if (reset)
        ir <= 16'b0;
    else
        ir <= in;
end

assign out = ir;

endmodule