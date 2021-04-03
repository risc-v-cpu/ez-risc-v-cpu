/*
name: RISC-V CPU rv32 write_back_unit
summary: write back reuslt data to register file
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-22 19:55:45
================================================================================
Refer to riscv-spec-v2.2.pdf (page 10)
Chapter 2 RV32I Base Integer Instruction Set, Version 2.0
2.1 Programmers' Model for Base Integer Subset
*/
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module write_back (
// write_back unit
input  [`REGISTER_WIDTH-1: 0] rd_index,
input  [`X_LENGTH-1: 0] result,
input  [`X_LENGTH-1: 0] pc_next,
input          need_write_rd,

output [`REGISTER_WIDTH-1: 0] rd_write_index,
output [`X_LENGTH-1: 0] rd_write_data,
output         rd_write_enable,

output [`X_LENGTH-1: 0] pc_write_data,
output         pc_write_enable
);

assign rd_write_index = rd_index;
assign rd_write_data = result;
assign rd_write_enable = need_write_rd;

assign pc_write_data = pc_next;
assign pc_write_enable = 1;

endmodule // write_back
