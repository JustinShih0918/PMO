`timescale 1ns / 1ps
module top(
    input clk,
    input rst,
    input touch,
    output led
);

assign led = !touch; // touch is active low

endmodule
