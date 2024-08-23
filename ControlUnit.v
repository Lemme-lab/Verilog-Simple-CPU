module ControlUnit (
    input [15:0] command,
    input [15:0] number,
    input [15:0] address,
    input clk,
    input rst,
    output reg write_enable,
    output reg [2:0] op_select,
    output reg sub,
    output reg [15:0] data_in,
    output reg [15:0] addr,
    input [15:0] alu_result,
    input [15:0] mem_data_out,  // Receive memory data for load operations
    output reg [15:0] data_out
);
    reg [1:0] state, next_state;
    parameter IDLE = 2'b00, LOAD = 2'b01, COMPUTE = 2'b10, SAVE = 2'b11;

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State next logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (command[15:12] == 4'b0010) // STORE command
                    next_state = SAVE;
                else if (command[15:12] == 4'b0011) // LOAD command
                    next_state = LOAD;
                else if (command[15:12] == 4'b0100) // COMPUTE command
                    next_state = COMPUTE;
                else
                    next_state = IDLE;
            end
            LOAD: next_state = COMPUTE; // Move to COMPUTE after LOAD
            COMPUTE: next_state = SAVE;
            SAVE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            IDLE: begin
                write_enable = 1'b0;
                data_in = 16'b0;
                addr = 16'b0;
                op_select = 3'b000;
                sub = 1'b0;
            end
            LOAD: begin
                write_enable = 1'b0;
                addr = address; // Load from the given address
                data_in = 16'b0;
                data_out = mem_data_out; // Load the value from memory
            end
            COMPUTE: begin
                write_enable = 1'b0;
                addr = 16'b0;
                op_select = command[2:0]; // Extract ALU operation from command
                sub = command[3]; // Extract subtraction flag from command
                data_out = 16'b0; // Not used in COMPUTE
            end
            SAVE: begin
                write_enable = 1'b1;
                data_in = alu_result; // Save the result into memory
                addr = address;
                data_out = 16'b0; // Not used in SAVE
            end
        endcase
    end
endmodule
