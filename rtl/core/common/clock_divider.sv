module clock_divider #(
    parameter INPUT_CLOCK_HZ = 50_000_000,
    parameter OUTPUT_CLOCK_HZ = 10
) (
output reg clk_out,
// common
input clk,
input rst_n
);

reg [31:0] counter;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        counter <= 0;
        clk_out <= 0;
    end else begin
        if (counter == (INPUT_CLOCK_HZ / OUTPUT_CLOCK_HZ / 2 - 1)) begin
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin
            counter <= counter + 1;
        end
    end
end
    
endmodule