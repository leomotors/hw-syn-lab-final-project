`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/08/2024 01:39:28 AM
// Design Name:
// Module Name: tx_mux_tester
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


module tx_mux_tester();

reg ena1, ena2;
reg [7:0] data1, data2;

wire ena_out;
wire [7:0] data_out;

tx_mux muck(
    .data1(data1),
    .ena1(ena1),
    .data2(data2),
    .ena2(ena2),
    .data_out(data_out),
    .ena_out(ena_out)
);

initial begin
    ena1 = 0;
    ena2 = 0;
    data1 = 0;
    data2 = 0;
end

initial begin
    data1 = 8'h11;
    data2 = 8'h22;

    #5 ena1 = 1;
    #5 ena1 = 0;

    #5 ena2 = 1;
    #5 ena2 = 0;

    #5 ena2 = 1;
    #5 ena2 = 0;

    #5 ena1 = 1;
    #5 ena1 = 0;

    #5 $finish;
end

endmodule
