`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/08/2024 02:10:56 PM
// Design Name:
// Module Name: slidingBufferTester
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


module slidingBufferTester();

parameter LENGTH = 4;

reg enanan, reset;
reg [7:0] inByte;
wire [(LENGTH*8)-1:0] data;

// Instantiate the circularLinkedList with parameter LENGTH
slidingBuffer #(LENGTH) buffa (
    .enanan(enanan),
    .reset(reset),
    .inByte(inByte),
    .data(data)
);

// Generate clock signal
initial begin
    enanan = 0;
    reset = 0;
    inByte = 8'h00;
end

// Testbench logic
initial begin
    #5 reset = 1;
    #5 reset = 0;
    #5 inByte = 8'h01;
    #5 enanan = 1;
    #5 enanan = 0;
    #5 inByte = 8'h02;
    #5 enanan = 1;
    #5 enanan = 0;
    #10 inByte = 8'h03; // Add 0xC3
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h04; // Add 0xD4
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h05; // Overwrite and shift
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h06; // Overwrite and shift
    #2 enanan = 1;

    #2 enanan = 0;
    #5 reset = 1;
    #5 reset = 0;

    #5 inByte = 8'h01;
    #5 enanan = 1;
    #5 enanan = 0;
    #5 inByte = 8'h02;
    #5 enanan = 1;
    #5 enanan = 0;
    #10 inByte = 8'h03; // Add 0xC3
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h04; // Add 0xD4
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h05; // Overwrite and shift
    #2 enanan = 1;
    #2 enanan = 0;
    #10 inByte = 8'h06; // Overwrite and shift
    #2 enanan = 1;

    #5 $finish;
end

endmodule
