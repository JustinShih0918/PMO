module animation_controller (
    input wire clk,
    input wire rst,
    input wire go,

    input awaking,
    input touched,
    input expecting,
    input petting,
    input pressed,
    input up,
    input down,
    input left,
    input right,

    // for lcd screen
    output wire lcd_rst_n_out,
    output wire lcd_bl_out,
    output wire lcd_dc_out,
    output wire lcd_clk_out,
    output wire lcd_data_out,
    output wire lcd_cs_n_out
);

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

    wire [15:0] ram_data_menu;
    wire [1:0] mode; // 0 for game, 1 for potato, 2 for setting
    menu menu_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .right(right),
        .left(left),
        .mode(mode),
        .ram_data(ram_data_menu)
    );

    wire [15:0] ram_data_potato;
    wire [15:0] ram_data_setting;
    wire finish_count;
    reg start_potato;
    reg start_setting;
    reg start_gaming;
    wire cnt_mode;
    setting setting_inst (
        .clk(clk),
        .rst(rst),
        .start(start_setting),
        .up(up),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .cnt_mode(cnt_mode),
        .ram_data(ram_data_setting)
    );

    potato potato_inst (
        .clk(clk),
        .rst(rst),
        .start(start_potato),
        .up(up),
        .down(down),
        .left(left),
        .right(right),
        .mode(cnt_mode),
        .pressed(pressed),
        .ram_addr_x(cnt_x),
        .ram_addr_y(cnt_y),
        .finish(finish_count),
        .ram_data(ram_data_potato)
    );

    parameter LCD_H = 162;
    parameter LCD_W = 132;

    parameter EXPRESSION = 0;
    parameter MENU = 1;
    parameter SETTING = 2;
    parameter GAME = 3;
    parameter POTATO = 4;
    parameter FINISH = 5;

    parameter IDLE = 0;
    parameter HAPPY = 1;
    parameter SATISFY = 2; // petting
    parameter SLEEP = 3;
    parameter EXPECT = 4;

    reg [2:0] express, next_express;

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if(rst) express <= IDLE;
        else express <= next_express;
    end

    always @(posedge clk) begin
        if(rst) state <= EXPRESSION;
        else state <= next_state;
    end


    reg en_express;
    reg en_menu;
    wire ten_second_express;
    wire ten_second_menu;
    wire clk_27;
    clock_divider #(.n(27)) clock_divider_inst (.clk(clk), .clk_div(clk_27));
    ten_second_counter ten_second_counter_express (.clk(clk_27), .rst(rst), .en(en_express), .done(ten_second_express));
    ten_second_counter ten_second_counter_menu (.clk(clk_27), .rst(rst), .en(en_menu), .done(ten_second_menu));


    always @(*) begin
        if(state == EXPRESSION) begin
            next_express <= express;
            case (express)
                IDLE: begin
                    if(ten_second_express) next_express <= SLEEP;
                    else if(expecting) next_express <= EXPECT;
                    else if(touched || go) next_express <= HAPPY;
                    else next_express <= IDLE;
                    en_express <= 1;
                end 
                HAPPY: begin
                    if(go || !touched) next_express <= IDLE;
                    else next_express <= HAPPY;
                    en_express <= 0;
                end
                SATISFY: begin
                    if(!petting) next_express <= EXPECT;
                    else next_express <= SATISFY;
                    en_express <= 0;
                end
                SLEEP: begin
                    if(awaking) next_express <= IDLE;
                    else next_express <= SLEEP;
                    en_express <= 0;
                end
                EXPECT: begin
                    if(!expecting || pressed) next_express <= IDLE;
                    else if(petting) next_express <= SATISFY;
                    else next_express <= EXPECT;
                    en_express <= 0;
                end
                default: begin
                    next_express <= express;
                    en_express <= en_express;
                end
            endcase
        end
        else en_express <= 0;
       
    end

    always @(*) begin
        case (state)
            EXPRESSION: begin
                if(pressed) next_state <= MENU;
                else next_state <= EXPRESSION;
                en_menu <= 0;
                start_potato <= 0;
                start_setting <= 0;
                start_gaming <= 0;
            end
            MENU: begin
                if(ten_second_menu) next_state <= EXPRESSION;
                else if(mode == 0 && pressed) next_state <= GAME;
                else if(mode == 1 && pressed) next_state <= POTATO;
                else if(mode == 2 && pressed) next_state <= SETTING;
                else next_state <= MENU; 
                en_menu <= 1;
                start_potato <= 0;
                start_setting <= 0;
                start_gaming <= 0;
            end
            SETTING: begin
                if(pressed) next_state <= MENU;
                else next_state <= SETTING;
                en_menu <= 0;
                start_potato <= 0;
                start_setting <= 1;
                start_gaming <= 0;
            end
            GAME: begin
                if(pressed) next_state <= MENU;
                else next_state <= GAME;
                en_menu <= 0;
                start_potato <= 0;
                start_setting <= 0;
                start_gaming <= 1;
            end
            POTATO: begin
                if(finish_count) next_state <= FINISH;
                else next_state <= POTATO;
                en_menu <= 0;
                start_potato <= 1;
                start_setting <= 0;
                start_gaming <= 0;
            end
            FINISH: begin
                if(ten_second_menu) next_state <= MENU;
                else next_state <= FINISH;
                en_menu <= 1;
                start_potato <= 0;
                start_setting <= 0;
                start_gaming <= 0;
            end
            default: begin
                next_state <= state;
                en_menu <= en_menu;
                start_potato <= start_potato;
            end
        endcase
    end

    always @(*) begin
        case (state)
            EXPRESSION: begin
                case (express)
                    IDLE: ram_data = ram_data_idle;
                    HAPPY: ram_data = ram_data_happy;
                    SATISFY: ram_data = ram_data_satisfy;
                    SLEEP: ram_data = ram_data_sleep;
                    EXPECT: ram_data = ram_data_expect; 
                    default: ram_data = ram_data;
                endcase
            end
            MENU: begin
                ram_data = ram_data_menu;
            end
            SETTING: begin
                ram_data = ram_data_setting;
            end
            GAME: begin
                ram_data = 18'h5555;
            end
            POTATO: begin
                ram_data = ram_data_potato;
            end
            FINISH: begin
                ram_data = ram_data_happy;
            end
            default: begin
                ram_data = ram_data;
            end
        endcase
    end
endmodule