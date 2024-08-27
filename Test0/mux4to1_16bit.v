module mux4to1_16bit (
    input [15:0] in0,   // Input for operation 0
    input [15:0] in1,   // Input for operation 1
    input [15:0] in2,   // Input for operation 2
    input [15:0] in3,   // Input for operation 3
    input [2:0] sel,    // 3-bit select input
    output [15:0] out   // Output
);

    assign out = (sel == 3'b000) ? in0 :
                (sel == 3'b001) ? in1 :
                (sel == 3'b010) ? in2 :
                in3;  // sel == 3'b011

endmodule
