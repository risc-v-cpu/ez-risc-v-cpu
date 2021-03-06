/*
name: RISC-V CPU Execute Unit
summary: select branch then update pc register
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-22 19:17:52
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"
//`include "../../defines.sv"
module branch_unit (

input  rv32_j_jal,
input  rv32_i_jalr,
input  rv32_b_beq,
input  rv32_b_bne,
input  rv32_b_blt,
input  rv32_b_bge,
input  rv32_b_bltu,
input  rv32_b_bgeu,

input  rv32_b,

input  signed [`X_LENGTH-1: 0] operand_1,
input  signed [`X_LENGTH-1: 0] operand_2,
input  signed [`X_LENGTH-1: 0] operand_3,

input  signed [`X_LENGTH-1: 0] pc,
output signed [`X_LENGTH-1: 0] pc_next
);

wire [`X_LENGTH-1: 0] pc_target = 
rv32_j_jal ? (pc + operand_1) : 
rv32_i_jalr ? ((operand_1 + operand_2) & (~32'b1)) : 
pc + operand_3
;

wire compare_result;
wire compare_with_signed = rv32_b_beq | rv32_b_bne | rv32_b_blt | rv32_b_bge;

wire data1 = (rv32_b_blt | rv32_b_bltu) ? operand_2 : operand_1;
wire data2 = (rv32_b_bge | rv32_b_bgeu) ? operand_1 : operand_2;
compare_gt compare_gt_inst (
    .data1 ( data1 ),
    .data2 ( data2 ),
    .is_signed ( compare_with_signed ),
    .result ( compare_result )
);

wire branch_condition = 
(rv32_j_jal) |
(rv32_i_jalr) |
(rv32_b_beq & operand_1 == operand_2) |
(rv32_b_bne & operand_1 != operand_2) |
((rv32_b_blt | rv32_b_bltu) && compare_result) |
((rv32_b_bge | rv32_b_bgeu) && (compare_result | (data1 == data2))) |
0;

assign pc_next = branch_condition ? pc_target : (pc + 32'h4);

endmodule // branch_unit
