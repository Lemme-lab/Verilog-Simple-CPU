`timescale 1ns / 1ps

module ALU_16Bit_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [15:0] b;
    reg sub;
    reg [2:0] op_select;

    // Outputs
    wire [15:0] result;
    wire cout;
    wire overflow;
    wire NO;
    wire ZO;

    // Instantiate the ALU_16Bit module
    ALU_16Bit uut (
        .clk(clk),
        .reset(reset),
        .b(b),
        .sub(sub),
        .op_select(op_select),
        .result(result),
        .cout(cout),
        .overflow(overflow),
        .NO(NO),
        .ZO(ZO)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        b = 16'h0000;
        sub = 0;
        op_select = 3'b000; // Addition

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Test cases
        // Test Case 1: Addition
        op_select = 3'b000;
        b = 16'h0010; // Add 16
        #10;
        b = 16'h0020; // Add 32
        #10;

        // Test Case 2: Subtraction
        sub = 1;
        op_select = 3'b001;
        b = 16'h0010; // Subtract 16
        #10;
        b = 16'h0020; // Subtract 32
        #10;

        // Test Case 3: AND
        sub = 0;
        op_select = 3'b010;
        b = 16'h00FF; // AND with 255
        #10;
        b = 16'h0F0F; // AND with 3855
        #10;

        // Test Case 4: OR
        op_select = 3'b011;
        b = 16'h00FF; // OR with 255
        #10;
        b = 16'h0F0F; // OR with 3855
        #10;

        // Test Case 5: Multiply
        op_select = 3'b100;
        b = 16'h0004; // Multiply by 4
        #10;
        b = 16'h0002; // Multiply by 2
        #10;

        // Test Case 6: Divide
        op_select = 3'b101;
        b = 16'h0004; // Divide by 4
        #10;
        b = 16'h0002; // Divide by 2
        #10;

        // Test Case 7: Check Overflow
        op_select = 3'b000;
        sub = 0;
        b = 16'hFFFF; // Adding -1, expect overflow
        #10;
        b = 16'h0001; // Adding 1 to 0xFFFF, expect overflow
        #10;

        // Test Case 8: Accumulator behavior
        // Check if accumulator holds the result correctly
        op_select = 3'b000;
        b = 16'h0010; // Add 16
        #10;
        op_select = 3'b000;
        b = 16'h0020; // Add 32, should be 16 + 32 = 48
        #10;

        // Test Case 9: Accumulator reset
        reset = 1;
        #10;
        reset = 0;
        op_select = 3'b000;
        b = 16'h0010; // After reset, expect accumulator to be 0, then 16
        #10;

        // Finish simulation
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | reset: %b | b: %h | sub: %b | op_select: %b | result: %h | cout: %b | overflow: %b | NO: %b | ZO: %b",
                 $time, clk, reset, b, sub, op_select, result, cout, overflow, NO, ZO);
    end

endmodule
