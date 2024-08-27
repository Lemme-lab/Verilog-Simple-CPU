module Output_Register (
    input clk,
    input [15:0] acc_value,        // Value from Accumulator
    input [4:0] output_index,      // Index in the Output Register (5 bits for 32 slots)
    input write_enable,            // Write enable signal for storing the result
    output reg [15:0] output_value // Output wire to send the result to external logic
);
    reg [15:0] memory [31:0];  // 32 places, each 16 bits wide

    always @(posedge clk) begin
        if (write_enable) begin
            // Write the accumulator value to the specified index in the Output Register
            memory[output_index] <= acc_value;
        end
    end

    always @(*) begin
        // Continuously output the stored value at the specified index
        output_value = memory[output_index];
    end
endmodule


