`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"

module memory_controller (

output [ 1: 0]              memory_write_width,
input  [`MEMORY_DEPTH-1: 0] memory_write_address,
input  [`MEMORY_WIDTH-1: 0] memory_write_data,
input                       memory_write_enable,

input  [`MEMORY_DEPTH-1: 0] memory_read_address,
output [`MEMORY_WIDTH-1: 0] memory_read_data,

// peripheral
output [ 8: 0] LEDG, // LED Green[8:0] 9
output [17: 0] LEDR, // LED Red[17:0] 18

// common
input          clk,
input          rst_n
);

reg [`MEMORY_WIDTH-1:0] memory[`MEMORY_COUNT];

// map: memory => peripheral 
assign {LEDG, LEDR} = memory[0][26:0];


assign memory_read_data = memory[memory_read_address];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        memory[0] <= 0;
        memory[1] <= 0;
        memory[2] <= 0;
        memory[3] <= 0;
        memory[4] <= 0;
        memory[5] <= 0;
        memory[6] <= 0;
        memory[7] <= 0;
//        genvar i;
//        generate
//        for (i=0; i<(`MEMORY_COUNT); i=i+1) begin: clr_mem
//            memory[i] <= 0;
//        end
//        endgenerate
    end else begin
        if (memory_write_enable) begin
            case (memory_write_width)
                2'h1: begin
                    memory[memory_write_address] <= { memory[memory_write_address][31:8], memory_write_data[7:0] };
                end
                2'h2: begin
                    memory[memory_write_address] <= { memory[memory_write_address][31:16], memory_write_data[15:0] };
                end
                2'h3: begin
                    memory[memory_write_address] <= { memory_write_data[31:0] };
                end
                default: begin
                    memory[memory_write_address] <= memory_write_data;
                end
            endcase
        end else begin
            memory[memory_write_address] <= memory[memory_write_address];
        end
    end
end
    
endmodule // memory_controller
