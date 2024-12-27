module screen_top (
    input wire clk,
    input wire rst,
    input wire go,
    input wire awaking,
    input wire touched,
    input wire expecting,
    input wire petting,
    input wire pressed,
    input wire up,
    input wire down,
    input wire left,
    input wire right,

    // for lcd screen
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out
);

    animation_controller animation_controller_inst (
        .clk(clk),
        .rst(rst),
        .go(go),
        .awaking(awaking),
        .touched(touched),
        .expecting(expecting),
        .petting(petting),
        .pressed(pressed),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .lcd_rst_n_out(lcd_rst_n_out),
        .lcd_bl_out(lcd_bl_out),
        .lcd_dc_out(lcd_dc_out),
        .lcd_clk_out(lcd_clk_out),
        .lcd_data_out(lcd_data_out),
        .lcd_cs_n_out(lcd_cs_n_out)
    );

   
    
endmodule