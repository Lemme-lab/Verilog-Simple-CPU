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
    wire alu_sub, mem_write, reg_write_enable;
    wire [3:0] reg_write_addr, reg_read_addr1, reg_read_addr2;

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
        .reg_write_enable(reg_write_enable)
    );

    RegisterFile reg_file (
        .clk(clk),
        .reg_write_addr(reg_write_addr),
        .reg_write_data(alu_result),
        .reg_write_enable(reg_write_enable),
        .reg_read_addr1(reg_read_addr1),
        .reg_read_addr2(reg_read_addr2),
        .reg_data1(reg_data1),
        .reg_data2(reg_data2)
    );

    ALU_16Bit alu (
        .a(reg_data1),
        .b(reg_data2),
        .sub(alu_sub),
        .op_select(op_select),
        .result(alu_result)
    );

    DataMemory data_mem (
        .clk(clk),
        .address(reg_data1),
        .write_data(reg_data2),
        .mem_write(mem_write),
        .read_data(mem_data)
    );

    assign output_reg = mem_data; // Output the data from memory or ALU result

endmodule
