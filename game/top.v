module top(
    input wire clk,
    input wire rst,
    input wire en,
    input [3:0] jstkPos,
    input jstkPress,
    
    // for lcd screen
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out
);

wire [39:0] Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8;

GameManager GameManager_inst (
    .clk(clk),
    .rst(rst),
    .en(en),
    .jstkPos(jstkPos),
    .jstkPress(jstkPress),
    .Row1(Row1),
    .Row2(Row2),
    .Row3(Row3),
    .Row4(Row4),
    .Row5(Row5),
    .Row6(Row6),
    .Row7(Row7),
    .Row8(Row8)
);

screen_top screen_top_inst (
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