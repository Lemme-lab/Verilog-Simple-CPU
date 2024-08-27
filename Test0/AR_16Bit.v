module AR_16Bit (
    input clk,                  // Clock signal
    input load,                 // Load signal
    input [15:0] bus,           // 16-bit internal bus
    output reg [15:0] or_out    // 16-bit Output Register output
);

    // Register to hold the 16-bit output value
    always @(negedge clk) begin
        if (load) begin
            or_out <= bus;      // Load the entire 16 bits from the bus into the output register
        end
    end

endmodule