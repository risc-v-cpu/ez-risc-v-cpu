/*
name: RISC-V CPU rv32 general register
summary: rv32 general register, x0 is always zero, 
         others are latched on the rising edge of the clock
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 23:14:03
================================================================================
Refer to riscv-spec-v2.2.pdf (page 10)
Chapter 2 RV32I Base Integer Instruction Set, Version 2.0
2.1 Programmers' Model for Base Integer Subset
*/
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module general_register (
input  [`REGISTER_WIDTH-1: 0] rs1_read_index,
output [`X_LENGTH-1: 0] rs1_read_data,

input  [`REGISTER_WIDTH-1: 0] rs2_read_index,
output [`X_LENGTH-1: 0] rs2_read_data,

input  [`REGISTER_WIDTH-1: 0] rd_write_index,
input  [`X_LENGTH-1: 0] rd_write_data,
input  rd_write_enable,

output [`X_LENGTH-1: 0] pc_read_data,
input  [`X_LENGTH-1: 0] pc_write_data,
input  pc_write_enable,

// debug
// output [`X_LENGTH-1: 0] debug_x0,
// output [`X_LENGTH-1: 0] debug_x1,
// output [`X_LENGTH-1: 0] debug_x2,
// output [`X_LENGTH-1: 0] debug_x3,
// output [`X_LENGTH-1: 0] debug_x4,
// output [`X_LENGTH-1: 0] debug_x5,

// common
input clk,
input rst_n
);

reg [`X_LENGTH-1:0] register_x[`REGISTER_COUNT];
reg [`X_LENGTH-1:0] register_pc;

// debug
//assign debug_x0 = register_x[0];
//assign debug_x1 = register_x[1];
//assign debug_x2 = register_x[2];
//assign debug_x3 = register_x[3];
//assign debug_x4 = register_x[4];
//assign debug_x5 = register_x[5];

assign rs1_read_data = register_x[rs1_read_index];
assign rs2_read_data = register_x[rs2_read_index];

// PC register
assign pc_read_data = register_pc;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        register_pc <= 32'h0;
    end else begin
        if (pc_write_enable) begin
            register_pc <= pc_write_data;
        end else begin
            register_pc <= register_pc;
        end
    end
end

// destination register
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
    register_x[ 0] <= `X_LENGTH'h0;
    register_x[ 1] <= `X_LENGTH'h0;
    register_x[ 2] <= `X_LENGTH'h0;
    register_x[ 3] <= `X_LENGTH'h0;
    register_x[ 4] <= `X_LENGTH'h0;
    register_x[ 5] <= `X_LENGTH'h0;
    register_x[ 6] <= `X_LENGTH'h0;
    register_x[ 7] <= `X_LENGTH'h0;
    register_x[ 8] <= `X_LENGTH'h0;
    register_x[ 9] <= `X_LENGTH'h0;
    register_x[10] <= `X_LENGTH'h0;
    register_x[11] <= `X_LENGTH'h0;
    register_x[12] <= `X_LENGTH'h0;
    register_x[13] <= `X_LENGTH'h0;
    register_x[14] <= `X_LENGTH'h0;
    register_x[15] <= `X_LENGTH'h0;
    register_x[16] <= `X_LENGTH'h0;
    register_x[17] <= `X_LENGTH'h0;
    register_x[18] <= `X_LENGTH'h0;
    register_x[19] <= `X_LENGTH'h0;
    register_x[20] <= `X_LENGTH'h0;
    register_x[21] <= `X_LENGTH'h0;
    register_x[22] <= `X_LENGTH'h0;
    register_x[23] <= `X_LENGTH'h0;
    register_x[24] <= `X_LENGTH'h0;
    register_x[25] <= `X_LENGTH'h0;
    register_x[26] <= `X_LENGTH'h0;
    register_x[27] <= `X_LENGTH'h0;
    register_x[28] <= `X_LENGTH'h0;
    register_x[29] <= `X_LENGTH'h0;
    register_x[30] <= `X_LENGTH'h0;
    register_x[31] <= `X_LENGTH'h0;
        // register_x <= {
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0,
        //     32'h0
        // };
    end else begin
        if (rd_write_enable) begin
            if (rd_write_index == 0) begin
                // pass
            end else begin
                register_x[rd_write_index] <= rd_write_data;
            end
        end else begin
            // pass
        end
    end
end

endmodule // general_register
