`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/07/2024 11:21:25 PM
// Design Name:
// Module Name: tx_mux
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


module tx_mux(
    input [7:0] data1,
    input ena1,
    input [7:0] data2,
    input ena2,
    output wire [7:0] data_out,
    output wire ena_out
);

assign ena_out = ena1 | ena2;
assign data_out = ena1 ? data1 : ena2 ? data2 : 8'h00;

endmodule
