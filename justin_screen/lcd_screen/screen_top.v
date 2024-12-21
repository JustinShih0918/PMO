module screen_top (
    input wire clk,
    input wire rst,

    // from GM
    input [39:0] Row1,
    input [39:0] Row2,
    input [39:0] Row3,
    input [39:0] Row4,
    input [39:0] Row5,
    input [39:0] Row6,
    input [39:0] Row7,
    input [39:0] Row8,

    // for lcd screen
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out
);

    grid_display_top grid_display_top_inst (
    .clk(clk),
    .rst(rst),
    .Row1(Row1),
    .Row2(Row2),
    .Row3(Row3),
    .Row4(Row4),
    .Row5(Row5),
    .Row6(Row6),
    .Row7(Row7),
    .Row8(Row8),
    .lcd_rst_n_out(lcd_rst_n_out),
    .lcd_bl_out(lcd_bl_out),
    .lcd_dc_out(lcd_dc_out),
    .lcd_clk_out(lcd_clk_out),
    .lcd_data_out(lcd_data_out),
    .lcd_cs_n_out(lcd_cs_n_out)
);

   
    
endmodule