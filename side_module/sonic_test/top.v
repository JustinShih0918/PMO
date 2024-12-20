`timescale 1ns / 1ps

module top(clk, rst, echo, Trig, Display, Digit);
input clk, rst, echo;
output Trig;
output [6:0] Display;
output [3:0] Digit;

wire[19:0] distance;
wire[15:0] dis_nums;
assign dis_nums = distance[15:0];

sonic_top sonic(
    .clk(clk),
    .rst(rst),
    .Echo(echo),
    .Trig(Trig),
    .distance(distance)
);

SevenSegment seg(
    .clk(clk),
    .rst(rst),
    .nums(dis_nums),
    .display(Display),
    .digit(Digit)
);

endmodule
