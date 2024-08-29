module Output_Register (
    input clk,
    input [7:0] acc_value,        // Value from Accumulator
    input [4:0] output_index,     // Index in the Output Register (5 bits for 32 slots)
    input write_enable,           // Write enable signal for storing the result
    input read_enable,            // Read enable signal to output stored value
    output reg [7:0] output_value // Output wire to send the result to external logic
);
    reg [7:0] memory [31:0];  // 32 places, each 8 bits wide

    always @(posedge clk) begin
        if (write_enable) begin
            // Write the accumulator value to the specified index in the Output Register
            memory[output_index] <= acc_value;
        end
    end

    always @(*) begin
        if (read_enable) begin
            // Output the value stored in the specified index of the Output Register
            output_value = memory[output_index];
        end
    end
endmodule
