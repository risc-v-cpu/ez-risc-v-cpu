`include "./defines.sv"
module risc_v_cpu_top (
    
// peripheral
output [ 8: 0] LEDG, // LED Green[8:0] 9
output [17: 0] LEDR, // LED Red[17:0] 18

// common
input  [ 3: 0] KEY,
input          CLOCK_50
);

// wire clk; // = CLOCK_50;
wire clk = CLOCK_50;
wire rst_n = KEY[0];

// clock_divider #(
//     .INPUT_CLOCK_HZ ( 50_000_000 ),
//     .OUTPUT_CLOCK_HZ ( 10 )
// ) (
//     .clk_out ( clk ),

//     .clk ( CLOCK_50 ),
//     .rst_n ( rst_n )
// );

wire [`MEMORY_DEPTH-1: 0] memory_write_address;
wire [`MEMORY_WIDTH-1: 0] memory_write_data;
wire                      memory_write_enable;

wire [`MEMORY_DEPTH-1: 0] memory_read_address;
wire [`MEMORY_WIDTH-1: 0] memory_read_data;

risc_v_cpu risc_v_cpu_inst(
    .memory_read_address ( memory_read_address ),
    .memory_read_data ( memory_read_data ),
    .memory_write_address ( memory_write_address ),
    .memory_write_data ( memory_write_data ),
    .memory_write_enable ( memory_write_enable ),

    .clk ( clk ),
    .rst_n ( rst_n )
);

memory_controller memory_controller_inst(
    .memory_read_address ( memory_read_address ),
    .memory_read_data ( memory_read_data ),
    .memory_write_address ( memory_write_address ),
    .memory_write_data ( memory_write_data ),
    .memory_write_enable ( memory_write_enable ),

    .LEDG ( LEDG ),
    .LEDR ( LEDR ),

    .clk ( clk ),
    .rst_n ( rst_n )
);

endmodule // risc_v_cpu_top
