module Address_Register (
    input [15:0] instruction,  // 16-bit instruction
    output reg [3:0] address_a,  // Address for operand a
    output reg [3:0] address_b   // Address for operand b
);
    always @(*) begin
        address_a = instruction[11:8];  // Extract address for operand a
        address_b = instruction[7:4];   // Extract address for operand b
    end
endmodule
