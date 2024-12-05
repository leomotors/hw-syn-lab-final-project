
module system(
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output wire RsTx, //uart
    input [7:0] sw,
    input wire RsRx, //uart // [7:4] for Higher num hex, [3:0] for Lower num
    input clk
    );

    wire [3:0] num3, num2, num1, num0; // left to right
    wire an0, an1, an2, an3;
    assign an = {an3, an2, an1, an0};
    

    wire targetClk;
    wire [18:0] tclk;
    wire [7:0] O;

    assign tclk[0] = clk;
    genvar c;
    generate for(c = 0; c < 18; c = c + 1) begin
        clockDiv fDiv(tclk[c+1], tclk[c]);
    end endgenerate
    
    clockDiv fdivTarget(targetClk, tclk[18]);
    
    wire received;
    uart uart_instance(clk, RsRx, RsTx, O, received);
    
    wire [31:0] seggData;
    circularLinkedList ll(received, O, seggData);
    
    quadSevenSeg q7seg(
        seg,
        dp,
        an0,
        an1,
        an2,
        an3,
        seggData[31:24],
        seggData[23:16],
        seggData[15:8],
        seggData[7:0],
        targetClk
        );
endmodule
