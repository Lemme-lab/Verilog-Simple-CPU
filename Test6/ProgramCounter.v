module ProgramCounter (
    input clk,
    input reset,
    input jump,
    input [15:0] jump_address,
    output [15:0] out
);

reg [15:0] pc;

always @(posedge clk, posedge reset) begin
    if (reset)
        pc <= 16'b0;
    else if (jump)
        pc <= jump_address;
    else
        pc <= pc + 1;
end

assign out = pc;

endmodule