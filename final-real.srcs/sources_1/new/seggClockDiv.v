`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:39:43 AM
// Design Name: 
// Module Name: seggClockDiv
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

// Clock Divider for 7 Segment Module
module seggClockDiv(
    input clk,
    output clk_out
    );
    
    reg [17:0] counter;
    assign clk_out = counter[17];
    
    always @(posedge clk) begin
        counter <= counter + 1;
    end
    
endmodule
