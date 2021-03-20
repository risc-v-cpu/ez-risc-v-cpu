/*
name: RV32I Decoder operand_immediate_decode
summary: decode immediate then signed extend
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 17:16:46
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
module operand_immediate_decode (
// instruction_fetch
input  [31: 0] instruction,
// rv32 immediate raw
output [11: 0] rv32_i_imm_11_0,
output [11: 0] rv32_s_imm_11_0,
output [31:12] rv32_u_imm_31_12,
output [20: 1] rv32_uj_imm_20_1,
output [12: 1] rv32_b_imm_12_1,
// rv32 immediate extend
output [31: 0] rv32_i_imm,
output [31: 0] rv32_s_imm,
output [31: 0] rv32_u_imm,
output [31: 0] rv32_uj_imm,
output [31: 0] rv32_b_imm
);

// I-type
assign rv32_i_imm_11_0 = rv32_instruction[31:20];
assign rv32_i_imm = { {(31-11){rv32_i_imm_11_0[11]}}, rv32_i_imm_11_0 };

// S-type
wire [11: 7] rv32_s_imm_4_0  = rv32_instruction[11:7];
wire [31:25] rv32_s_imm_11_5 = rv32_instruction[31:25];

assign rv32_s_imm_11_0 = { rv32_s_imm_11_5, rv32_s_imm_4_0 };
assign rv32_s_imm = { {(31-11){rv32_s_imm_11_0[11]}}, rv32_s_imm_11_0 };

// U-type
assign rv32_u_imm_31_12 = rv32_instruction[31:12];
assign rv32_u_imm = { rv32_u_imm_31_12, 12'b0 };

// UJ-type
wire [31:31] rv32_uj_imm_20    = rv32_instruction[31:31];
wire [19:12] rv32_uj_imm_19_12 = rv32_instruction[19:12];
wire [20:20] rv32_uj_imm_11    = rv32_instruction[20:20];
wire [30:21] rv32_uj_imm_10_1  = rv32_instruction[30:21];
// uj is unsigned jump, so use unsigned extend
assign rv32_uj_imm_20_1  = { rv32_uj_imm_20, rv32_uj_imm_19_12, rv32_uj_imm_11, rv32_uj_imm_10_1 };
assign rv32_uj_imm = { {(31-20){1'b0}}, rv32_uj_imm_20_1, 1'b0 };

// B-type
wire [ 7: 7] rv32_b_imm_11   = rv32_instruction[ 7: 7];
wire [11: 8] rv32_b_imm_4_1  = rv32_instruction[11: 8];
wire [30:25] rv32_b_imm_10_5 = rv32_instruction[30:25];
wire [31:31] rv32_b_imm_12   = rv32_instruction[31:31];

assign rv32_b_imm_12_1 = { rv32_b_imm_12, rv32_b_imm_11, rv32_b_imm_10_5, rv32_b_imm_4_1 };
assign rv32_b_imm = { {(31-12){rv32_b_imm_12_1[12]}}, rv32_b_imm_12_1, 1'b0 };

endmodule // operand_immediate_decode
