`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 12/08/2024 02:00:34 PM
// Design Name:
// Module Name: slidingBuffer
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


module slidingBuffer #(
    parameter LENGTH = 4
)(
    input enanan,
    input reset,
    input [7:0] inByte,
    output reg [(LENGTH * 8) - 1 : 0] data
);

reg [$clog2(LENGTH) : 0] size;

initial begin
    size = 0;
    data = 0;
end

always @(negedge enanan or posedge reset)
begin
    if (reset) begin
        data <= 0;
        size <= 0;
    end
    else if (inByte == 8'h0A || inByte == 8'h0D) begin
        data <= 0;
        size <= 0;
    end
    else if (inByte == 8'h08) begin
        if (size > 0) begin
            data[((size - 1) * 8) +: 8] <= 8'h00;
            size <= size - 1;
        end
    end
    else begin
        if (size < LENGTH) begin
            // Add new byte at the correct position
            data[(size*8) +: 8] <= inByte;
            size <= size + 1;
        end else begin
            // Shift data and add the new byte at the end
            data <= {inByte, data[(LENGTH * 8) - 1 : 8]};
        end
    end
end

endmodule
