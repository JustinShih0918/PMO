`timescale 1ns / 1ps

module top(clk, rst, echo, Trig, Display, Digit, expecting, petting);
input clk, rst, echo;
output Trig;
output [6:0] Display;
output [3:0] Digit;
output expecting;
output petting;
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

assign petting = (distance < 20'b0000_0000_0001_1111_1111) ? 1'b1 : 1'b0;
assign expecting = (distance < 20'b0000_0000_0100_1111_1111) ? 1'b1 : 1'b0;

endmodule
