module Data_Register (
    input [3:0] address,  // Address to load operand
    output reg [15:0] data // Operand data
);
    reg [15:0] memory [15:0];  // 16 locations of 16-bit memory

    initial begin
        // Predefined data values for the memory
        memory[0] = 16'h000A;  // 10
        memory[1] = 16'h000F;  // 15
        memory[2] = 16'h0010;  // 16
        memory[3] = 16'h0008;  // 8
        memory[4] = 16'h00FF;  // 255
        memory[5] = 16'h000F;  // 15
        memory[6] = 16'h000A;  // 10
        // Add more data as needed
    end

    always @(*) begin
        data = memory[address];  // Load operand from the specified address
    end
endmodule
