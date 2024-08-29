module mux6to1_8bit (
    input [7:0] in0,   // Input for operation 0
    input [7:0] in1,   // Input for operation 1
    input [7:0] in2,   // Input for operation 2
    input [7:0] in3,   // Input for operation 3
    input [7:0] in4,   // Input for operation 4
    input [7:0] in5,   // Input for operation 5
    input [2:0] sel,   // 3-bit select input
    output [7:0] out   // Output
);
    assign out = (sel == 3'b000) ? in0 :
                (sel == 3'b001) ? in1 :
                (sel == 3'b010) ? in2 :
                (sel == 3'b011) ? in3 :
                (sel == 3'b100) ? in4 :
                (sel == 3'b101) ? in5 :
                8'b0;  // Default case (optional, should not occur if sel is always in range)
endmodule

