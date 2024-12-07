`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 10:55:48 PM
// Design Name: 
// Module Name: DFF
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


module DFF(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
