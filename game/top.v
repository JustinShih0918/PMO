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
    output wire lcd_cs_n_out,

    // for debugging
    output [15:0] led
);

wire [39:0] Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8;

// for testing
wire [3:0] db_jstk_pos, op_jstk_pos;
debounce db1(db_jstk_pos[0], jstkPos[0], clk);
debounce db2(db_jstk_pos[1], jstkPos[1], clk);
debounce db3(db_jstk_pos[2], jstkPos[2], clk);
debounce db4(db_jstk_pos[3], jstkPos[3], clk);
one_pulse op1(clk, db_jstk_pos[0], op_jstk_pos[0]);
one_pulse op2(clk, db_jstk_pos[1], op_jstk_pos[1]);
one_pulse op3(clk, db_jstk_pos[2], op_jstk_pos[2]);
one_pulse op4(clk, db_jstk_pos[3], op_jstk_pos[3]);
// for testing end

GameManager GameManager_inst (
    .clk(clk),
    .rst(rst),
    .en(en),
    .jstkPos(op_jstk_pos),
    .jstkPress(jstkPress),
    .Row1(Row1),
    .Row2(Row2),
    .Row3(Row3),
    .Row4(Row4),
    .Row5(Row5),
    .Row6(Row6),
    .Row7(Row7),
    .Row8(Row8),
    .led(led)
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