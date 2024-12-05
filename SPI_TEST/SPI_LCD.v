`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Devon Andrade
// 
// Design Name: SPI LCD Controller
// Module Name: SPI_LCD 
// Project Name: SPI LCD Controller
// Target Devices: XC2C256-7-TQ144
// Description: Top level design for SPI LCD Controller
//
//////////////////////////////////////////////////////////////////////////////////
module SPI_LCD(
    input wire clk,
    input wire MISO, clear, // DC ,RES
    output wire MOSI, SCLK, SS, // SDA ,SCL, CS
    output wire BC, RES
);
    wire clk_250KHz;
    wire spi_done;
    reg [6:0] lcd_data_out;
    reg lcd_send;

    // Clear button is active low
    assign RES = clear;
    assign BC = 1'b0;

    clock_divider #(.n(4)) clk_div (.clk(clk), .clk_div(clk_250KHz));

    // Generate a send signal and data to send
    reg [23:0] counter;

    always @(posedge clk_250KHz or posedge clear) begin
        if (clear) begin
            counter <= 0;
            lcd_send <= 0;
            lcd_data_out <= 7'd0;
        end else begin
            if (counter == 24'd16_000_000) begin
                counter <= 0;
                lcd_send <= 1;
                lcd_data_out <= lcd_data_out + 1; // Increment data
            end else begin
                counter <= counter + 1;
                lcd_send <= 0;
            end
        end
    end

    spi_master spi (
        .clk(clk_250KHz),
        .rst(clear),
        .data_in(lcd_data_out),
        .MISO(MISO),
        .send(lcd_send),
        .MOSI(MOSI),
        .SCLK(SCLK),
        .SS(SS),
        .done(spi_done)
    );

endmodule
