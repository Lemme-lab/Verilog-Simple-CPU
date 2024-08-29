module CPU (
    input clk,
    input reset,
    input [15:0] instruction_input,  // Input for loading instruction
    input [15:0] data_input,         // Input for loading data
    input [4:0] load_instr_address,  // Address to load instruction (5 bits now)
    input [3:0] load_data_address,   // Address to load data (4 bits)
    input load_instr,                // Signal to load instruction
    input load_data,                 // Signal to load data
    output [15:0] result,            // ALU Result
    output [15:0] output_value,      // Output Register value on wire
    output cout,
    output overflow,
    output NO,
    output ZO
);

    wire [4:0] program_counter;    // Program counter value (5 bits now)
    wire [15:0] instruction;       // Current instruction
    wire [15:0] data;              // Operand from Data Register
    wire [15:0] acc_value;         // Accumulator value
    wire sub;                      // Subtraction signal
    wire [2:0] op_select;          // Operation select signal
    wire [3:0] address;            // Address for Data Register
    wire [4:0] output_index;       // Index in the Output Register
    wire write_enable;             // Enable writing to Output Register
    wire read_enable;              // Enable reading from Output Register

    // Program Counter (increments and addresses the instructions)
    Program_Counter pc (
        .clk(clk),
        .reset(reset),
        .program_counter(program_counter)
    );

    // Instruction Register (fetches the instruction)
    Instruction_Register ir (
        .clk(clk),
        .load_instr(load_instr),
        .load_instr_address(load_instr_address),
        .instruction_input(instruction_input),
        .program_counter(program_counter),
        .instruction(instruction)
    );

    // Address Register (extracts address from the instruction)
    Address_Register ar (
        .instruction(instruction),
        .address(address)
    );

    // Data Register (fetches data based on the address provided by the instruction)
    Data_Register dr (
        .clk(clk),
        .load_data(load_data),
        .load_data_address(load_data_address),
        .data_input(data_input),
        .address(address),
        .data(data)
    );

    // Control Unit (decodes the instruction and generates control signals for the ALU and Output Register)
    Control_Unit cu (
        .clk(clk),
        .instruction(instruction),
        .sub(sub),
        .op_select(op_select),
        .write_enable(write_enable),
        .read_enable(read_enable),  // Connect read_enable signal to the control unit
        .output_index(output_index)
    );

    // Accumulator (stores the result of the ALU and provides one of the operands for the next operation)
    Accumulator acc (
        .clk(clk),
        .reset(reset),
        .alu_result(result),          // Result from the ALU
        .acc_value(acc_value)         // Output value of the accumulator
    );

    // ALU (performs arithmetic or logic operations based on the control signals)
    ALU_16Bit alu (
        .a(acc_value),                // Operand from the Accumulator
        .b(data),                     // Operand from the Data Register
        .sub(sub),
        .op_select(op_select),
        .result(result),              // Output of the ALU
        .cout(cout),
        .overflow(overflow),
        .NO(NO),
        .ZO(ZO)
    );

    // Output Register (stores the value to be outputted)
    Output_Register OR (
        .clk(clk),
        .acc_value(acc_value),
        .output_index(output_index),
        .write_enable(write_enable),
        .read_enable(read_enable),   // Connect read_enable signal to the Output Register
        .output_value(output_value)  // Final output value on the wire
    );
endmodule
