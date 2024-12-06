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
    input wire [63:0] text_data,
    output wire [3:0] red,
    output wire [3:0] green,
    output wire [3:0] blue
    );
    
    parameter H_DISPLAY = 640;  // Horizontal active video
    parameter V_DISPLAY = 480;  // Vertical active video
    
    wire [18:0] address = v_pos / 2 * H_DISPLAY / 2 + h_pos / 2;
    wire [11:0] pixel_data;
    
    bgROM imgROM(address, clk, pixel_data);

    reg [7:0] fontaddr;
    reg [6:0] fontaddr_offset;
    
    always @(posedge clk) begin
        fontaddr_offset = fontaddr >= 32 ? fontaddr - 32 : 0;
    end

    wire [1023:0] fontdat;
    fontROM fontROM(.addr(fontaddr_offset), .clock(clk), .data(fontdat)); 
    
    reg [3:0] r, g, b;
    assign red = r;
    assign green = g;
    assign blue = b;
    
    parameter AREA_X_START = 178;
    parameter AREA_X_END = 462;
    parameter AREA_Y_START = 224;
    parameter AREA_Y_END = 256;
    
    reg [3:0] alphabet_index;
    reg [5:0] alphabet_x;
    
    reg font_on;
    
    always @(posedge clk) begin        
        if (h_pos >= AREA_X_START && h_pos < AREA_X_END && v_pos >= AREA_Y_START && v_pos < AREA_Y_END)
        begin
            alphabet_index = (h_pos - AREA_X_START) / 36;
            alphabet_x = (h_pos - AREA_X_START) % 36;
           
            if (alphabet_index >= 8 || alphabet_x >= 32)
            begin
                fontaddr = 0;
            end
            else
            begin
                case (alphabet_index)
                    3'h0: fontaddr = text_data[7:0];
                    3'h1: fontaddr = text_data[15:8];
                    3'h2: fontaddr = text_data[23:16];
                    3'h3: fontaddr = text_data[31:24];
                    3'h4: fontaddr = text_data[39:32];
                    3'h5: fontaddr = text_data[47:40];
                    3'h6: fontaddr = text_data[55:48];
                    3'h7: fontaddr = text_data[63:56];
                    default: fontaddr = 0;
                endcase
                
                // I don't know why tf it rotated 180 deg
                font_on = fontdat[(AREA_Y_END - v_pos - 1) * 32 + 31 - alphabet_x];
            end
            
            r = font_on ? 4'b1111: 4'b0000;
            g = font_on ? 4'b1111: 4'b0000;
            b = font_on ? 4'b1111: 4'b0000;
        end
        else
        begin
            r = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[11:8] : 4'b0000;
            g = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[7:4] : 4'b0000;
            b = (h_pos < H_DISPLAY && v_pos < V_DISPLAY) ? pixel_data[3:0] : 4'b0000;
        end
    end
endmodule
