`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 01:22:08 AM
// Design Name: 
// Module Name: bgROM
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


module bgROM(
    input [18:0] addr,
    input clock,
    output reg [11:0] data
);

parameter ROM_SIZE = 320 * 240;

reg [11:0] mem [ROM_SIZE - 1 : 0];
initial $readmemb("bg.mem", mem);
always @(posedge clock) begin
    data <= mem[addr];
end

endmodule
