/*
name: RISC-V CPU Execute Unit
summary: select operand then execute rv32 instruction by alu or branch_unit
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 23:03:50
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
`timescale 1ns/1ns
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"
module execute_unit_tb (
);


// from decode_unit
reg  rv32_r_add = 0;
reg  rv32_r_sub = 0;
reg  rv32_r_sll = 0;
reg  rv32_r_slt = 0;
reg  rv32_r_sltu = 0;
reg  rv32_r_xor = 0;
reg  rv32_r_or = 0;
reg  rv32_r_and = 0;
reg  rv32_r_srl = 0;
reg  rv32_r_sra = 0;

reg  rv32_i_addi = 0;
reg  rv32_i_slti = 0;
reg  rv32_i_sltiu = 0;
reg  rv32_i_xori = 0;
reg  rv32_i_ori = 0;
reg  rv32_i_andi = 0;
reg  rv32_i_slli = 0;
reg  rv32_i_srli = 0;
reg  rv32_i_srai = 0;

reg  rv32_b_beq = 0;
reg  rv32_b_bne = 0;
reg  rv32_b_blt = 0;
reg  rv32_b_bge = 0;
reg  rv32_b_bltu = 0;
reg  rv32_b_bgeu = 0;

reg  rv32_j_jal = 0;
reg  rv32_i_jalr = 0;

reg  rv32_u_lui = 0;
reg  rv32_u_auipc = 0;

reg  rv32_s_sb = 0;
reg  rv32_s_sh = 0;
reg  rv32_s_sw = 0;

reg  rv32_i_lb = 0;
reg  rv32_i_lh = 0;
reg  rv32_i_lw = 0;
reg  rv32_i_lbu = 0;
reg  rv32_i_lhu = 0;

reg  rv32_i_ecall = 0;
reg  rv32_i_ebreak = 0;
reg  rv32_i_csrrw = 0;
reg  rv32_i_csrrs = 0;
reg  rv32_i_csrrc = 0;
reg  rv32_i_csrrwi = 0;
reg  rv32_i_csrrsi = 0;
reg  rv32_i_csrrci = 0;

reg  rv32_i_fence = 0;
reg  rv32_i_fence_i = 0;

// rv32 type
reg rv32_r = 0;
reg rv32_i = 0;
reg rv32_s = 0;
reg rv32_u = 0;
reg rv32_j = 0;
reg rv32_b = 0;

// rv32 immediate extend
reg [`X_LENGTH-1: 0] rv32_i_imm = 32;
reg [`X_LENGTH-1: 0] rv32_s_imm = 32;
reg [`X_LENGTH-1: 0] rv32_u_imm = 32;
reg [`X_LENGTH-1: 0] rv32_uj_imm = 32;
reg [`X_LENGTH-1: 0] rv32_b_imm = 32;

// register operand
reg [`X_LENGTH-1: 0] rv32_rd_data = 0;
reg [`X_LENGTH-1: 0] rv32_rs1_data = 0;
reg [`X_LENGTH-1: 0] rv32_rs2_data = 0;

reg [`X_LENGTH-1: 0] pc_read_data = 0;
// memory controller bus
reg [`MEMORY_WIDTH-1: 0] memory_read_data = 0;

initial begin
    rv32_rs1_data <= 16;
    rv32_rs2_data <= 16;
    
    #1;
    rv32_r <= 1;
    rv32_r_add <= 1;
    #1;
    rv32_r <= 0;
    rv32_r_add <= 0;
    rv32_i <= 1;
    rv32_i_addi <= 1;
    #1;
    rv32_i_addi <= 0;
    rv32_i_andi <= 1;
    #1;
    rv32_i <= 0;
    rv32_i_andi <= 0;
    rv32_r <= 1;
    rv32_r_or <= 1;
    #1;
    rv32_r_or <= 0;
    rv32_r <= 0;
    rv32_i <= 1;
    rv32_i_ori <= 1;

    $stop();
end

execute_unit execute_unit_inst (
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
    .rv32_s ( rv32_s ),
    .rv32_u ( rv32_u ),
    .rv32_j ( rv32_j ),
    .rv32_b ( rv32_b ),

    .rv32_rd_data ( rv32_rd_data ),
    .rv32_rs1_data ( rv32_rs1_data ),
    .rv32_rs2_data ( rv32_rs2_data ),
    .pc_read_data ( pc_read_data ),
    .memory_read_data ( memory_read_data )
);

endmodule // execute_unit_tb
