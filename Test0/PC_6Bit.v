module PC_6Bit (
    input clk,                  // Clock signal
    input pcload,               // Load control signal
    input pcinc,                // Increment control signal
    input [15:0] bus,           // 16-bit internal bus (only lower 6 bits are used)
    output reg [5:0] pc_out     // 6-bit Program Counter output
);

    // Internal register to hold the current value of the Program Counter
    reg [5:0] pc;

    // Update the Program Counter value
    always @(negedge clk) begin
        if (pcload) begin
            pc <= bus[5:0];    // Load the lower 6 bits from the bus into the Program Counter
        end
        else if (pcinc) begin
            pc <= pc + 1;      // Increment the Program Counter by 1
        end
    end

    // Output the current value of the Program Counter
    always @(*) begin
        pc_out = pc;
    end

endmodule
