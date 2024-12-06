`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:28:18 PM
// Design Name: 
// Module Name: fontROM
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


module fontROM(
    input [6:0] addr,
    input clock,
    output reg [1023:0] data
);

parameter ROM_SIZE = 126 - 32 + 1;

reg [1023:0] mem [ROM_SIZE - 1 : 0];
initial $readmemh("font.mem", mem);
always @(posedge clock) begin
    data <= mem[addr];
end

endmodule
