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

    parameter IDLE = 0;
    parameter SMILE = 1;

    wire [7:0] ram_addr;
    reg [0:15] ram_data [131:0];

    spi_lcd spi_lcd_inst (
        .clk(clk),
        .rst_in(rst),
        .ran_lcd_data(ram_data),
        .ram_lcd_addr(ram_addr),
        .lcd_rst_n_out(lcd_rst_n_out),
        .lcd_bl_out(lcd_bl_out),
        .lcd_dc_out(lcd_dc_out),
        .lcd_clk_out(lcd_clk_out),
        .lcd_data_out(lcd_data_out),
        .lcd_cs_n_out(lcd_cs_n_out)
    );

    wire [0:15] ram_data_idle [131:0];
    idle idle_inst (
        .clk(clk),
        .rst(rst),
        .ram_addr(ram_addr),
        .ram_data(ram_data_idle)
    );

    reg [1:0] state, next_state;
    always @(posedge clk) begin
        if(rst) state <= IDLE;
        else state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if(go) next_state <= SMILE;
                else next_state <= IDLE;
            end 
            SMILE: begin
                if(go) next_state <= IDLE;
                else next_state <= SMILE;
            end
            default: next_state <= state;
        endcase
    end

    always @(*) begin
        case (state)
            IDLE : ram_data <= ram_data_idle;
            SMILE: ram_data <= ram_data_idle;
            default: ram_data <= ram_data_idle;
        endcase
    end
endmodule