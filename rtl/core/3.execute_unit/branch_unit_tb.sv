`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module branch_unit_tb ();

reg         rv32_s_sb;
reg         rv32_s_sh;
reg         rv32_s_sw;
reg         rv32_i_lb;
reg         rv32_i_lh;
reg         rv32_i_lw;
reg         rv32_i_lbu;
reg         rv32_i_lhu;
reg  [31:20] rv32_i_imm_11_0;
reg  [11: 0] rv32_s_imm_11_0;
reg  [`X_LENGTH-1: 0] operand_1;
reg  [`X_LENGTH-1: 0] operand_2;
reg  [`X_LENGTH-1: 0] operand_3;
wire [`X_LENGTH-1: 0] write_back_register_rd_data;
wire [`MEMORY_DEPTH-1: 0] memory_read_address;
reg  [`MEMORY_WIDTH-1: 0] memory_read_data;
wire [`MEMORY_DEPTH-1: 0] memory_write_address;
wire [`MEMORY_WIDTH-1: 0] memory_write_data;
wire                      memory_write_enable;

memory_access memory_access_inst (
    .rv32_s_sb ( rv32_s_sb ),
    .rv32_s_sh ( rv32_s_sh ),
    .rv32_s_sw ( rv32_s_sw ),
    .rv32_i_lb ( rv32_i_lb ),
    .rv32_i_lh ( rv32_i_lh ),
    .rv32_i_lw ( rv32_i_lw ),
    .rv32_i_lbu ( rv32_i_lbu ),
    .rv32_i_lhu ( rv32_i_lhu ),

    .rv32_i_imm_11_0 ( rv32_i_imm_11_0 ),
    .rv32_s_imm_11_0 ( rv32_s_imm_11_0 ),
    
    .operand_1 ( operand_1 ),
    .operand_2 ( operand_2 ),
    .operand_3 ( operand_3 ),
//     .result ( result ),

    .write_back_register_rd_data ( write_back_register_rd_data ),

    .memory_read_address ( memory_read_address ),
    .memory_read_data ( memory_read_data ),
    .memory_write_address ( memory_write_address ),
    .memory_write_data ( memory_write_data ),
    .memory_write_enable ( memory_write_enable )

    // .clk ( clk ),
    // .rst_n ( rst_n )
);

initial begin
    #0
    rv32_s_sb = 0;
    rv32_s_sh = 0;
    rv32_s_sw = 0;
    rv32_i_lb = 0;
    rv32_i_lh = 0;
    rv32_i_lw = 0;
    rv32_i_lbu = 0;
    rv32_i_lhu = 0;
    rv32_i_imm_11_0 = 0;
    rv32_s_imm_11_0 = 0;
    operand_1 = 0;
    operand_2 = 0;
    operand_3 = 0;
    memory_read_data = 0;

    #20
    rv32_s_sb = 1;
    rv32_s_sh = 0;
    rv32_s_sw = 0;
    rv32_i_lb = 0;
    rv32_i_lh = 0;
    rv32_i_lw = 0;
    rv32_i_lbu = 0;
    rv32_i_lhu = 0;
    rv32_i_imm_11_0 = 0;
    rv32_s_imm_11_0 = 0;
    operand_1 = 0;
    operand_2 = 1;
    operand_3 = 0;
    memory_read_data = 0;

    #20
    rv32_s_sb = 0;
    rv32_s_sh = 0;
    rv32_s_sw = 0;
    rv32_i_lb = 0;
    rv32_i_lh = 0;
    rv32_i_lw = 0;
    rv32_i_lbu = 0;
    rv32_i_lhu = 0;
    rv32_i_imm_11_0 = 0;
    rv32_s_imm_11_0 = 0;
    operand_1 = 0;
    operand_2 = 0;
    operand_3 = 0;
    memory_read_data = 0;

    #20
    rv32_s_sb = 1;
    rv32_s_sh = 0;
    rv32_s_sw = 0;
    rv32_i_lb = 0;
    rv32_i_lh = 0;
    rv32_i_lw = 0;
    rv32_i_lbu = 0;
    rv32_i_lhu = 0;
    rv32_i_imm_11_0 = 0;
    rv32_s_imm_11_0 = 0;
    operand_1 = 0;
    operand_2 = 1;
    operand_3 = 0;
    memory_read_data = 0;

    #20
    rv32_s_sb = 0;
    rv32_s_sh = 0;
    rv32_s_sw = 0;
    rv32_i_lb = 0;
    rv32_i_lh = 0;
    rv32_i_lw = 0;
    rv32_i_lbu = 0;
    rv32_i_lhu = 0;
    rv32_i_imm_11_0 = 0;
    rv32_s_imm_11_0 = 0;
    operand_1 = 0;
    operand_2 = 0;
    operand_3 = 0;
    memory_read_data = 0;

    $finish();
end

endmodule // memory_access
