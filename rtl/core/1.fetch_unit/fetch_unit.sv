/*
name: RISC-V fetch_unit
summary: decode immediate then signed extend
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 18:09:57
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module fetch_unit (
output [`X_LENGTH-1: 0] instruction,
input  [`X_LENGTH-1: 0] pc,
// debug
output [ 4: 0] address,
// common
input clk
// input rst_n
);

wire [`X_LENGTH-1: 0] pc_shift_right_3 = (pc >>> 2);
assign address = pc_shift_right_3[4:0];

program_rom	program_rom_inst (
	.address ( address ),
	.clock ( clk ),
	// .data ( instruction ),
	.wren ( 0 ),
	.q ( instruction )
);

endmodule // fetch_unit
