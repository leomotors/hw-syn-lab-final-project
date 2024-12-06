`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 09:08:12 PM
// Design Name: 
// Module Name: rgb_pixel
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


module rgb_pixel(
    input clk,
    input [9:0] x,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b
);

parameter BOX_PERIMETER = 300 * 2 + 48 * 2 - 4;
parameter AVAILABLE_COLORS = 45;

reg [9:0] time_counter;
reg [10:0] offset;

always @(posedge clk) begin
    if (time_counter >= BOX_PERIMETER) begin
        time_counter = 0;
    end else begin
        time_counter = time_counter + 1;
    end
    
    offset = (time_counter + x) % AVAILABLE_COLORS;
end

// Continuous assignments to the wire outputs r, g, and b
assign r = (offset <= 15) ? (15 - offset) :
           (offset <= 30) ? 0 :
           (offset - 30);

assign g = (offset <= 15) ? offset :
           (offset <= 30) ? (30 - offset) :
           0;

assign b = (offset <= 15) ? 0 :
           (offset <= 30) ? (offset - 15) :
           (45 - offset);

endmodule
