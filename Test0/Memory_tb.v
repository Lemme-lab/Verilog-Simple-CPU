module testbench;

    reg clk;
    reg we;
    reg [7:0] address;
    reg [15:0] write_data;
    wire [15:0] read_data;

    // Instantiate the memory_unit
    memory_unit mem_inst (
        .clk(clk),
        .we(we),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test Sequence
    initial begin
        // Initialize signals
        we = 0;
        address = 0;
        write_data = 0;

        // Test Write Operation
        #10;
        we = 1;
        address = 8'hA0;       // Write to address A0
        write_data = 16'h1234; // Data to write: 0x1234
        #10;

        // Test Read Operation
        we = 0;
        address = 8'hA0;       // Read from address A0
        #10;

        $display("Read Data: %h", read_data); // Should output 0x1234

        #10;
        $stop;
    end

endmodule
