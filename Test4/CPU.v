module CPU (
    input clk,
    input reset,
    output [15:0] output_reg
);
    wire [15:0] pc;
    wire [15:0] instruction;
    wire [15:0] reg_data1, reg_data2;
    wire [15:0] alu_result;
    wire [15:0] mem_data;
    wire [2:0] op_select;
    wire alu_sub, mem_write, reg_write_enable, mem_read_enable;
    wire [3:0] reg_write_addr, reg_read_addr1, reg_read_addr2;
    wire [15:0] data_memory_address;
    
    // Instantiate components
    ProgramCounter pc_unit (
        .clk(clk),
        .reset(reset),
        .next_pc(pc + 1), // Simple increment for next instruction
        .pc(pc)
    );

    InstructionMemory instr_mem (
        .address(pc),
        .instruction(instruction)
    );

    InstructionDecoder instr_dec (
        .instruction(instruction),
        .op_select(op_select),
        .reg_write_addr(reg_write_addr),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .mem_write(mem_write),
        .reg_write_enable(reg_write_enable),
        .mem_read_enable(mem_read_enable)
    );

    RegisterFile reg_file (
        .clk(clk),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(mem_write ? alu_result : reg_data1), // Write ALU result or read data to register file
        .reg_write_enable(reg_write_enable),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    ALU_16Bit alu (
        .a(reg_data1),          // ALU input A from register data 1
        .b(reg_data2),          // ALU input B from register data 2
        .sub(alu_sub),
        .op_select(op_select),
        .result(alu_result)
    );

    DataMemory data_mem (
        .clk(clk),
        .address(data_memory_address),
        .write_data(alu_result), // Write ALU result to data memory
        .mem_write(mem_write),
        .read_data(mem_data)
    );

    // Determine the address for DataMemory
    assign data_memory_address = reg_data1; // Typically, this would be more complex depending on instruction

    // Output the result: ALU result or memory data, based on the operation
    assign output_reg = (op_select == 3'b101 || op_select == 3'b100) ? alu_result : mem_data;

endmodule



