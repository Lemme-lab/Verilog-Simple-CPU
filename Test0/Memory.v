module memory_unit (
    input clk,                  // Clock signal
    input we,                   // Write enable signal (1 to write, 0 to read)
    input [7:0] address,        // Address line (8 bits for example, for 256 addresses)
    input [15:0] write_data,    // Data input (16 bits)
    output reg [15:0] read_data // Data output (16 bits)
);

    reg [15:0] mem [255:0];     // 256 x 16-bit memory array

    always @(posedge clk) begin
        if (we) begin
            mem[address] <= write_data; // Save data to memory at the given address
        end
        read_data <= mem[address];      // Load data from memory at the given address
    end

endmodule
