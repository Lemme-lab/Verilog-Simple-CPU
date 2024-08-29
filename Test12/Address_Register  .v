module Address_Register (
    input [15:0] instruction,  // 16-bit instruction
    output reg [3:0] address   // Address for the operand
);
    always @(*) begin
        address = instruction[11:8];  // Extract address for operand
    end
endmodule
