`timescale 1ns / 1ps
module uart(
    input clk,
    input RsRx,
    output RsTx,
    output reg [7:0] data_2,
    output reg data_ready
    );
    
    reg en, last_rec;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire sent, received, baud;
    
    baudrate_gen baudrate_gen(clk, baud);
    uart_rx receiver(baud, RsRx, received, data_out);
    uart_tx transmitter(baud, data_in, en, sent, RsTx);
    
    always @(posedge baud) begin
        if (en) en = 0;
        if (data_ready) data_ready = 0;
        if (~last_rec & received) begin
            data_in = data_out;
            data_2 = data_out;
            if ((data_in <= 8'h7A && data_in >= 8'h20) || data_in == 8'h0A || data_in == 8'h0D)
            begin
                en = 1;
                data_ready = 1;
            end
        end
        last_rec = received;
    end
endmodule
