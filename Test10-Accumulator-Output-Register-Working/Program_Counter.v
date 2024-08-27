module Program_Counter (
    input clk,
    input reset,
    output reg [3:0] program_counter
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            program_counter <= 4'b0000;  // Reset to the first instruction
        else
            program_counter <= program_counter + 1;  // Increment PC
    end
endmodule
