module compare_gt #(
    parameter WIDTH = 32
) (
    input [WIDTH-1:0] data1,
    input [WIDTH-1:0] data2,
    input is_equal,
    input is_signed,
    
    output reg result
);

always @(*) begin
    if (is_signed == 1'b1) begin
        if (data1[WIDTH-1] == 1'b1 && data2[WIDTH-1] == 1'b0) begin
            result <= 1'b0;
        end else if (data1[WIDTH-1] == 1'b0 && data2[WIDTH-1] == 1'b1) begin
            result <= 1'b1;
        end else if (data1[WIDTH-1] == 1'b1 && data2[WIDTH-1] == 1'b1) begin
            if (is_equal) begin
                result <= data1 <= data2 ? 1'b1 : 1'b0; 
            end else begin
                result <= data1 < data2 ? 1'b1 : 1'b0; 
            end
        end else if (data1[WIDTH-1] == 1'b0 && data2[WIDTH-1] == 1'b0) begin
            if (is_equal) begin
                result <= data1 >= data2 ? 1'b1 : 1'b0; 
            end else begin
                result <= data1 > data2 ? 1'b1 : 1'b0; 
            end
        end else begin
            result <= 1'bz; 
        end 
    end else if (is_signed == 1'b0)  begin
        if (is_equal) begin
            result <= data1 >= data2 ? 1'b1 : 1'b0; 
        end else begin
            result <= data1 > data2 ? 1'b1 : 1'b0; 
        end
    end else begin
        result <= 1'bz;
    end
end

endmodule // compare_gt
