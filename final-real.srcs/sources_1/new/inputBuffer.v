`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 10:55:48 PM
// Design Name: 
// Module Name: inputBuffer
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


module inputBuffer(
    input clk,
    input D,
    output wire Q
);

wire s0, s1;

DFF u0(.clk(clk), .D(D), .Q(s0));
DFF u1(.clk(clk), .D(s0), .Q(s1));
singlePulser u2(.clk(clk), .D(s1), .Q(Q));

endmodule
