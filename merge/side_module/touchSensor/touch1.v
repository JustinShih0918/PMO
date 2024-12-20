module touch1(
    input clk,
    input rst,
    input touch,
    output touched1
);

assign touched1 = !touch; // touch is active low

endmodule
