`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: ChadGPT
// 
// Create Date: 12/06/2024 12:41:30 PM
// Design Name: 
// Module Name: testCircularLinkedList
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


module testCircularLinkedList();
    parameter LENGTH = 4;
    
    reg enanan;
    reg [7:0] inByte;
    wire [(LENGTH*8)-1:0] data;

    // Instantiate the circularLinkedList with parameter LENGTH
    circularLinkedList #(LENGTH) uut (
        .enanan(enanan),
        .inByte(inByte),
        .data(data)
    );

    // Generate clock signal
    initial begin
        enanan = 0;
    end

    // Testbench logic
    initial begin
        inByte = 8'h01;
        #5 enanan = 1;
        #5 inByte = 8'h02;
        #5 enanan = 0;
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
