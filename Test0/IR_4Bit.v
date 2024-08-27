module IR_4Bit (
    input clk,                  // Clock signal
    input load,                 // Load signal
    input [15:0] bus,           // 16-bit internal bus (only higher 4 bits are used)
    output reg [3:0] ir_out     // 4-bit Instruction Register output
);

    // Register to hold the 4-bit instruction value
    always @(negedge clk) begin
        if (load) begin
            ir_out <= bus[15:12]; 
        end
    end

endmodule
