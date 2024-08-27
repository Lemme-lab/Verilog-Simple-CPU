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

    // Initialize registers with some values
    initial begin
        registers[0]  = 16'h0000;
        registers[1]  = 16'h0001; // Register 1
        registers[2]  = 16'h0002;
        registers[3]  = 16'h0003;
        registers[4]  = 16'h0004;
        registers[5]  = 16'h0005;
        registers[6]  = 16'h0006;
        registers[7]  = 16'h0007;
        registers[8]  = 16'h0008;
        registers[9]  = 16'h0009; // Register 9
        registers[10] = 16'h000A;
        registers[11] = 16'h000B; // Register 11
        registers[12] = 16'h000C;
        registers[13] = 16'h000D;
        registers[14] = 16'h000E;
        registers[15] = 16'h000F;
    end

    always @(posedge clk) begin
        if (reg_write_enable) begin
            registers[reg_write_addr] <= reg_write_data;
        end
    end

    assign reg_data1 = registers[reg_read_addr1];  // Output data for reg_read_addr1
    assign reg_data2 = registers[reg_read_addr2];  // Output data for reg_read_addr2
endmodule

