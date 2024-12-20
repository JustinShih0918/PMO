module animation_controller (
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

    parameter LCD_H = 162;
    parameter LCD_W = 132;

    parameter EXPRESSION = 0;
    parameter SELECTION = 1;
    parameter GAME = 2;

    parameter IDLE = 0;
    parameter HAPPY = 1;
    parameter SATISFY = 2;
    parameter SLEEP = 3;
    parameter EXPECT = 4;

    wire [7:0] cnt_x;
    wire [7:0] cnt_y;
    reg [15:0] ram_data;

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

    wire [15:0] ram_data_expect;
    expect expect_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .ram_data(ram_data_expect)
    );

    wire [15:0] ram_data_happy;
    happy happy_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .ram_data(ram_data_happy)
    );

    wire [15:0] ram_data_idle;
    idle idle_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .ram_data(ram_data_idle)
    );

    wire [15:0] ram_data_satisfy;
    satisfy satisfy_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .ram_data(ram_data_satisfy)
    );

    wire [15:0] ram_data_sleep;
    sleep sleep_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .ram_data(ram_data_sleep)
    );

    reg [3:0] state, next_state;
    always @(posedge clk) begin
        if(rst) state <= IDLE;
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if(go) next_state <= HAPPY;
                else next_state <= IDLE;
            end
            HAPPY: begin
                if(go) next_state <= SATISFY;
                else next_state <= HAPPY;
            end
            SATISFY: begin
                if(go) next_state <= SLEEP;
                else next_state <= SATISFY;
            end
            SLEEP: begin
                if(go) next_state <= EXPECT;
                else next_state <= SLEEP;
            end
            EXPECT: begin
                if(go) next_state <= IDLE;
                else next_state <= EXPECT;
            end
            default: next_state <= state;
        endcase
    end

    always @(*) begin
        case (state)
            IDLE : ram_data <= ram_data_idle;
            HAPPY: ram_data <= ram_data_happy;
            SATISFY: ram_data <= ram_data_satisfy;
            SLEEP: ram_data <= ram_data_sleep;
            EXPECT: ram_data <= ram_data_expect;
            default: ram_data <= 16'h0000;
        endcase
    end
endmodule