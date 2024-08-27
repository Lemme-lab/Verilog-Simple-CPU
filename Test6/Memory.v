module Memory (
    input clk,
    input write_enable,
    input [15:0] address,
    input [15:0] data_in,
    output [15:0] data_out
);

reg [15:0] memory [0:255]; // Assuming 256 bytes of memory

always @(posedge clk) begin
    if (write_enable)
        memory[address] <= data_in;
end

assign data_out = memory[address];

endmodule