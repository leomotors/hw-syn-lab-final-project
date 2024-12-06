`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: gedagedigedagedago
// Design Name: 
// Module Name: system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output wire RsTx,
    input wire RsRx,
    input wire hRx,
    output wire hTx,
    input clk,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire Hsync,
    output wire Vsync
);

    // Section: UART
    wire received;
    wire [7:0] uart_raw_data;
    uart uart_my_pc(
        .clk(clk),
        .RsRx(RsRx),
        .RsTx(hTx)
    );
    
    uart uart_other_pc(
        .clk(clk),
        .RsRx(hRx),
        .RsTx(RsTx),
        .data_2(uart_raw_data),
        .data_ready(received)
    );
    
    wire [7:0] uart_data;
    wire uart_signal;
    uartClockMajik majik1(
        .clk(clk),
        .uart_get(received),
        .data_in(uart_raw_data),
        .data_out(uart_data),
        .majik_signal(uart_signal)
    );

    wire [31:0] seggData;
    circularLinkedList #(4) seggLL(uart_signal, uart_data, seggData);
    
    wire [63:0] vgaData;
    circularLinkedList #(8) vgaLL(uart_signal, uart_data, vgaData);

    // Section: 7 Segment
    wire an0, an1, an2, an3;
    assign an = {an3, an2, an1, an0};

    wire seggClk;
    clockDiv #(18) seggDiv(clk, seggClk);

    quadSevenSeg q7seg(
        .seg(seg),
        .dp(dp),
        .an0(an0),
        .an1(an1),
        .an2(an2),
        .an3(an3),
        .num0(seggData[31:24]),
        .num1(seggData[23:16]),
        .num2(seggData[15:8]),
        .num3(seggData[7:0]),
        .clk(seggClk)
    );

    // Section: VGA Display
    wire vga_clk;

    clk_wiz_0 wizardo(
        .clk_in1(clk),
        .clk_out1(vga_clk)
    );
    
    wire rgb_clk;
    clockDiv #(6) clockDiv(seggClk, rgb_clk);
        
    wire [9:0] h_counter, v_counter;
    
    pixel vga_display(
        .clk(clk),
        .rgb_clk(rgb_clk),
        .h_pos(h_counter),
        .v_pos(v_counter),
        .text_data(vgaData),
        .red(vgaRed),
        .green(vgaGreen),
        .blue(vgaBlue)
    );

    vga_sync vga_sync(
        .clk(clk),
        .vga_clk(vga_clk),
        .Hsync(Hsync),
        .Vsync(Vsync),
        .h_out(h_counter),
        .v_out(v_counter)
    );
endmodule
