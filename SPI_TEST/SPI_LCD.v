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
	input wire clk, rst
	input wire MISO, clear, // DC ,RES
	output wire MOSI, SCLK, SS, // SDA ,SCL, CS
    output wire BC
);

    wire clk_250KHz;
    wire key_data_ready, data_ready_synced, lcd_send;
    wire [6:0] encoder_out, lcd_data_out;
    wire clear_inv, spi_done;
    
    // Clear button is active low
    assign clear_inv = ~clear;
    assign encoder_out = 7'd32;
    assign BC = 1'b1;
    clock_divider #(.n(4)) clk_div (.clk(clk), .clk_div(clk_250KHz));
    
	synchronizer sync (
		.fast_clk(clk_250KHz), 
		.rst(rst), 
		.flag(key_data_ready), 
		.flag_out(data_ready_synced)
    );
	
    lcd_ctrl lcd (
        .clk(clk_250KHz), 
        .rst(rst), 
        .clear(clear_inv), 
        .spi_done(spi_done), 
        .key_data_out(encoder_out), 
        .key_send(data_ready_synced), 
        .data_out(lcd_data_out), 
        .send(lcd_send)
    );
    
    spi_master spi (
        .clk(clk_250KHz), 
        .rst(rst), 
        .data_in(lcd_data_out), 
        .MISO(MISO), 
        .send(lcd_send), 
        .MOSI(MOSI), 
        .SCLK(SCLK), 
        .SS(SS),
        .done(spi_done)
    );

endmodule
