module Data_Register (
    input clk,
    input load_data,                   // Signal to load data
    input [3:0] load_data_address,     // Address to load data
    input [15:0] data_input,           // Input for loading data
    input [3:0] address,               // Address to load operand
    output reg [15:0] data             // Operand data
);
    reg [15:0] memory [15:0];  // 16 locations of 16-bit memory

    always @(posedge clk) begin
        if (load_data) begin
            // Load data into the specified address
            memory[load_data_address] <= data_input;
        end
    end

    always @(*) begin
        // Fetch the data from the data memory
        data = memory[address];
    end
endmodule