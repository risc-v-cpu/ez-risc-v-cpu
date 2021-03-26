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
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module execute_unit (
// from decode_unit
input  rv32_r_add,
input  rv32_r_sub,
input  rv32_r_sll,
input  rv32_r_slt,
input  rv32_r_sltu,
input  rv32_r_xor,
input  rv32_r_or,
input  rv32_r_and,
input  rv32_r_srl,
input  rv32_r_sra,

input  rv32_i_addi,
input  rv32_i_slti,
input  rv32_i_sltiu,
input  rv32_i_xori,
input  rv32_i_ori,
input  rv32_i_andi,
input  rv32_i_slli,
input  rv32_i_srli,
input  rv32_i_srai,

input  rv32_b_beq,
input  rv32_b_bne,
input  rv32_b_blt,
input  rv32_b_bge,
input  rv32_b_bltu,
input  rv32_b_bgeu,

input  rv32_j_jal,
input  rv32_i_jalr,

input  rv32_u_lui,
input  rv32_u_auipc,

input  rv32_s_sb,
input  rv32_s_sh,
input  rv32_s_sw,

input  rv32_i_lb,
input  rv32_i_lh,
input  rv32_i_lw,
input  rv32_i_lbu,
input  rv32_i_lhu,

input  rv32_i_ecall,
input  rv32_i_ebreak,
input  rv32_i_csrrw,
input  rv32_i_csrrs,
input  rv32_i_csrrc,
input  rv32_i_csrrwi,
input  rv32_i_csrrsi,
input  rv32_i_csrrci,

input  rv32_i_fence,
input  rv32_i_fence_i,

// rv32 type
input rv32_r,
input rv32_i,
input rv32_b,
input rv32_s,
input rv32_u,
input rv32_j,

// rv32 immediate extend
input  signed [31: 0] rv32_i_imm,
input  signed [31: 0] rv32_s_imm,
input  signed [31: 0] rv32_u_imm,
input  signed [31: 0] rv32_uj_imm,
input  signed [31: 0] rv32_b_imm,
// register operand
input  signed [31: 0] rv32_rd_index,
input  signed [31: 0] rv32_rs1_data,
input  signed [31: 0] rv32_rs2_data,

output        [ 4: 0] rd_index,
output signed [31: 0] result,
output                need_write_rd,

input  [31: 0] pc_read_data,
output [31: 0] pc_next,
// memory controller bus
output [`MEMORY_DEPTH-1: 0] memory_read_address,
input  [`MEMORY_WIDTH-1: 0] memory_read_data,

output [ 1: 0]              memory_write_width,
output [`MEMORY_DEPTH-1: 0] memory_write_address,
output [`MEMORY_WIDTH-1: 0] memory_write_data,
output                      memory_write_enable
);

wire signed [31: 0] operand_1 = 
(rv32_r || rv32_i || rv32_s || rv32_b) ? rv32_rs1_data : 
rv32_u ? rv32_u_imm : 
rv32_j ? rv32_uj_imm : 
32'b0;
wire signed [31: 0] operand_2 = 
(rv32_r || rv32_s || rv32_b) ? rv32_rs2_data : 
rv32_i ? rv32_i_imm :
rv32_u ? rv32_u_imm :
rv32_j ? rv32_uj_imm :
32'b0;
wire signed [31: 0] operand_3 = 
(rv32_r || rv32_i || rv32_u || rv32_j) ? rv32_rd_index : 
rv32_s ? rv32_s_imm :
rv32_b ? rv32_b_imm :
32'b0;

assign rd_index = operand_3[4:0];

wire [31:0] alu_result, memory_access_result;
wire is_rv_store_and_load;

assign result = (rv32_j_jal | rv32_i_jalr) ? (pc_read_data + 32'h4) : 
rv32_u_lui ? rv32_u_imm : 
rv32_u_auipc ? (rv32_u_imm + pc_read_data) : 
is_rv_store_and_load ? memory_access_result : 
alu_result;

assign need_write_rd = ~rv32_b & ~rv32_s;

branch_unit branch_unit_inst (
    .rv32_j_jal ( rv32_j_jal ),
    .rv32_i_jalr ( rv32_i_jalr ),
    .rv32_b_beq ( rv32_b_beq ),
    .rv32_b_bne ( rv32_b_bne ),
    .rv32_b_blt ( rv32_b_blt ),
    .rv32_b_bge ( rv32_b_bge ),
    .rv32_b_bltu ( rv32_b_bltu ),
    .rv32_b_bgeu ( rv32_b_bgeu ),

    .rv32_b ( rv32_b ),

    .operand_1 ( operand_1 ),
    .operand_2 ( operand_2 ),
    .operand_3 ( operand_3 ),
    .pc ( pc_read_data ),
    .pc_next ( pc_next )
);

wire operation_add = (rv32_r_add | rv32_i_addi);
wire operation_subtract = rv32_r_sub;
wire operation_and = (rv32_r_and | rv32_i_andi);
wire operation_or = (rv32_r_or | rv32_i_ori);
wire operation_xor = (rv32_r_xor | rv32_i_xori);
wire operation_shift_left_logical = (rv32_r_sll | rv32_i_slli);
wire operation_shift_right_arithmetic = (rv32_r_sra | rv32_i_srai);
wire operation_shift_right_logical = (rv32_r_srl | rv32_i_srli);
alu alu_inst(
    .operation_add ( operation_add ),
    .operation_subtract ( operation_subtract ),
    .operation_and ( operation_and ),
    .operation_or ( operation_or ),
    .operation_xor ( operation_xor ),
    .operation_shift_left_logical ( operation_shift_left_logical ),
    .operation_shift_right_arithmetic ( operation_shift_right_arithmetic ),
    .operation_shift_right_logical ( operation_shift_right_logical ),

    .operand_1 ( operand_1 ),
    .operand_2 ( operand_2 ),
    .reuslt ( alu_result )
);

memory_unit memory_unit_inst (
    .rv32_s_sb ( rv32_s_sb ),
    .rv32_s_sh ( rv32_s_sh ),
    .rv32_s_sw ( rv32_s_sw ),
    .rv32_i_lb ( rv32_i_lb ),
    .rv32_i_lh ( rv32_i_lh ),
    .rv32_i_lw ( rv32_i_lw ),
    .rv32_i_lbu ( rv32_i_lbu ),
    .rv32_i_lhu ( rv32_i_lhu ),

    .rv32_s ( rv32_s ),
    .is_rv_store_and_load ( is_rv_store_and_load ),

    .operand_1 ( operand_1 ),
    .operand_2 ( operand_2 ),
    .operand_3 ( operand_3 ),

    .memory_read_address ( memory_read_address ),
    .memory_read_data ( memory_read_data ),

    .memory_write_width ( memory_write_width ),
    .memory_write_address ( memory_write_address ),
    .memory_write_data ( memory_write_data ),
    .memory_write_enable ( memory_write_enable ),

    .result ( memory_access_result )
);


endmodule
