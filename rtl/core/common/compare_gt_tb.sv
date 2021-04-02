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
module compare_gt_tb (
);

parameter WIDTH = 32;

reg signed [WIDTH-1:0] data1;
reg signed [WIDTH-1:0] data2;
reg is_signed = 1;
wire result;

initial begin
    data1 <= 16;
    data2 <= -4;
    
    #1;
    data1 <= -16;
    data2 <= -4;
    #1;
    data1 <= 16;
    data2 <= 4;
    #1;
    data1 <= -16;
    data2 <= 4;
    #1;
    data1 <= 0;
    data2 <= -0;
    #1;
    data1 <= -8;
    data2 <= +8;
    #1;
    data1 <= -8;
    data2 <= +16;
    #1;
    data1 <= +8;
    data2 <= +16;
    #1;
    data1 <= +8;
    data2 <= -16;
    #1;
    data1 <= -16;
    data2 <= -16;
    #1;
    data1 <= -8;
    data2 <= -16;

    $stop();
end

compare_gt compare_gt_inst (
    .data1 ( data1 ),
    .data2 ( data2 ),
    .is_signed ( is_signed ),
    .result ( result )
);

endmodule // execute_unit_tb
