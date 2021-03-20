/*
name: RV32I Decoder operand_register_decode
summary: decode register index and fetch data from register
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 17:02:46
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
module operand_register_decode (
// rv32 instruction
input  [31: 0] instruction,
// from resiger_file
output [ 4: 0] rs1_read_index,
input  [31: 0] rs1_read_data,
output [ 4: 0] rs2_read_index,
input  [31: 0] rs2_read_data,
// operand
output [31: 0] rv32_rd_data,
output [31: 0] rv32_rs1_data,
output [31: 0] rv32_rs2_data
);

wire rv32_rd_index  = instruction[11: 7];
wire rv32_rs1_index = instruction[19:15];
wire rv32_rs2_index = instruction[24:20];

assign rs1_read_index = rv32_rs1_index;
assign rs2_read_index = rv32_rs2_index;

assign rv32_rs1_data = rs1_read_data;
assign rv32_rs2_data = rs2_read_data;

endmodule // operand_register_decode
