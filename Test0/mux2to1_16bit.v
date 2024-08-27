module mux2to1_16bit (
    input [15:0] in0,  // First input
    input [15:0] in1,  // Second input
    input sel,         // Select signal
    output reg [15:0] out  // Output
);

    // Use an always block to handle the selection logic
    always @(*) begin
        if (sel) 
            out = in1;  // If sel is 1, output in1
        else 
            out = in0;  // If sel is 0, output in0
    end

endmodule
