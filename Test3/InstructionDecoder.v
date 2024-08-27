module InstructionDecoder (
    input [15:0] instruction,
    output reg [2:0] op_select,
    output reg [3:0] reg_write_addr,
    output reg [3:0] reg_read_addr1,
    output reg [3:0] reg_read_addr2,
    output reg mem_write,
    output reg reg_write_enable
);
    always @(*) begin
        // Example decoding (adjust based on your instruction set)
        op_select = instruction[15:13]; // Operation code
        reg_write_addr = instruction[12:9];
        reg_read_addr1 = instruction[8:5];
        reg_read_addr2 = instruction[4:1];
        mem_write = instruction[0]; // Write enable bit
        reg_write_enable = instruction[0]; // Example; this might vary
    end
endmodule
