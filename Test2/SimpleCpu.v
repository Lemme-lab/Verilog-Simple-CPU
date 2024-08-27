`include "ALU_16Bit.v"
`include "Control.v"  
`include "RF.v" 
`include "opcodes.v"    // Ensure this file contains correct macro definitions

module cpu (
    output reg readM,
    output reg writeM,
    output reg [`WORD_SIZE-1:0] address,
    output reg [`WORD_SIZE-1:0] data_out,
    input [`WORD_SIZE-1:0] data_in,
    input inputReady,
    input reset_n,
    input clk,
    output reg [`WORD_SIZE-1:0] num_inst,
    output reg [`WORD_SIZE-1:0] output_port
);

    // Internal signals
    reg [`WORD_SIZE-1:0] PC, nextPC;
    reg [`WORD_SIZE-1:0] instruction, data_reg;

    // Control signals
    wire RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, OpenPort;
    wire [3:0] ALUOp;

    // ALU control signal (3 bits expected by ALU_16Bit)
    wire [2:0] ALUOp_3bit;

    // RF (Register File) related signals
    wire [`WORD_SIZE-1:0] ReadData1, ReadData2;

    // ALU related signals
    wire bcond;
    wire [`WORD_SIZE-1:0] ALUResult;

    // Instantiate Control Unit
    Control control(
        .opcode(instruction[15:12]),
        .func(instruction[5:0]),
        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .OpenPort(OpenPort)
    );

    // Instantiate Register File
    RF rf(
        .write(RegWrite),
        .clk(clk),
        .reset_n(reset_n),
        .addr1(instruction[11:10]),
        .addr2(instruction[9:8]),
        .addr3(RegDst ? instruction[7:6] : instruction[9:8]),
        .data1(ReadData1),
        .data2(ReadData2),
        .data3(MemtoReg ? data_reg : ALUResult)
    );

    // Instantiate ALU
    ALU_16Bit alu(
        .a(ReadData1),
        .b(ALUSrc ? {{8{instruction[7]}}, instruction[7:0]} : ReadData2),
        .sub(1'b0),
        .op_select(ALUOp_3bit), // Provide 3-bit ALUOp signal
        .result(ALUResult)
    );

    // Calculate nextPC
    always @(*) begin
        if (Jump)
            nextPC = {PC[15:12], instruction[11:0]};
        else if (Branch && bcond)
            nextPC = PC + {{8{instruction[7]}}, instruction[7:0]};
        else
            nextPC = PC + 1;
    end

    // Convert 4-bit ALUOp to 3-bit ALUOp_3bit
    assign ALUOp_3bit = ALUOp[2:0]; // Use only the lower 3 bits

    // Control `data_out` assignment
    always @(*) begin
        if (writeM)
            data_out = data_reg;
        else
            data_out = `WORD_SIZE'bz;
    end

    // Control read and write operations
    always @(*) begin
        address = PC;
        readM = 1;
        writeM = 0;
    end

    always @(posedge inputReady) begin
        if (readM) begin
            instruction <= data_in;
            readM <= 0;
        end else begin
            data_reg <= data_in;
            readM <= 0;
            writeM <= 1;
        end
    end

    // Sequential logic for updating PC and num_inst
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            PC <= 0;
            num_inst <= 0;
        end else begin
            PC <= nextPC;
            num_inst <= num_inst + 1;
        end
    end

    // Output port management
    always @(*) begin
        if (OpenPort)
            output_port = ReadData1;
        else
            output_port = `WORD_SIZE'bz;
    end

endmodule
