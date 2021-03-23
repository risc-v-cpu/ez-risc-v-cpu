/*
name: RISC-V CPU Execute Unit
summary: memory read and write
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-22 18:43:38
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
`include "../../defines.sv"
module memory_unit (
// from decode_unit
input          rv32_s_sb,
input          rv32_s_sh,
input          rv32_s_sw,

input          rv32_i_lb,
input          rv32_i_lh,
input          rv32_i_lw,
input          rv32_i_lbu,
input          rv32_i_lhu,
// rv32 type
input  rv32_s,
output is_rv_store_and_load,
// operand
input  signed [31: 0] operand_1,
input  signed [31: 0] operand_2,
input  signed [31: 0] operand_3,
// memory controller bus
output [`MEMORY_DEPTH-1: 0] memory_read_address,
input  [`MEMORY_WIDTH-1: 0] memory_read_data,

output [ 1: 0]              memory_write_width,
output [`MEMORY_DEPTH-1: 0] memory_write_address,
output [`MEMORY_WIDTH-1: 0] memory_write_data,
output                      memory_write_enable,

output [`MEMORY_DEPTH-1: 0] result
);

wire is_rv_store = rv32_s;
wire is_rv_load_signed = rv32_i_lb | rv32_i_lh | rv32_i_lw;
wire is_rv_load_unsigned = rv32_i_lbu | rv32_i_lhu;
wire is_rv_load  = is_rv_load_signed | is_rv_load_unsigned;
assign is_rv_store_and_load = is_rv_store && is_rv_load;

wire is_b = rv32_s_sb | rv32_i_lb;
wire is_h = rv32_s_sh | rv32_i_lh;
wire is_w = rv32_s_sw | rv32_i_lw;

assign memory_write_width = is_b ? 2'h1 : is_h ? 2'h2 : is_h ? 2'h3 : 2'h0;
assign memory_write_address = operand_1 + operand_3;
assign memory_write_data = operand_2;
assign memory_write_enable  = is_rv_store;

assign memory_read_address = operand_1 + operand_2;
assign result = 
is_b ? memory_read_data[ 7: 0] : 
is_h ? memory_read_data[15: 0] : 
is_w ? memory_read_data[31: 0] : 
32'h0;

endmodule // memory_unit
