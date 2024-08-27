module TriStateBuffer (
    input [15:0] data_in,   // Input data from the Program Counter
    input pcbus,            // Control signal to enable/disable the buffer
    output tri [15:0] data_out // Buffered output
);

    assign data_out = pcbus ? data_in : 16'bz; // Drive data to output if pcbus is asserted, else high impedance

endmodule
