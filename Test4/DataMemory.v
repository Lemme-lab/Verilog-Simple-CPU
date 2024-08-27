module DataMemory (
    input clk,
    input [15:0] address,
    input [15:0] write_data,
    input mem_write,
    output [15:0] read_data
);
    reg [15:0] memory [255:0]; // 256 memory locations, each 16-bit

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address] <= write_data;
        end
    end

    assign read_data = memory[address];
endmodule
