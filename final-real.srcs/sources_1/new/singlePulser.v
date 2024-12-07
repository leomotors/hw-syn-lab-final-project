`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2024 10:55:48 PM
// Design Name: 
// Module Name: singlePulser
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


module singlePulser(
    input clk,
    input D,
    output reg Q
);

reg state;

always @(posedge clk) begin
    state <= D;
    if (state == 0 && D == 1) begin
        Q <= 1;
    end else begin
        Q <= 0;
    end    
end

endmodule
