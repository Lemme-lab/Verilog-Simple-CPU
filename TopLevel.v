`include "ALU_16Bit.v"
`include "ControlUnit.v"
`include "Memory.v"

module TopLevel (
    input [15:0] command,
    input [15:0] number,
    input [15:0] address,
    input clk,
    input rst,
    output reg [15:0] result,
    output wire cout,
    output wire overflow,
    output wire NO,
    output wire ZO
);
    reg [15:0] mem [0:255];  // Internal memory array
    reg [15:0] alu_result;
    reg write_enable;
    reg [2:0] op_select;
    reg sub;
    reg [15:0] addr;

    // ALU outputs
    wire [15:0] alu_result_internal;
    wire cout_internal;
    wire overflow_internal;
    wire NO_internal;
    wire ZO_internal;

    // Instantiate the ALU
    ALU_16Bit alu (
        .a(number),
        .b(mem[address]),  // Use memory content as the second operand
        .sub(sub),
        .op_select(op_select),
        .result(alu_result_internal),
        .cout(cout_internal),
        .overflow(overflow_internal),
        .NO(NO_internal),
        .ZO(ZO_internal)
    );

    // Memory initialization using an initial block
    initial begin
        // Initialize memory
        mem[0] = 16'b0;
        mem[1] = 16'b0;
        // Initialize other memory locations as needed
    end

    // Internal memory operations
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset result and other state
            result <= 16'b0;
        end else begin
            case (command[15:12])
                4'b0010: begin  // STORE command
                    if (write_enable) begin
                        mem[address] <= alu_result_internal;
                    end
                end
                4'b0011: begin  // LOAD command
                    result <= mem[address];
                end
                4'b0100: begin  // COMPUTE command
                    alu_result <= alu_result_internal;
                    // Other ALU results
                end
                default: begin
                    // Handle other commands or default behavior
                end
            endcase
        end
    end

    // Output connections
    assign cout = cout_internal;
    assign overflow = overflow_internal;
    assign NO = NO_internal;
    assign ZO = ZO_internal;

endmodule
