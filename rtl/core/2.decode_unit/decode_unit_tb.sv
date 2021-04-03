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
`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module decode_unit_tb (
);

// instruction_fetch
reg [`X_LENGTH-1: 0] instruction;
reg [`X_LENGTH-1: 0] rs1_read_data;
reg [`X_LENGTH-1: 0] rs2_read_data;

initial begin
    #20 instruction <= 32'b00000000000100000110000010010011;
    #20 instruction <= 32'b00000000000100000110000100010011;
    #20 instruction <= 32'b00000000001100000110000110010011;
    #20 instruction <= 32'b00000001101000100110001000010011;
    #20 instruction <= 32'b00000000000100010001000010110011;
    #20 instruction <= 32'b00000000000100000010000000100011;
    #20 instruction <= 32'b00000000001100001000000110010011;
    #20 instruction <= 32'b00000000010000011000000001100011;
    #20 instruction <= 32'b00000000010000011001000001100011;

    $stop();
end

decode_unit decode_unit_inst (
    .instruction ( instruction ),

    .rs1_read_data ( rs1_read_data ),
    .rs2_read_data ( rs2_read_data )
);

endmodule // decode_unit_tb
