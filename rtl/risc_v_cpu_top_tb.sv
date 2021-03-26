`include "C:/my/GitHub/risc-v-cpu/ez-risc-v-cpu/rtl/defines.sv"
module risc_v_cpu_top_tb (
);

// peripheral
wire [ 8: 0] LEDG; // LED Green[8:0] 9
wire [17: 0] LEDR; // LED Red[17:0] 18

// common
reg [ 3: 0] KEY;
reg CLOCK_50;

initial begin
    KEY <= 4'b1110;
    CLOCK_50 <= 0;
    #40 KEY <= 4'b1111;
    forever #20 CLOCK_50 <= ~CLOCK_50;
end


risc_v_cpu_top risc_v_cpu_top_inst(
    .LEDG ( LEDG ),
    .LEDR ( LEDR ),

    .KEY ( KEY ),
    .CLOCK_50 ( CLOCK_50 )
);

endmodule // risc_v_cpu_top_tb
