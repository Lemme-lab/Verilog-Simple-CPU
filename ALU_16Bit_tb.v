module ALU_16Bit_tb;

    reg [15:0] a;
    reg [15:0] b;
    reg sub;
    reg [2:0] op_select;
    reg load;
    reg [2:0] reg_select;
    wire [15:0] result;
    wire cout;
    wire overflow;
    wire NO;
    wire ZO;
    wire [15:0] accumulator; // Output wire for accumulator

    // Instantiate the ALU module
    ALU_16Bit uut (
        .a(a),
        .b(b),
        .sub(sub),
        .op_select(op_select),
        .load(load),
        .reg_select(reg_select),
        .result(result),
        .cout(cout),
        .overflow(overflow),
        .NO(NO),
        .ZO(ZO),
        .accumulator(accumulator) // Connect to accumulator output
    );

    // Declare VCD file
    initial begin
        $dumpfile("ALU_16Bit_tb.vcd"); // Name of the VCD file
        $dumpvars(0, ALU_16Bit_tb);     // Dump all variables in this module
    end

    // Test sequence
    initial begin
        // Initialize inputs
        a = 16'h0000;
        b = 16'h0000;
        sub = 0;
        op_select = 3'b000;
        load = 0;
        reg_select = 3'b000;

        // Monitor signals
        $monitor("Time: %0t | a: %h | b: %h | result: %h | accumulator: %h | cout: %b | overflow: %b | NO: %b | ZO: %b", 
                 $time, a, b, result, accumulator, cout, overflow, NO, ZO);

        // Load values into registers
        #10 a = 16'h0010; load = 1; reg_select = 3'b000; // Load 16'h0010 into reg[0]
        #10 load = 0;
        #10 a = 16'h0020; load = 1; reg_select = 3'b001; // Load 16'h0020 into reg[1]
        #10 load = 0;

        // Set `a` and `b` for operations
        #10;

        // Perform addition
        #10 op_select = 3'b000; // Addition operation
        #10;

        // Perform subtraction
        #10 op_select = 3'b001; // Subtraction operation
        #10;

        // Perform AND operation
        #10 op_select = 3'b010; // AND operation
        #10;

        // Perform OR operation
        #10 op_select = 3'b011; // OR operation
        #10;

        // Perform multiplication
        #10 op_select = 3'b100; // Multiply operation
        #10;

        // Perform division
        #10 op_select = 3'b101; // Divide operation
        #10;

        // End simulation
        #20 $finish;
    end

endmodule
