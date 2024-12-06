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
    wire [7:0] O;
    uart uart_instance(clk, RsRx, RsTx, O, received);
    
    reg [7:0] oClone;
    
    reg [1:0] received_counter;
    reg received_nextclk;

    always @(posedge clk) begin
        oClone = O;
        
        if (received && received_counter == 0) begin
            received_counter <= 1;
        end else if (received_counter == 1) begin
            received_counter <= 2;
        end else if (received_counter >= 2) begin
            received_nextclk <= 1;
        end
        
        if (received == 0 && received_counter > 0) begin
            received_counter <= 0;
            received_nextclk <= 0;
        end
    end

    wire [31:0] seggData;
    circularLinkedList #(4) seggLL(received_nextclk, oClone, seggData);
    
    wire [63:0] vgaData;
    circularLinkedList #(8) vgaLL(received_nextclk, oClone, vgaData);

    // Section: 7 Segment
    wire an0, an1, an2, an3;
    assign an = {an3, an2, an1, an0};

    wire seggClk;
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
//        .num0(vgaData[63:56]),
//        .num1(vgaData[55:48]),
//        .num2(vgaData[47:40]),
//        .num3(vgaData[39:32]),
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
