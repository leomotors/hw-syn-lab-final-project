`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 09:33:49 AM
// Design Name: 
// Module Name: circularLinkedList
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


module circularLinkedList(
    input enanan,
    input [7:0] inByte,
    output reg [31:0] data
);

initial
begin
    data = 0;
end

reg [2:0] size = 0;
// capacity = 4;

always @(posedge enanan)
begin
    if (inByte == 8'h0A || inByte == 8'h0D)
        begin
            data[31:0] = 0;
            size = 0;
        end
    else
    begin
    case (size)
        3'b000: begin
            data[7:0] = inByte;
            size = 1;
            end
        3'b001: begin
            data[15:8] = inByte;
            size = 2;
            end
        3'b010: begin
            data[23:16] = inByte;
            size = 3;
            end
        3'b011: begin
            data[31:24] = inByte;
            size = 4;
            end
        3'b100: begin
            data[7:0] = data[15:8];
            data[15:8] = data[23:16];
            data[23:16] = data[31:24];
            data[31:24] = inByte;
            end
    endcase
    end
end

endmodule
