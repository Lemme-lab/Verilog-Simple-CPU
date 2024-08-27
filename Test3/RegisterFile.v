module RegisterFile (
    input clk,
    input [3:0] reg_write_addr,
    input [15:0] reg_write_data,
    input reg_write_enable,
    input [3:0] reg_read_addr1,
    input [3:0] reg_read_addr2,
    output [15:0] reg_data1,
    output [15:0] reg_data2
);
    reg [15:0] registers [15:0]; // 16 registers, each 16-bit

    always @(posedge clk) begin
        if (reg_write_enable) begin
            registers[reg_write_addr] <= reg_write_data;
        end
    end

    assign reg_data1 = registers[reg_read_addr1];
    assign reg_data2 = registers[reg_read_addr2];
endmodule
