module Data_Register (
    input [3:0] program_counter,  // Current instruction address
    output reg [15:0] a,          // Operand a
    output reg [15:0] b           // Operand b
);
    reg [15:0] data_a [15:0];     // 16 data values for a
    reg [15:0] data_b [15:0];     // 16 data values for b

    initial begin
        // Predefined data values
        data_a[0] = 16'h000A;
        data_b[0] = 16'h0005;
        data_a[1] = 16'h0010;
        data_b[1] = 16'h0008;
        data_a[2] = 16'h00FF;
        data_b[2] = 16'h000F;
        data_a[3] = 16'h0030;
        data_b[3] = 16'h0010;
        // Add more data as needed
    end

    always @(*) begin
        a = data_a[program_counter];
        b = data_b[program_counter];
    end
endmodule
