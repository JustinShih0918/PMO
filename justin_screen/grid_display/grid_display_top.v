module grid_display_top (
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

    parameter LCD_H = 162;
    parameter LCD_W = 132;

    wire [7:0] cnt_x;
    wire [7:0] cnt_y;
    wire [15:0] ram_data;

    spi_lcd spi_lcd_inst (
        .clk(clk),
        .rst(rst),
        .ram_lcd_data(ram_data),
        .ram_lcd_addr_y(cnt_y),
        .ram_lcd_addr_x(cnt_x),
        .lcd_rst_n_out(lcd_rst_n_out),
        .lcd_bl_out(lcd_bl_out),
        .lcd_dc_out(lcd_dc_out),
        .lcd_clk_out(lcd_clk_out),
        .lcd_data_out(lcd_data_out),
        .lcd_cs_n_out(lcd_cs_n_out)
    );

    wire [15:0] ram_data_pix;
    grid grid_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .Row1(Row1),
        .Row2(Row2),
        .Row3(Row3),
        .Row4(Row4),
        .Row5(Row5),
        .Row6(Row6),
        .Row7(Row7),
        .Row8(Row8),
        .ram_data(ram_data_pix)
    );

    assign ram_data = ram_data_pix;

endmodule