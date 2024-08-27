module DR_8Bit (
    input clk,                  // Clock signal
    input drload,               // Load control signal
    input [15:0] bus,           // 16-bit internal bus (only lower 8 bits are used)
    output reg [7:0] dr_out     // 8-bit Data Register output
);

    // Register to hold the 8-bit data value
    always @(negedge clk) begin
        if (drload) begin
            dr_out <= bus[7:0]; // Load the lower 8 bits from the bus into the Data Register
        end
    end

endmodule
