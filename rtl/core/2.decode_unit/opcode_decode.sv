/*
name: RV32I Decoder opcode_decode
summary: decode opcode and rv32 type
author: cw1997 [867597730@qq.com]
repo: https://github.com/risc-v-cpu/ez-risc-v-cpu
datetime: 2021-03-20 17:34:59
================================================================================
Refer to riscv-spec-v2.2.pdf (page 104)
Chapter 19 RV32/64G Instruction Set Listings
*/
module opcode_decode (
// instruction_fetch
input  [31: 0] instruction,
// rv32 immediate raw
// input  [11: 0] rv32_i_imm_11_0,
// input  [11: 0] rv32_s_imm_11_0,
// input  [31:12] rv32_u_imm_31_12,
// input  [20: 1] rv32_uj_imm_20_1,
// input  [12: 1] rv32_b_imm_12_1,
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
output         rv32_s,
output         rv32_u,
output         rv32_j,
output         rv32_b,
);

wire [31: 0] rv32_instruction = instruction;

wire [ 6: 0] rv32_opcode = rv32_instruction[ 6: 0];
wire [ 2: 0] rv32_funct3 = rv32_instruction[14:12];
wire [ 6: 0] rv32_funct7 = rv32_instruction[31:25];

wire         rv32_rd_00000 = (rv32_rd == 5'b00000);

// rv_opcode_bit_width
// Refer to the riscv-spec-v2.2.pdf (page 5) -> 1.2 rv32_instruction Length Encoding.
wire [1:0] rv_opcode_1_0_xx = rv32_opcode[1:0]; 
wire rv_opcode_1_0_00 = (rv_opcode_1_0_xx == 2'b00);
wire rv_opcode_1_0_01 = (rv_opcode_1_0_xx == 2'b01);
wire rv_opcode_1_0_10 = (rv_opcode_1_0_xx == 2'b10);
wire rv_opcode_1_0_11 = (rv_opcode_1_0_xx == 2'b11);

// rv32_opcode
wire [5:0] rv32_opcode_6_2_xxxxx = rv32_opcode[6:2];
// R
wire rv32_opcode_6_2_01100 = (rv32_opcode_6_2_xxxxx == 5'b01100);
// I
wire rv32_opcode_6_2_00100 = (rv32_opcode_6_2_xxxxx == 5'b00100);
// B
wire rv32_opcode_6_2_11000 = (rv32_opcode_6_2_xxxxx == 5'b11000);
// J jal
wire rv32_opcode_6_2_11011 = (rv32_opcode_6_2_xxxxx == 5'b11011);
// U lui
wire rv32_opcode_6_2_01101 = (rv32_opcode_6_2_xxxxx == 5'b01101);
// U auipc
wire rv32_opcode_6_2_00101 = (rv32_opcode_6_2_xxxxx == 5'b00101);
// I jalr
wire rv32_opcode_6_2_11001 = (rv32_opcode_6_2_xxxxx == 5'b11001);
// S store
wire rv32_opcode_6_2_01000 = (rv32_opcode_6_2_xxxxx == 5'b01000);
// I load
wire rv32_opcode_6_2_00000 = (rv32_opcode_6_2_xxxxx == 5'b00000);
// I csr and exception
wire rv32_opcode_6_2_11100 = (rv32_opcode_6_2_xxxxx == 5'b11100);
// I fence
wire rv32_opcode_6_2_00011 = (rv32_opcode_6_2_xxxxx == 5'b00011);



// rv32_func3
wire rv32_funct3_000 = (rv32_funct3 == 3'b000);
wire rv32_funct3_001 = (rv32_funct3 == 3'b001);
wire rv32_funct3_010 = (rv32_funct3 == 3'b010);
wire rv32_funct3_011 = (rv32_funct3 == 3'b011);
wire rv32_funct3_100 = (rv32_funct3 == 3'b100);
wire rv32_funct3_101 = (rv32_funct3 == 3'b101);
wire rv32_funct3_110 = (rv32_funct3 == 3'b110);
wire rv32_funct3_111 = (rv32_funct3 == 3'b111);

// rv32_func7
wire rv32_funct7_0000000 = (rv32_funct7 == 7'b000_0000);
wire rv32_funct7_0100000 = (rv32_funct7 == 7'b010_0000);
wire rv32_funct7_0000001 = (rv32_funct7 == 7'b000_0001);
wire rv32_funct7_0000101 = (rv32_funct7 == 7'b000_0101);
wire rv32_funct7_0001001 = (rv32_funct7 == 7'b000_1001);
wire rv32_funct7_0001101 = (rv32_funct7 == 7'b000_1101);
wire rv32_funct7_0010101 = (rv32_funct7 == 7'b001_0101);
wire rv32_funct7_0100001 = (rv32_funct7 == 7'b010_0001);
wire rv32_funct7_0010001 = (rv32_funct7 == 7'b001_0001);
wire rv32_funct7_0101101 = (rv32_funct7 == 7'b010_1101);
wire rv32_funct7_1111111 = (rv32_funct7 == 7'b111_1111);
wire rv32_funct7_0000100 = (rv32_funct7 == 7'b000_0100);
wire rv32_funct7_0001000 = (rv32_funct7 == 7'b000_1000);
wire rv32_funct7_0001100 = (rv32_funct7 == 7'b000_1100);
wire rv32_funct7_0101100 = (rv32_funct7 == 7'b010_1100);
wire rv32_funct7_0010000 = (rv32_funct7 == 7'b001_0000);
wire rv32_funct7_0010100 = (rv32_funct7 == 7'b001_0100);
wire rv32_funct7_1100000 = (rv32_funct7 == 7'b110_0000);
wire rv32_funct7_1110000 = (rv32_funct7 == 7'b111_0000);
wire rv32_funct7_1010000 = (rv32_funct7 == 7'b101_0000);
wire rv32_funct7_1101000 = (rv32_funct7 == 7'b110_1000);
wire rv32_funct7_1111000 = (rv32_funct7 == 7'b111_1000);
wire rv32_funct7_1010001 = (rv32_funct7 == 7'b101_0001);
wire rv32_funct7_1110001 = (rv32_funct7 == 7'b111_0001);
wire rv32_funct7_1100001 = (rv32_funct7 == 7'b110_0001);
wire rv32_funct7_1101001 = (rv32_funct7 == 7'b110_1001);


// R-type decode
assign rv32_r = rv32_opcode_6_2_01100;
// rv32_r 10
assign rv32_r_add  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_000 && rv32_funct7_0000000 );
assign rv32_r_sub  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_000 && rv32_funct7_0010000 );
assign rv32_r_sll  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_001 && rv32_funct7_0000000 );
assign rv32_r_slt  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_010 && rv32_funct7_0000000 );
assign rv32_r_sltu = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_011 && rv32_funct7_0000000 );
assign rv32_r_xor  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_101 && rv32_funct7_0000000 );
assign rv32_r_or   = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_110 && rv32_funct7_0000000 );
assign rv32_r_and  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_111 && rv32_funct7_0000000 );
assign rv32_r_srl  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_100 && rv32_funct7_0000000 );
assign rv32_r_sra  = ( rv_opcode_1_0_11 && rv32_opcode_6_2_01100 && rv32_funct3_101 && rv32_funct7_0010000 );


// I-type integer calculation
assign rv32_i = rv32_opcode_6_2_00100 | rv32_opcode_6_2_11001 | rv32_opcode_6_2_00000;
// rv32_i 9
assign rv32_i_addi  = ( rv32_opcode_6_2_00100 && rv32_funct3_000 );
assign rv32_i_slti  = ( rv32_opcode_6_2_00100 && rv32_funct3_010 );
assign rv32_i_sltiu = ( rv32_opcode_6_2_00100 && rv32_funct3_011 );
assign rv32_i_xori  = ( rv32_opcode_6_2_00100 && rv32_funct3_100 );
assign rv32_i_ori   = ( rv32_opcode_6_2_00100 && rv32_funct3_110 );
assign rv32_i_andi  = ( rv32_opcode_6_2_00100 && rv32_funct3_111 );
// shamt at rs2, shamt means how many bits will be shifted.
assign rv32_i_slli  = ( rv32_opcode_6_2_00100 && rv32_funct3_001 && rv32_funct7_0000000 );
assign rv32_i_srli  = ( rv32_opcode_6_2_00100 && rv32_funct3_101 && rv32_funct7_0000000 );
assign rv32_i_srai  = ( rv32_opcode_6_2_00100 && rv32_funct3_101 && rv32_funct7_0100000 );

// B-type branch
assign rv32_b = rv32_opcode_6_2_11000;
// rv32_b 6
assign rv32_b_beq  = ( rv32_opcode_6_2_11000 && rv32_funct3_000 );
assign rv32_b_bne  = ( rv32_opcode_6_2_11000 && rv32_funct3_001 );
assign rv32_b_blt  = ( rv32_opcode_6_2_11000 && rv32_funct3_100 );
assign rv32_b_bge  = ( rv32_opcode_6_2_11000 && rv32_funct3_101 );
assign rv32_b_bltu = ( rv32_opcode_6_2_11000 && rv32_funct3_110 );
assign rv32_b_bgeu = ( rv32_opcode_6_2_11000 && rv32_funct3_111 );

// J-type jump
// rv32_j 1
assign rv32_j_jal = ( rv32_opcode_6_2_11011 );
assign rv32_j = ( rv32_j_jal );

// I-type jalr
// rv32_i i
assign rv32_i_jalr = ( rv32_opcode_6_2_11001 );

// U-type
// rv32_u 2
assign rv32_u_lui   = ( rv32_opcode_6_2_01101 );
assign rv32_u_auipc = ( rv32_opcode_6_2_00101 );
assign rv32_u = rv32_u_lui || rv32_u_auipc;

// S-type store
assign rv32_s = rv32_opcode_6_2_01000;
// rv32_s_s 3
assign rv32_s_sb = ( rv32_opcode_6_2_01000 && rv32_funct3_000 );
assign rv32_s_sh = ( rv32_opcode_6_2_01000 && rv32_funct3_001 );
assign rv32_s_sw = ( rv32_opcode_6_2_01000 && rv32_funct3_010 );

// I-type load
// rv32_i_l 5
assign rv32_i_lb  = ( rv32_opcode_6_2_00000 && rv32_funct3_000 );
assign rv32_i_lh  = ( rv32_opcode_6_2_00000 && rv32_funct3_001 );
assign rv32_i_lw  = ( rv32_opcode_6_2_00000 && rv32_funct3_010 );
assign rv32_i_lbu = ( rv32_opcode_6_2_00000 && rv32_funct3_100 );
assign rv32_i_lhu = ( rv32_opcode_6_2_00000 && rv32_funct3_101 );

// I-type csr and exception
wire [11: 0] rv32_i_imm_11_0_xxx_xxxx_xxxx = rv32_instruction[31:20];
wire rv32_i_imm_000000000000 = (rv32_i_imm_11_0_xxx_xxxx_xxxx == 12'b0000_0000_0000);
wire rv32_i_imm_000000000001 = (rv32_i_imm_11_0_xxx_xxxx_xxxx == 12'b0000_0000_0001);

// rv32_i 8
assign rv32_i_ecall  = ( rv32_opcode_6_2_11100 && rv32_funct3_000 && rv32_i_imm_000000000000 );
assign rv32_i_ebreak = ( rv32_opcode_6_2_11100 && rv32_funct3_000 && rv32_i_imm_000000000001 );
assign rv32_i_csrrw  = ( rv32_opcode_6_2_11100 && rv32_funct3_001 );
assign rv32_i_csrrs  = ( rv32_opcode_6_2_11100 && rv32_funct3_010 );
assign rv32_i_csrrc  = ( rv32_opcode_6_2_11100 && rv32_funct3_011 );
assign rv32_i_csrrwi = ( rv32_opcode_6_2_11100 && rv32_funct3_101 );
assign rv32_i_csrrsi = ( rv32_opcode_6_2_11100 && rv32_funct3_110 );
assign rv32_i_csrrci = ( rv32_opcode_6_2_11100 && rv32_funct3_111 );

// I-type fence
wire [3:0] rv32_i_imm_31_28_xxxx = rv32_instruction[31:28];
wire [3:0] rv32_i_imm_27_24_xxxx = rv32_instruction[27:24];
wire [3:0] rv32_i_imm_23_20_xxxx = rv32_instruction[23:20];

wire rv32_i_imm_31_28_0000 = (rv32_i_imm_31_28_xxxx == 4'b0000);

// rv32_i_fence 2
assign rv32_i_fence   = ( rv32_opcode_6_2_00011 && rv32_funct3_000 && rv32_rd_00000 && rv32_i_imm_31_28_0000 );
assign rv32_i_fence_i = ( rv32_opcode_6_2_00011 && rv32_funct3_001 && rv32_rd_00000 && rv32_i_imm_31_28_0000 );

// wire [3:0] rv32_i_fence_predecessor = (rv32_i_imm_27_24_xxxx);
// wire [3:0] rv32_i_fence_successor   = (rv32_i_imm_23_20_xxxx);


// assign decode_info = {
//     rv32_r_add,
//     rv32_r_sub,
//     rv32_r_sll,
//     rv32_r_slt,
//     rv32_r_sltu,
//     rv32_r_xor,
//     rv32_r_or,
//     rv32_r_and,
//     rv32_r_srl,
//     rv32_r_sra,
//     rv32_i_addi,
//     rv32_i_slti,
//     rv32_i_sltiu,
//     rv32_i_xori,
//     rv32_i_ori,
//     rv32_i_andi,
//     rv32_i_slli,
//     rv32_i_srli,
//     rv32_i_srai,
//     rv32_b_beq,
//     rv32_b_bne,
//     rv32_b_blt,
//     rv32_b_bge,
//     rv32_b_bltu,
//     rv32_b_bgeu,
//     rv32_j_jal,
//     rv32_i_jalr,
//     rv32_u_lui,
//     rv32_u_auipc,
//     rv32_s_sb,
//     rv32_s_sh,
//     rv32_s_sw,
//     rv32_i_lb,
//     rv32_i_lh,
//     rv32_i_lw,
//     rv32_i_lbu,
//     rv32_i_lhu,
//     rv32_i_ecall,
//     rv32_i_ebreak,
//     rv32_i_csrrw,
//     rv32_i_csrrs,
//     rv32_i_csrrc,
//     rv32_i_csrrwi,
//     rv32_i_csrrsi,
//     rv32_i_csrrci,
//     rv32_i_fence,
//     rv32_i_fence_i,
// }

endmodule // instruction_decode
