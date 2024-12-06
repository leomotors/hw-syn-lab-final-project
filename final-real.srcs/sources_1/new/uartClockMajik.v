`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 07:11:37 PM
// Design Name: 
// Module Name: uartClockMajik
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Magic
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uartClockMajik(
    input clk,
    input wire uart_get,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output reg majik_signal
);
    
reg [1:0] received_counter;

always @(posedge clk) begin
    data_out <= data_in;
        
    if (uart_get && received_counter == 0) begin
        received_counter <= 1;
    end else if (received_counter == 1) begin
        received_counter <= 2;
    end else if (received_counter >= 2) begin
        majik_signal <= 1;
    end
        
    if (uart_get == 0 && received_counter > 0) begin
        received_counter <= 0;
        majik_signal <= 0;
    end
end

endmodule
