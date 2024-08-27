module CPU (
    input clk,
    input reset,
    output [15:0] final_result
);
    wire [15:0] instruction;
    wire [15:0] data;
    wire [15:0] result;
    wire [2:0] op_select;
    wire sub;
    
    // Instantiate registers and other components
    Instruction_Register ir (
        .clk(clk),
        .reset(reset),
        .instruction_in(instruction),
        .instruction_out(instruction)
    );
    
    Data_Register dr (
        .clk(clk),
        .reset(reset),
        .data_in(instruction[12:0]), // Assume lower 13 bits are data
        .data_out(data)
    );
    
    Output_Register or (
        .clk(clk),
        .reset(reset),
        .result_in(result),
        .result_out(final_result)
    );

    Control_Unit cu (
        .instruction(instruction),
        .op_select(op_select),
        .sub(sub)
    );
    
    ALU_16Bit alu (
        .a(data),
        .b(data),
        .sub(sub),
        .op_select(op_select),
        .result(result)
    );
    
    // Instruction memory to provide instructions to IR
    Instruction_Memory im (
        .address(4'b0000), // Example address
        .instruction(instruction)
    );
    
endmodule
