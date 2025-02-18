module screen_top (
    input wire clk,
    input wire rst,
    input wire go,

    // for lcd screen
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out
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

    animation_controller animation_controller_inst (
        .clk(clk),
        .rst(rst_op),
        .go(go_op),
        .lcd_rst_n_out(lcd_rst_n_out),
        .lcd_bl_out(lcd_bl_out),
        .lcd_dc_out(lcd_dc_out),
        .lcd_clk_out(lcd_clk_out),
        .lcd_data_out(lcd_data_out),
        .lcd_cs_n_out(lcd_cs_n_out)
    );

   
    
endmodule