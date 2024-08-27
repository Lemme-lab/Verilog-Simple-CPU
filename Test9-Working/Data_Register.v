module Data_Register (
    input [3:0] address_a,  // Address to fetch operand a
    input [3:0] address_b,  // Address to fetch operand b
    output reg [15:0] a,    // Operand a
    output reg [15:0] b     // Operand b
);
    reg [15:0] memory [15:0];  // 16 locations of 16-bit memory

    initial begin
        // Predefined data values for the memory
memory[0] = 16'h000A;  // 10
memory[1] = 16'h0005;  // 5
memory[2] = 16'h0010;  // 16
memory[3] = 16'h0008;  // 8
memory[4] = 16'h00FF;  // 255
memory[5] = 16'h000F;  // 15
memory[6] = 16'h0030;  // 48
memory[7] = 16'h0010;  // 16
memory[8] = 16'h0020;  // 32
memory[10] = 16'h0040; // 64

        // Add more data as needed
    end

    always @(*) begin
        a = memory[address_a];  // Load operand a from the specified address
        b = memory[address_b];  // Load operand b from the specified address
    end
endmodule

