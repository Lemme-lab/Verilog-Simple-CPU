module TopLevel_tb;

    // Testbench signals
    reg [15:0] command;
    reg [15:0] number;
    reg [15:0] address;
    reg clk;
    reg rst;
    wire [15:0] result;
    wire cout;
    wire overflow;
    wire NO;
    wire ZO;

    // Instantiate the TopLevel module
    TopLevel uut (
        .command(command),
        .number(number),
        .address(address),
        .clk(clk),
        .rst(rst),
        .result(result),
        .cout(cout),
        .overflow(overflow),
        .NO(NO),
        .ZO(ZO)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        command = 16'b0;
        number = 16'b0;
        address = 16'b0;

        // Open VCD file for waveform viewing
        $dumpfile("TopLevel_tb.vcd");
        $dumpvars(0, TopLevel_tb);

        // Reset the system
        #10 rst = 0;
        #10;

        // Step 1: Store first number (8) into address 0
        address = 16'h0000;
        number = 16'h0008;
        command = 16'h2000; // Command for storing a number into memory
        #10;

        // Step 2: Store second number (4) into address 1
        address = 16'h0001;
        number = 16'h0004;
        command = 16'h2000; // Same store command
        #10;

        // Step 3: Load the first number from memory into the ALU
        address = 16'h0000;
        command = 16'h3000; // Command to load number from memory
        #10;

        // Step 4: Load the second number from memory into the ALU
        address = 16'h0001;
        command = 16'h3001; // Command to load another number from memory
        #10;

        // Step 5: Perform addition of the two loaded numbers
        command = 16'h4000; // Command for addition operation
        #10;

        // Step 6: Check the ALU result
        #10;
        $display("Time: %0t | Addition result: %h", $time, result);

        // Step 7: Save the result of addition into memory address 2
        address = 16'h0002;
        command = 16'h5000; // Command to store result into memory
        #10;

        // Step 8: Load the result from memory address 2
        address = 16'h0002;
        command = 16'h3002; // Command to load result from memory
        #10;
        $display("Time: %0t | Loaded Result from Memory[2]: %h", $time, result);

        // Finish simulation
        #10;
        $finish;
    end

endmodule
