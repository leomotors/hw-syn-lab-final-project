`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:24:41 AM
// Design Name: 
// Module Name: pixel
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


module pixel(
    input clk,
    input wire [9:0] h_pos,
    input wire [9:0] v_pos,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue
    );
    
    parameter H_DISPLAY = 640;  // Horizontal active video
    parameter V_DISPLAY = 480;  // Vertical active video
    
    wire [18:0] address = v_pos / 2 * H_DISPLAY / 2 + h_pos / 2;
    wire [11:0] pixel_data;
    
    bgROM imgROM(address, clk, pixel_data);
    
    assign red = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[11:8] : 4'b0000;
    assign green = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[7:4] : 4'b0000;
    assign blue = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[3:0] : 4'b0000;
endmodule
