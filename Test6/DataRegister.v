module DataRegister (
    input clk,
    input reset,
    input [15:0] in,
    output [15:0] out
);

reg [15:0] dr;

always @(posedge clk, posedge reset) begin
    if (reset)
        dr <= 16'b0;
    else
        dr <= in;
end

assign out = dr;

endmodule