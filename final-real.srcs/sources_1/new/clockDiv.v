`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 09:10:23 PM
// Design Name: 
// Module Name: clockDiv
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


module clockDiv #(
    parameter BITS = 18
)(
    input clk,
    output clk_out
);
    
    reg [BITS-1:0] counter;
    assign clk_out = counter[BITS-1];
    
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    
endmodule
