/*
name: RV32I Decoder decode_unit
summary: decode opcode and rv32 type
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 22:06:33
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
module decode_unit (
// instruction_fetch
input  [31: 0] instruction,

// rv32 opcode
output         rv32_r_add,
output         rv32_r_sub,
output         rv32_r_sll,
output         rv32_r_slt,
output         rv32_r_sltu,
output         rv32_r_xor,
output         rv32_r_or,
output         rv32_r_and,
output         rv32_r_srl,
output         rv32_r_sra,
output         rv32_i_addi,
output         rv32_i_slti,
output         rv32_i_sltiu,
output         rv32_i_xori,
output         rv32_i_ori,
output         rv32_i_andi,
output         rv32_i_slli,
output         rv32_i_srli,
output         rv32_i_srai,
output         rv32_b_beq,
output         rv32_b_bne,
output         rv32_b_blt,
output         rv32_b_bge,
output         rv32_b_bltu,
output         rv32_b_bgeu,
output         rv32_j_jal,
output         rv32_i_jalr,
output         rv32_u_lui,
output         rv32_u_auipc,
output         rv32_s_sb,
output         rv32_s_sh,
output         rv32_s_sw,
output         rv32_i_lb,
output         rv32_i_lh,
output         rv32_i_lw,
output         rv32_i_lbu,
output         rv32_i_lhu,
output         rv32_i_ecall,
output         rv32_i_ebreak,
output         rv32_i_csrrw,
output         rv32_i_csrrs,
output         rv32_i_csrrc,
output         rv32_i_csrrwi,
output         rv32_i_csrrsi,
output         rv32_i_csrrci,
output         rv32_i_fence,
output         rv32_i_fence_i,
// rv32 type
output         rv32_r,
output         rv32_i,
output         rv32_b,
output         rv32_s,
output         rv32_u,
output         rv32_j,

// rv32 immediate extend
output signed [31: 0] rv32_i_imm,
output signed [31: 0] rv32_b_imm,
output signed [31: 0] rv32_s_imm,
output signed [31: 0] rv32_u_imm,
output signed [31: 0] rv32_uj_imm,

// from resiger_file
output [ 4: 0] rs1_read_index,
input  [31: 0] rs1_read_data,
output [ 4: 0] rs2_read_index,
input  [31: 0] rs2_read_data,
// register operand
output [31: 0] rv32_rd_index,
output [31: 0] rv32_rs1_data,
output [31: 0] rv32_rs2_data
);

opcode_decode opcode_decode_inst (
    .instruction ( instruction ),
    .rv32_r_add ( rv32_r_add ),
    .rv32_r_sub ( rv32_r_sub ),
    .rv32_r_sll ( rv32_r_sll ),
    .rv32_r_slt ( rv32_r_slt ),
    .rv32_r_sltu ( rv32_r_sltu ),
    .rv32_r_xor ( rv32_r_xor ),
    .rv32_r_or ( rv32_r_or ),
    .rv32_r_and ( rv32_r_and ),
    .rv32_r_srl ( rv32_r_srl ),
    .rv32_r_sra ( rv32_r_sra ),
    .rv32_i_addi ( rv32_i_addi ),
    .rv32_i_slti ( rv32_i_slti ),
    .rv32_i_sltiu ( rv32_i_sltiu ),
    .rv32_i_xori ( rv32_i_xori ),
    .rv32_i_ori ( rv32_i_ori ),
    .rv32_i_andi ( rv32_i_andi ),
    .rv32_i_slli ( rv32_i_slli ),
    .rv32_i_srli ( rv32_i_srli ),
    .rv32_i_srai ( rv32_i_srai ),
    .rv32_b_beq ( rv32_b_beq ),
    .rv32_b_bne ( rv32_b_bne ),
    .rv32_b_blt ( rv32_b_blt ),
    .rv32_b_bge ( rv32_b_bge ),
    .rv32_b_bltu ( rv32_b_bltu ),
    .rv32_b_bgeu ( rv32_b_bgeu ),
    .rv32_j_jal ( rv32_j_jal ),
    .rv32_i_jalr ( rv32_i_jalr ),
    .rv32_u_lui ( rv32_u_lui ),
    .rv32_u_auipc ( rv32_u_auipc ),
    .rv32_s_sb ( rv32_s_sb ),
    .rv32_s_sh ( rv32_s_sh ),
    .rv32_s_sw ( rv32_s_sw ),
    .rv32_i_lb ( rv32_i_lb ),
    .rv32_i_lh ( rv32_i_lh ),
    .rv32_i_lw ( rv32_i_lw ),
    .rv32_i_lbu ( rv32_i_lbu ),
    .rv32_i_lhu ( rv32_i_lhu ),
    .rv32_i_ecall ( rv32_i_ecall ),
    .rv32_i_ebreak ( rv32_i_ebreak ),
    .rv32_i_csrrw ( rv32_i_csrrw ),
    .rv32_i_csrrs ( rv32_i_csrrs ),
    .rv32_i_csrrc ( rv32_i_csrrc ),
    .rv32_i_csrrwi ( rv32_i_csrrwi ),
    .rv32_i_csrrsi ( rv32_i_csrrsi ),
    .rv32_i_csrrci ( rv32_i_csrrci ),
    .rv32_i_fence ( rv32_i_fence ),
    .rv32_i_fence_i ( rv32_i_fence_i ),
    .rv32_r ( rv32_r ),
    .rv32_i ( rv32_i ),
    .rv32_b ( rv32_b ),
    .rv32_s ( rv32_s ),
    .rv32_u ( rv32_u ),
    .rv32_j ( rv32_j )
);

operand_immediate_decode operand_immediate_decode_inst (
    .instruction ( instruction ),
    .rv32_i_imm ( rv32_i_imm ),
    .rv32_s_imm ( rv32_s_imm ),
    .rv32_u_imm ( rv32_u_imm ),
    .rv32_uj_imm ( rv32_uj_imm ),
    .rv32_b_imm ( rv32_b_imm )
);

operand_register_decode operand_register_decode_inst (
    .instruction ( instruction ),
    .rs1_read_index ( rs1_read_index ),
    .rs1_read_data ( rs1_read_data ),
    .rs2_read_index ( rs2_read_index ),
    .rs2_read_data ( rs2_read_data ),
    .rv32_rd_index ( rv32_rd_index ),
    .rv32_rs1_data ( rv32_rs1_data ),
    .rv32_rs2_data ( rv32_rs2_data )
);

endmodule // decode_unit
