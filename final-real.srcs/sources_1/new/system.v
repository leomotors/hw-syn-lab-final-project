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
    output wire RsTx, //uart
    input [7:0] sw,
    input wire RsRx, //uart // [7:4] for Higher num hex, [3:0] for Lower num
    input clk,
    output wire [3:0] vgaRed,
    output wire [3:0] vgaGreen,
    output wire [3:0] vgaBlue,
    output wire Hsync,
    output wire Vsync
    );

    // Section: UAART
    wire received;
    uart uart_instance(clk, RsRx, RsTx, O, received);

    wire [31:0] seggData;
    circularLinkedList ll(received, O, seggData);

    // Section: 7 Segment
    wire an0, an1, an2, an3;
    assign an = {an3, an2, an1, an0};

    wire seggClk;
    wire [7:0] O;

    seggClockDiv seggDiv(clk, seggClk);

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
        
    wire [9:0] h_counter, v_counter;
    
    pixel vga_display(
        .clk(clk),
        .h_pos(h_counter),
        .v_pos(v_counter),
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
