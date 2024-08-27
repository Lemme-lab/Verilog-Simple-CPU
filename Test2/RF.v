`define WORD_SIZE 16

module RF(
    input write,
    input clk,
    input reset_n,
    input [1:0] addr1,
    input [1:0] addr2,
    input [1:0] addr3,
    output [`WORD_SIZE-1:0] data1,
    output [`WORD_SIZE-1:0] data2,
    input [`WORD_SIZE-1:0] data3
);

    reg [`WORD_SIZE*4-1:0] register;  // 4 registers of 16-bit each
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            register <= 0;
        else if (write)
            register[addr3*`WORD_SIZE +: `WORD_SIZE] <= data3;
    end
    
    assign data1 = register[addr1*`WORD_SIZE +: `WORD_SIZE];
    assign data2 = register[addr2*`WORD_SIZE +: `WORD_SIZE];
    
endmodule
