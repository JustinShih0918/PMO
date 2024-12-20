module touch2(
    input clk,
    input rst,
    input touch, // active low
    output touched2,
);

assign touched2 = !touch; // touch is active low

endmodule
