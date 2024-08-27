`timescale 1ns / 1ps

module Datapath_Unit(
    input clk,
    input jump, beq, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write, bne,
    input [1:0] alu_op,
    output [3:0] opcode
);
    reg [15:0] pc_current;
    wire [15:0] pc_next, pc2;
    wire [15:0] instr;
    wire [2:0] reg_write_dest;
    wire [15:0] reg_write_data;
    wire [2:0] reg_read_addr_1;
    wire [15:0] reg_read_data_1;
    wire [2:0] reg_read_addr_2;
    wire [15:0] reg_read_data_2;
    wire [15:0] ext_im, read_data2;
    wire [2:0] ALU_Control;
    wire [15:0] ALU_out;
    wire zero_flag;
    wire [15:0] PC_j, PC_beq, PC_2beq, PC_2bne, PC_bne;
    wire beq_control;
    wire [12:0] jump_shift;
    wire [15:0] mem_read_data;

    // PC
    initial begin
        pc_current <= 16'd0;
    end

    always @(posedge clk) begin 
        pc_current <= pc_next;
    end

    assign pc2 = pc_current + 16'd2;

    // Instruction Memory
    Instruction_Memory im(.pc(pc_current), .instruction(instr));

    // Jump shift left 2
    assign jump_shift = {instr[11:0], 1'b0};

    // Multiplexer regdest
    assign reg_write_dest = (reg_dst == 1'b1) ? instr[5:3] : instr[8:6];

    // Register File
    assign reg_read_addr_1 = instr[11:9];
    assign reg_read_addr_2 = instr[8:6];

    // GENERAL PURPOSE REGISTERs
    GPRs reg_file (
        .clk(clk),
        .reg_write_en(reg_write),
        .reg_write_dest(reg_write_dest),
        .reg_write_data(reg_write_data),
        .reg_read_addr_1(reg_read_addr_1),
        .reg_read_data_1(reg_read_data_1),
        .reg_read_addr_2(reg_read_addr_2),
        .reg_read_data_2(reg_read_data_2)
    );

    // Immediate extend
    assign ext_im = {{10{instr[5]}}, instr[5:0]};  

    // ALU Control Unit
    alu_control ALU_Control_unit(.ALUOp(alu_op), .Opcode(instr[15:12]), .ALU_Cnt(ALU_Control));

    // Multiplexer alu_src
    assign read_data2 = (alu_src == 1'b1) ? ext_im : reg_read_data_2;

    // ALU Instantiation
    ALU_16Bit alu_unit(
        .a(reg_read_data_1),
        .b(read_data2),
        .sub(ALU_Control[0]),  
        .op_select(ALU_Control),
        .result(ALU_out),
        .cout(),
        .overflow(),
        .NO(),
        .ZO()
    );

    // PC beq add
    assign PC_beq = pc2 + {ext_im[14:0], 1'b0};
    assign PC_bne = pc2 + {ext_im[14:0], 1'b0};

    // beq control
    assign beq_control = beq & ALU_out;
    assign bne_control = bne & (~ALU_out);

    // PC_beq
    assign PC_2beq = (beq_control == 1'b1) ? PC_beq : pc2;

    // PC_bne
    assign PC_2bne = (bne_control == 1'b1) ? PC_bne : PC_2beq;

    // PC_j
    assign PC_j = {pc2[15:13], jump_shift};

    // PC_next
    assign pc_next = (jump == 1'b1) ? PC_j : PC_2bne;

    // Data memory
    Data_Memory dm (
        .clk(clk),
        .mem_access_addr(ALU_out),
        .mem_write_data(reg_read_data_2),
        .mem_write_en(mem_write),
        .mem_read(mem_read),
        .mem_read_data(mem_read_data)
    );

    // Write back
    assign reg_write_data = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;

    // Output to control unit
    assign opcode = instr[15:12];
endmodule
