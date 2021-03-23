module number_extend #(
    parameter WIDTH_SOURCE = 12,
    parameter WIDTH_DESTINATION = 32,
    parameter IS_SIGNED = 1

) (
    input  [WIDTH_SOURCE-1:0] source,
    output [WIDTH_DESTINATION-1:0] extended
);

wire extend_number = IS_SIGNED ? source[WIDTH_SOURCE-1] : 0;
assign extended = {{(WIDTH_DESTINATION-WIDTH_SOURCE){extend_number}}, source};

endmodule // number_extend
