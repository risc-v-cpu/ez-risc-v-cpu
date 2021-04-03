`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module alu_tb ();

reg operation_add;
reg operation_subtract;
reg operation_and;
reg operation_or;
reg operation_xor;
reg operation_shift_left_logical;
reg operation_shift_right_arithmetic;
reg operation_shift_right_logical;
reg  [`X_LENGTH-1: 0] operand_1;
reg  [`X_LENGTH-1: 0] operand_2;
wire [`X_LENGTH-1: 0] result;

alu alu_inst (
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
    .result ( result )

    // .clk ( clk ),
    // .rst_n ( rst_n )
);

initial begin
    #0
    operation_add = 0;
    operation_subtract = 0;
    operation_and = 0;
    operation_or = 0;
    operation_xor = 0;
    operation_shift_left_logical = 0;
    operation_shift_right_arithmetic = 0;
    operation_shift_right_logical = 0;
    operand_1 = 0;
    operand_2 = 0;
    // result = 0;

    #20
    operation_add = 1;
    operand_1 = 8;
    operand_2 = 16;
    #20
    operand_1 = 8;
    operand_2 = -16;
    #20
    operand_1 = -8;
    operand_2 = -16;

    #20
    operation_add = 0;
    operation_subtract = 1;
    operand_1 = 8;
    operand_2 = 16;
    #20
    operand_1 = 8;
    operand_2 = -16;
    #20
    operand_1 = -8;
    operand_2 = -16;

    #20
    operation_subtract = 0;
    operation_and = 1;
    operand_1 = 8;
    operand_2 = 16;
    #20
    operand_1 = 8;
    operand_2 = -16;
    #20
    operand_1 = -8;
    operand_2 = -16;

    #20
    operation_and = 0;
    operation_or = 1;
    operand_1 = 8;
    operand_2 = 16;
    #20
    operand_1 = 8;
    operand_2 = -16;
    #20
    operand_1 = -8;
    operand_2 = -16;

    #20
    operation_or = 0;
    operation_xor = 1;
    operand_1 = 8;
    operand_2 = 16;
    #20
    operand_1 = 8;
    operand_2 = -16;
    #20
    operand_1 = -8;
    operand_2 = -16;

    #20
    operation_xor = 0;
    operation_shift_left_logical = 1;
    operand_1 = 32;
    operand_2 = 4;
    #20
    operand_1 = -8;
    operand_2 = 4;

    #20
    operation_shift_left_logical = 0;
    operation_shift_right_arithmetic = 1;
    operand_1 = 32;
    operand_2 = 4;
    #20
    operand_1 = -32;
    operand_2 = 4;

    #20
    operation_shift_right_arithmetic = 0;
    operation_shift_right_logical = 1;
    operand_1 = 32;
    operand_2 = 4;
    #20
    operand_1 = -32;
    operand_2 = 4;

    $stop();
end

endmodule // alu_tb
