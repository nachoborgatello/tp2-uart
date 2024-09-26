`timescale 1ns / 1ps
module top_module(
    input wire i_clk,           // Reloj principal
    input wire i_reset,         // Reset global
    input wire rx,              // Señal de recepción UART
    output wire [7:0] dout,     // Salida de datos recibidos
    output wire rx_done_tick    // Señal que indica cuando la recepción ha terminado
);

    // Parámetros
    localparam BAUD_RATE = 19200;
    localparam FREQ_CLK = 50000000;
    
    wire s_tick;  // Señal de tick generada por el baud_rate
    
    // Instancia del generador de baud_rate
    baud_rate #(
        .FREQ_CLK(FREQ_CLK),
        .BAUD_RATE(BAUD_RATE)
    )
    baud_gen (
        .clk(i_clk),
        .reset(i_reset),
        .o_tick(s_tick)
    );
    
    // Instancia del receptor UART (uart_rx)
    uart_rx uart_receiver (
        .clk(i_clk),
        .reset(i_reset),
        .rx(rx),
        .s_tick(s_tick),
        .rx_done_tick(rx_done_tick),
        .dout(dout)
    );

endmodule
