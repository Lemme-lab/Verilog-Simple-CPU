module tb_cpu;

    // Testbench signals
    reg clk;
    reg reset_n;
    reg inputReady;
    reg [`WORD_SIZE-1:0] data_in;
    wire readM;
    wire writeM;
    wire [`WORD_SIZE-1:0] address;
    wire [`WORD_SIZE-1:0] data_out;
    wire [`WORD_SIZE-1:0] output_port;
    wire [`WORD_SIZE-1:0] num_inst;

    // Instantiate the CPU
    cpu uut (
        .readM(readM),
        .writeM(writeM),
        .address(address),
        .data_out(data_out),
        .data_in(data_in),
        .inputReady(inputReady),
        .reset_n(reset_n),
        .clk(clk),
        .num_inst(num_inst),
        .output_port(output_port)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset_n = 0;
        inputReady = 0;
        data_in = 0;

        // Apply reset
        #10;
        reset_n = 1;
        #10;

        // Simulate instruction fetch
        inputReady = 1;
        data_in = 16'hA3B4; // Example instruction
        #10;
        inputReady = 0;
        #10;

        // Simulate data write
        inputReady = 1;
        data_in = 16'h5678; // Example data
        #10;
        inputReady = 0;
        #10;

        // End simulation
        #100;
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | address: %h | data_in: %h | data_out: %h | readM: %b | writeM: %b | output_port: %h | num_inst: %d",
                 $time, address, data_in, data_out, readM, writeM, output_port, num_inst);
    end

endmodule
