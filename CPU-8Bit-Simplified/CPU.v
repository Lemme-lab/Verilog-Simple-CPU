module CPU (
    input clk,
    input reset,
    input [7:0] cpu_input,          // Unified input for loading both instruction and data
    input [4:0] load_address,       // Address to load instruction or data (5 bits for instruction, 4 bits for data)
    input load,                     // Unified load signal for both instruction and data
    input is_instruction,           // Selector signal to differentiate between loading instruction or data
    output [7:0] output_value       // Output Register value on wire
);

    wire [4:0] program_counter;     // Program counter value (5 bits now)
    wire [7:0] instruction;         // Current instruction
    wire [7:0] data;                // Operand from Data Register
    wire [7:0] acc_value;           // Accumulator value
    wire sub;                       // Subtraction signal
    wire [2:0] op_select;           // Operation select signal
    wire [3:0] address;             // Address for Data Register
    wire [4:0] output_index;        // Index in the Output Register
    wire write_enable;              // Enable writing to Output Register
    wire read_enable;               // Enable reading from Output Register
    wire [7:0] result;              // ALU Result

    // Program Counter (increments and addresses the instructions)
    Program_Counter pc (
        .clk(clk),
        .reset(reset),
        .program_counter(program_counter)
    );

    // Instruction Register (fetches the instruction)
    Instruction_Register ir (
        .clk(clk),
        .load(load),
        .is_instruction(is_instruction),  // Selector to differentiate between instruction and data
        .load_address(load_address),
        .cpu_input(cpu_input),
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
        .load(load),
        .is_instruction(is_instruction),  // Selector to differentiate between instruction and data
        .load_address(load_address),
        .cpu_input(cpu_input),
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
    ALU_8Bit alu (
        .a(acc_value),                // Operand from the Accumulator
        .b(data),                     // Operand from the Data Register
        .sub(sub),
        .op_select(op_select),
        .result(result),              // Output of the ALU
        .cout(),                      // Carry out (not used)
        .overflow(),                  // Overflow (not used)
        .NO(),                        // Negative flag (not used)
        .ZO()                         // Zero flag (not used)
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
