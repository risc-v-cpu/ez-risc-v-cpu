/*
name: RISC-V CPU Execute Unit
summary: Arithmetic Logical Unit
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-22 19:18:34
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module alu (
input operation_add,
input operation_subtract,
input operation_and,
input operation_or,
input operation_xor,
input operation_shift_left_logical,
input operation_shift_right_arithmetic,
input operation_shift_right_logical,

input  signed [`X_LENGTH-1: 0] operand_1,
input  signed [`X_LENGTH-1: 0] operand_2,
output signed [`X_LENGTH-1: 0] result
);

assign result = operation_add ? (
operand_1 + operand_2
) : operation_subtract ? (
operand_1 - operand_2
// ) : operation_arithmetic_multiply ? (
// operand_1 * operand_2
// ) : operation_arithmetic_divide ? (
// operand_1 / operand_2
// ) : operation_arithmetic_modulo ? (
// operand_1 % operand_2
) : operation_and ? (
operand_1 & operand_2
) : operation_or ? (
operand_1 | operand_2
// ) : operation_logical_not ? (
// ~operand_1
) : operation_xor ? (
operand_1 ^ operand_2
) : operation_shift_left_logical ? (
operand_1 << operand_2
) : operation_shift_right_arithmetic ? (
operand_1 >>> operand_2
) : operation_shift_right_logical ? (
operand_1 >> operand_2
) : 0;

endmodule // alu
