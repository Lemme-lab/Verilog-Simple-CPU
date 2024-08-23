module Memory (
    input clk,
    input [15:0] address,
    input [15:0] data_in,
    input write_enable,
    output reg [15:0] data_out
);
    reg [15:0] mem [0:255];  // 256 x 16-bit memory

    always @(posedge clk) begin
        if (write_enable) begin
            mem[address] <= data_in;
        end
        data_out <= mem[address];
    end
endmodule
