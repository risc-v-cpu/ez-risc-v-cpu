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
`include "../../defines.sv"
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

input  [31: 0] operand_1,
input  [31: 0] operand_2,
input  [31: 0] operand_3,

input  [31: 0] pc,
output [31: 0] pc_next
);

wire pc_target = rv32_j_jal ? (pc + operand_1) : (
    rv32_i_jalr ? ((operand_1 + operand_2) & (~32'b1)) : 
    operand_3
);

wire compare_result;
wire compare_with_signed = rv32_b_beq | rv32_b_bne | rv32_b_blt | rv32_b_bge;

wire data1 = rv32_b_blt ? operand_2 : operand_1;
wire data2 = rv32_b_bge ? operand_1 : operand_2;
compare_gt compare_gt_inst (
    .data1 ( data1 ),
    .data2 ( data2 ),
    .is_signed ( compare_with_signed ),
    .result ( compare_result )
);

wire branch_condition = 
(rv32_j_jal) || 
(rv32_i_jalr) || 
(rv32_b_beq && operand_1 == operand_2) || 
(rv32_b_bne && operand_1 != operand_2) || 
((rv32_b_blt | rv32_b_bge | rv32_b_bltu | rv32_b_bgeu) && compare_result)
;

assign pc_next = branch_condition ? pc_target : (pc + 32'h4);

endmodule // branch_unit
