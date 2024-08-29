module Program_Counter (
    input clk,
    input reset,
    output reg [4:0] program_counter  // Changed to 5 bits
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            program_counter <= 5'b00000;  // Reset to the first instruction
        else
            program_counter <= program_counter + 1;  // Increment PC
    end
endmodule

