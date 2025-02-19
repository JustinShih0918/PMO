module top (
    input wire clk,
    input wire rst,
    input wire go,

    // gyro_top JA7 ~ JA10
    inout wire gyro_ss,
	inout wire gyro_MOSI,
	inout wire gyro_MISO,
	inout wire gyro_SCLK,

    // touch_top
    input wire touch1, //JC1
    input wire touch2, //JC2

    // sonic_top 
    input wire Echo, // JC3
    output wire Trig, // JC4

    // joystick_top JA 1~4
    output joystick_SS,
    output joystick_MOSI,
    input wire joystick_MISO,
    output joystick_SCLK,

    // screen_top
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out,

    // for debugging
    output wire awaking_de,
    output wire touched_de,
    output wire expecting_de,
    output wire petting_de,
    output wire pressed_de,
    output wire up_de,
    output wire down_de,
    output wire left_de,
    output wire right_de

);


    wire rst_op;
    one_pulse one_pulse_rst (
        .clk(clk),
        .pb_in(rst),
        .pb_out(rst_op)
    );
    wire go_op;
    one_pulse one_pulse_go (
        .clk(clk),
        .pb_in(go),
        .pb_out(go_op)
    );

    // gyro_top
    wire awaking;
    gyro_top gyro_top_inst (
        .clk(clk),
        .rst(rst_op),
        .gyro_ss(gyro_ss),
        .gyro_MOSI(gyro_MOSI),
        .gyro_MISO(gyro_MISO),
        .gyro_SCLK(gyro_SCLK),
        .awaking(awaking)
    );

    // touch_top
    wire touched;
    touch_top touch_top_inst (
        .clk(clk),
        .rst(rst_op),
        .touch1(touch1),
        .touch2(touch2),
        .touched(touched)
    );

    // sonic_top
    wire expecting;
    wire petting;
    sonic_top sonic_top_inst (
        .clk(clk),
        .rst(rst_op),
        .Echo(Echo),
        .Trig(Trig),
        .expecting(expecting),
        .petting(petting)
    );

    // joystich_top
    wire pressed,up,down,left,right;
    joystick_top joystick_top_inst (
        .clk(clk),
        .rst(rst_op),
        .joystick_MISO(joystick_MISO),
        .joystick_SS(joystick_SS),
        .joystick_MOSI(joystick_MOSI),
        .joystick_SCLK(joystick_SCLK),
        .pressed(pressed),
        .up(up),
        .down(down),
        .left(left),
        .right(right)
    );

    wire awaking_op, pressed_op, up_op, down_op, left_op, right_op;
    one_pulse one_pulse_awaking (.clk(clk), .pb_in(awaking), .pb_out(awaking_op));
    one_pulse one_pulse_pressed (.clk(clk), .pb_in(pressed), .pb_out(pressed_op));
    one_pulse one_pulse_up (.clk(clk), .pb_in(up), .pb_out(up_op));
    one_pulse one_pulse_down (.clk(clk), .pb_in(down), .pb_out(down_op));
    one_pulse one_pulse_left (.clk(clk), .pb_in(left), .pb_out(left_op));
    one_pulse one_pulse_right (.clk(clk), .pb_in(right), .pb_out(right_op));

    //screen_top
    screen_top screen_top_inst (
        .clk(clk),
        .rst(rst_op),
        .go(go_op),
        .awaking(awaking),
        .touched(touched),
        .expecting(expecting),
        .petting(petting),
        .pressed(pressed_op),
        .up(up_op),
        .down(down_op),
        .left(left_op),
        .right(right_op),
        .lcd_rst_n_out(lcd_rst_n_out),
        .lcd_bl_out(lcd_bl_out),
        .lcd_dc_out(lcd_dc_out),
        .lcd_clk_out(lcd_clk_out),
        .lcd_data_out(lcd_data_out),
        .lcd_cs_n_out(lcd_cs_n_out)
    );

    assign awaking_de = awaking;
    assign touched_de = touched;
    assign expecting_de = expecting;
    assign petting_de = petting;
    assign pressed_de = pressed;
    assign up_de = up;
    assign down_de = down;
    assign left_de = left;
    assign right_de = right;
    
endmodule