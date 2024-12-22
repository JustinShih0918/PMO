module touch_top (
    input wire clk,
    input wire rst,
    input wire touch1,
    input wire touch2,
    output wire touched
);

    wire touched1, touched2;
    assign touched = touched1 & touched2;
    touch1 touch1_inst (
        .clk(clk),
        .rst(rst),
        .touch(touch1),
        .touched1(touched1)
    );

    touch2 touch2_inst (
        .clk(clk),
        .rst(rst),
        .touch(touch2),
        .touched2(touched2)
);
    
endmodule