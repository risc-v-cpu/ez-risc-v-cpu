`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module risc_v_cpu (
    
// memory_controller
output [`MEMORY_DEPTH-1: 0] memory_read_address,
input  [`MEMORY_WIDTH-1: 0] memory_read_data,

output [ 1: 0]              memory_write_width,
output [`MEMORY_DEPTH-1: 0] memory_write_address,
output [`MEMORY_WIDTH-1: 0] memory_write_data,
output                      memory_write_enable,

// common
input           clk,
input           rst_n
);

wire [ 4: 0] rs1_read_index;
wire [31: 0] rs1_read_data;

wire [ 4: 0] rs2_read_index;
wire [31: 0] rs2_read_data;

wire [ 4: 0] rd_write_index;
wire [31: 0] rd_write_data;
wire         rd_write_enable;

wire [31: 0] pc_read_data;
wire [31: 0] pc_write_data;
wire         pc_write_enable;

general_register general_register_inst (
    .rs1_read_index ( rs1_read_index ),
    .rs1_read_data ( rs1_read_data ),
    .rs2_read_index ( rs2_read_index ),
    .rs2_read_data ( rs2_read_data ),
    .rd_write_index ( rd_write_index ),
    .rd_write_data ( rd_write_data ),
    .rd_write_enable ( rd_write_enable ),
    .pc_read_data ( pc_read_data ),
    .pc_write_data ( pc_write_data ),
    .pc_write_enable ( pc_write_enable ),

    .clk ( clk ),
    .rst_n ( rst_n )
);


wire [31: 0] instruction;
fetch_unit fetch_unit_inst (
    .instruction ( instruction ),
    .pc ( pc_read_data ),

    .clk ( clk )
);

wire         rv32_r_add;
wire         rv32_r_sub;
wire         rv32_r_sll;
wire         rv32_r_slt;
wire         rv32_r_sltu;
wire         rv32_r_xor;
wire         rv32_r_or;
wire         rv32_r_and;
wire         rv32_r_srl;
wire         rv32_r_sra;
wire         rv32_i_addi;
wire         rv32_i_slti;
wire         rv32_i_sltiu;
wire         rv32_i_xori;
wire         rv32_i_ori;
wire         rv32_i_andi;
wire         rv32_i_slli;
wire         rv32_i_srli;
wire         rv32_i_srai;
wire         rv32_b_beq;
wire         rv32_b_bne;
wire         rv32_b_blt;
wire         rv32_b_bge;
wire         rv32_b_bltu;
wire         rv32_b_bgeu;
wire         rv32_j_jal;
wire         rv32_i_jalr;
wire         rv32_u_lui;
wire         rv32_u_auipc;
wire         rv32_s_sb;
wire         rv32_s_sh;
wire         rv32_s_sw;
wire         rv32_i_lb;
wire         rv32_i_lh;
wire         rv32_i_lw;
wire         rv32_i_lbu;
wire         rv32_i_lhu;
wire         rv32_i_ecall;
wire         rv32_i_ebreak;
wire         rv32_i_csrrw;
wire         rv32_i_csrrs;
wire         rv32_i_csrrc;
wire         rv32_i_csrrwi;
wire         rv32_i_csrrsi;
wire         rv32_i_csrrci;
wire         rv32_i_fence;
wire         rv32_i_fence_i;
wire         rv32_r;
wire         rv32_i;
wire         rv32_b;
wire         rv32_s;
wire         rv32_u;
wire         rv32_j;
wire signed [31: 0] rv32_i_imm;
wire signed [31: 0] rv32_b_imm;
wire signed [31: 0] rv32_s_imm;
wire signed [31: 0] rv32_u_imm;
wire signed [31: 0] rv32_uj_imm;
wire signed [31: 0] rv32_rd_index;
wire signed [31: 0] rv32_rs1_data;
wire signed [31: 0] rv32_rs2_data;
decode_unit decode_unit_inst (
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
    .rv32_j ( rv32_j ),
    .rv32_i_imm ( rv32_i_imm ),
    .rv32_b_imm ( rv32_b_imm ),
    .rv32_s_imm ( rv32_s_imm ),
    .rv32_u_imm ( rv32_u_imm ),
    .rv32_uj_imm ( rv32_uj_imm ),
    .rs1_read_index ( rs1_read_index ),
    .rs1_read_data ( rs1_read_data ),
    .rs2_read_index ( rs2_read_index ),
    .rs2_read_data ( rs2_read_data ),
    .rv32_rd_index ( rv32_rd_index ),
    .rv32_rs1_data ( rv32_rs1_data ),
    .rv32_rs2_data ( rv32_rs2_data )
);

wire [ 4: 0] rd_index;
wire signed [31: 0] result;
wire [31: 0] pc_next;
wire need_write_rd;
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
    .rv32_b ( rv32_b ),
    .rv32_s ( rv32_s ),
    .rv32_u ( rv32_u ),
    .rv32_j ( rv32_j ),
    .rv32_i_imm ( rv32_i_imm ),
    .rv32_s_imm ( rv32_s_imm ),
    .rv32_u_imm ( rv32_u_imm ),
    .rv32_uj_imm ( rv32_uj_imm ),
    .rv32_b_imm ( rv32_b_imm ),
    .rv32_rd_index ( rv32_rd_index ),
    .rv32_rs1_data ( rv32_rs1_data ),
    .rv32_rs2_data ( rv32_rs2_data ),
    
    .rd_index ( rd_index ),
    .result ( result ),
    .need_write_rd ( need_write_rd ),
    .pc_read_data ( pc_read_data ),
    .pc_next ( pc_next ),

    .memory_read_address ( memory_read_address ),
    .memory_read_data ( memory_read_data ),
    .memory_write_width ( memory_write_width ),
    .memory_write_address ( memory_write_address ),
    .memory_write_data ( memory_write_data ),
    .memory_write_enable ( memory_write_enable )
);

write_back write_back_inst (
    .rd_index ( rd_index ),
    .result ( result ),
    .pc_next ( pc_next ),
    .need_write_rd ( need_write_rd ),
    .rd_write_index ( rd_write_index ),
    .rd_write_data ( rd_write_data ),
    .rd_write_enable ( rd_write_enable ),
    .pc_write_data ( pc_write_data ),
    .pc_write_enable ( pc_write_enable )
);

endmodule // risc_v_cpu
