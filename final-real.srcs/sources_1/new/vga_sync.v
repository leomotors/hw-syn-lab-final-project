`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:20:17 AM
// Design Name: 
// Module Name: vga_sync
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


module vga_sync(
    input wire clk, // 100 MHz clock for assignment
    input wire vga_clk, // 25.175 MHz clock for VGA
    output wire Hsync,
    output wire Vsync,
    output reg [9:0] h_out,
    output reg [9:0] v_out
);

    // VGA timing parameters for 640x480 @ 60Hz
    parameter H_DISPLAY    = 640;  // Horizontal active video
    parameter H_FRONT_PORCH = 16;  // Horizontal front porch
    parameter H_SYNC_PULSE  = 96;  // Horizontal sync pulse
    parameter H_BACK_PORCH  = 48;  // Horizontal back porch
    parameter H_TOTAL       = 800; // Total horizontal time

    parameter V_DISPLAY    = 480;  // Vertical active video
    parameter V_FRONT_PORCH = 10;  // Vertical front porch
    parameter V_SYNC_PULSE  = 2;   // Vertical sync pulse
    parameter V_BACK_PORCH  = 33;  // Vertical back porch
    parameter V_TOTAL       = 525; // Total vertical time

    // Horizontal and vertical counters
    reg [9:0] h_counter = 0;  // 10 bits for 0-799
    reg [9:0] v_counter = 0;  // 10 bits for 0-524
    
    always @(posedge clk) begin
        h_out = h_counter;
        v_out =  v_counter;
    end

    // Generate horizontal and vertical sync signals
    assign Hsync = ~(h_counter >= (H_DISPLAY + H_FRONT_PORCH) &&
                     h_counter < (H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE));
                     
    assign Vsync = ~(v_counter >= (V_DISPLAY + V_FRONT_PORCH) &&
                     v_counter < (V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE));

    // Horizontal counter
    always @(posedge vga_clk) begin
        if (h_counter == H_TOTAL - 1) begin
            h_counter <= 0;
            // Increment vertical counter at the end of a line
            if (v_counter == V_TOTAL - 1)
                v_counter <= 0;
            else
                v_counter <= v_counter + 1;
        end else begin
            h_counter <= h_counter + 1;
        end
    end

endmodule

