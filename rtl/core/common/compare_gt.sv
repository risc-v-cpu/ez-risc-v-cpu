module compare_gt #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] data1,
    input [WIDTH-1:0] data2,
    input is_signed,
    
    output reg result
);

wire data1_sign = data1[WIDTH-1];
wire data2_sign = data2[WIDTH-1];

wire [WIDTH-1-1:0] data1_without_sign = data1[WIDTH-1-1:0];
wire [WIDTH-1-1:0] data2_without_sign = data2[WIDTH-1-1:0];

wire is_gather_than_without_sign = data1_without_sign > data2_without_sign;
wire is_gather_than_with_sign = (data1_sign > data1_sign) & is_gather_than_without_sign;

always @(*) begin
    case (is_signed)
        1'b1 : begin
            case ({data1_sign, data2_sign})
                2'b10 : begin
                    result <= 1'b0;
                end
                2'b01 : begin
                    result <= 1'b1;
                end
                2'b11, 2'b00 : begin
                    result <= is_gather_than_without_sign;
                end
                default: begin
                    result <= 1'bz;
                end
            endcase
        end
        1'b0 : begin
            result <= is_gather_than_with_sign;
        end
        default : begin
            result <= 1'bz;
        end
    endcase
end

endmodule // compare_gt
