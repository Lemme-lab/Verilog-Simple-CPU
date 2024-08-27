`timescale 1ns / 1ps

module tb_Calculation_and_Register;

    // Testbench signals
    reg clk;
    reg arload;
    reg pcload;
    reg pcinc;
    reg pcbus;
    reg drload;
    reg drbus;
    reg [15:0] databus;
    reg [15:0] D;
    reg membus;
    reg [2:0] alusel;
    reg ac_load;
    reg ac_inc;
    reg irload;
    wire [15:0] A;
    wire [15:0] ACC;
    wire [3:0] Instr;
    wire [7:0] DR_out; // Debug output

    // Instantiate the Calculation_and_Register module
    Calculation_and_Register uut (
        .clk(clk),
        .arload(arload),
        .pcload(pcload),
        .pcinc(pcinc),
        .pcbus(pcbus),
        .drload(drload),
        .drbus(drbus),
        .databus(databus),
        .D(D),
        .membus(membus),
        .alusel(alusel),
        .ac_load(ac_load),
        .ac_inc(ac_inc),
        .irload(irload),
        .A(A),
        .ACC(ACC),
        .Instr(Instr),
        .DR_out(DR_out) // Connect debug output
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10ns clock period (100 MHz)
    end

    initial begin
        // Initialize signals
        clk = 0;
        arload = 0;
        pcload = 0;
        pcinc = 0;
        pcbus = 0;
        drload = 0;
        drbus = 0;
        databus = 16'b0;
        D = 16'b0;
        membus = 0;
        alusel = 3'b000; // Set ALU operation to add
        ac_load = 0;
        ac_inc = 0;
        irload = 0;

        // Load the number 2 into the Data Register
        databus = 16'h0002; // Data for Data Register
        drload = 1;         // Load Data Register
        #10 drload = 0;

        // Check Data Register output
        #10;
        $display("Data Register DR = %h", DR_out);

        // Load the number 3 into the Data Register
        databus = 16'h0003; // Data for Data Register
        drload = 1;         // Load Data Register
        #10 drload = 0;

        // Check Data Register output
        #10;
        $display("Data Register DR = %h", DR_out);

        // Set ALU operation to add (assuming 3'b000 is add)
        alusel = 3'b000; // Add operation
        ac_load = 1;    // Load Accumulator with result from ALU
        #10 ac_load = 0;

        // Simulate some delay to allow the operation to complete
        #10;

        // Display results
        $display("Address Register A = %h", A);
        $display("Instruction Register Instr = %h", Instr);
        $display("Accumulator ACC = %h", ACC);

        // Check expected values
        if (ACC == 16'h0005) begin
            $display("Test Passed: ACC = %h", ACC);
        end else begin
            $display("Test Failed: ACC = %h", ACC);
        end

        $finish;
    end

endmodule
