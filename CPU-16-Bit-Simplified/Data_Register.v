module Data_Register (
    input clk,
    input load,                      // Unified load signal
    input is_instruction,            // Selector signal to differentiate between instruction and data
    input [3:0] load_address,        // Address to load data (4 bits)
    input [15:0] cpu_input,          // Unified input for loading both instruction and data
    input [3:0] address,             // Address to fetch operand
    output reg [15:0] data           // Operand data
);
    reg [15:0] memory [15:0];  // 16 locations of 16-bit memory
    integer i;  // Declare loop variable outside the initial block

    initial begin
        // Initialize the data memory with predefined values or zeros
        for (i = 0; i < 16; i = i + 1) begin
            memory[i] = 16'b0;
        end
    end

    always @(posedge clk) begin
        if (load && !is_instruction) begin
            // Load data into the specified address
            memory[load_address[3:0]] <= cpu_input;
        end
    end

    always @(*) begin
        // Fetch the data from the data memory
        data = memory[address];
    end
endmodule
