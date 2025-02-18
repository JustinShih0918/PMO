// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Module: LCD_RGB
// 
// Author: Step
// 
// Description: Drive TFT_RGB_LCD_1.8 to display
// 
// Web: www.stepfpga.com
//
// --------------------------------------------------------------------
// Code Revision History :
// --------------------------------------------------------------------
// Version: |Mod. Date:   |Changes Made:
// V1.1     |2016/10/30   |Initial ver
// --------------------------------------------------------------------
module spi_lcd #
(
	parameter LCD_W = 8'd132,			//screen width
	parameter LCD_H = 8'd162			//screen height
)
(
	input wire clk,
	input wire rst,		//high trigger
    input [15:0] ram_lcd_data,
	output wire [7:0] ram_lcd_addr_x,
	output wire [7:0] ram_lcd_addr_y,
 
	output reg	lcd_rst_n_out,	//RES
	output reg	lcd_bl_out,		//BL
	output reg	lcd_dc_out,		//DC
	output reg	lcd_clk_out,	//SCL
	output reg	lcd_data_out,	//SDA
    output wire lcd_cs_n_out
);
 
	parameter INIT_DEPTH = 16'd73;
 
	parameter RED =	16'hf800;	//红色
	parameter GREEN	= 16'h07e0;	//绿色
	parameter BLUE	= 16'h001f;	//蓝色
	parameter BLACK	= 16'h0000;	//黑色
	parameter WHITE	= 16'hffff;	//白色
	parameter YELLOW =16'hffe0;	//黄色
	parameter IDLE = 3'd0;
	parameter MAIN = 3'd1;
	parameter INIT = 3'd2;
	parameter SCAN = 3'd3;
	parameter WRITE = 3'd4;
	parameter DELAY = 3'd5;
	parameter LOW = 1'b0;
	parameter HIGH = 1'b1;
 
	wire [15:0]	color_t	= YELLOW;
	wire [15:0]	color_b	= BLACK;
 
	reg	[7:0] x_cnt;
	reg	[7:0] y_cnt;
	reg	[131:0]	ram_data_r;
 
	reg	[8:0] data_reg;				
	reg	[8:0] reg_setxy [10:0];
	reg	[8:0] reg_init [72:0];
	reg	[2:0] cnt_main;
	reg	[2:0] cnt_init;
	reg	[2:0] cnt_scan;
	reg	[5:0] cnt_write;
	reg	[15:0] cnt_delay;
	reg	[15:0] num_delay;
	reg	[15:0] cnt;
	reg	high_word;
	reg	[2:0] state = IDLE;
	reg	[2:0] state_back = IDLE;

	reg	[7:0] ram_lcd_addr;
	reg	ram_lcd_clk_en;
	assign ram_lcd_addr_x = x_cnt;
	assign ram_lcd_addr_y = y_cnt;
    assign lcd_cs_n_out = 1'b0;
	always@(posedge clk or posedge rst) begin
		if(rst) begin
			x_cnt <= 8'd0;
			y_cnt <= 8'd0;
			ram_lcd_clk_en <= 1'b0;
			ram_lcd_addr <= 8'd0;
			cnt_main <= 3'd0;
			cnt_init <= 3'd0;
			cnt_scan <= 3'd0;
			cnt_write <= 6'd0;
			cnt_delay <= 16'd0;
			num_delay <= 16'd50;
			cnt <= 16'd0;
			high_word <= 1'b1;
			lcd_bl_out <= LOW;
			state <= IDLE;
			state_back <= IDLE;
		end
        else begin
			case(state)
				IDLE: begin
						x_cnt <= 8'd0;
						y_cnt <= 8'd0;
						ram_lcd_clk_en <= 1'b0;
						ram_lcd_addr <= 8'd0;
						cnt_main <= 3'd0;
						cnt_init <= 3'd0;
						cnt_scan <= 3'd0;
						cnt_write <= 6'd0;
						cnt_delay <= 16'd0;
						num_delay <= 16'd50;
						cnt <= 16'd0;
						high_word <= 1'b1;
						state <= MAIN;
						state_back <= MAIN;
					end
				MAIN:begin
						case(cnt_main)	//MAIN状态
							3'd0: begin 
								state <= INIT;
								cnt_main <= cnt_main + 1'b1;
							end
							3'd1: begin
								state <= SCAN;
								cnt_main <= cnt_main + 1'b1;
							end
							3'd2: begin 
								cnt_main <= 1'b1;
							end
							default: state <= IDLE;
						endcase
					end
				INIT: begin
						case(cnt_init)
							3'd0: begin
								lcd_rst_n_out <= 1'b0;
								cnt_init <= cnt_init + 1'b1;
							end	
							3'd1: begin
								num_delay <= 16'd3000;
								state <= DELAY; state_back <= INIT;
								cnt_init <= cnt_init + 1'b1;
							end
							3'd2: begin
								lcd_rst_n_out <= 1'b1;
								cnt_init <= cnt_init + 1'b1;
							end
							3'd3: begin
								num_delay <= 16'd3000;
								state <= DELAY; state_back <= INIT;
								cnt_init <= cnt_init + 1'b1;
							end
							3'd4: begin 
								if(cnt>=INIT_DEPTH) begin
									cnt <= 16'd0;
									cnt_init <= cnt_init + 1'b1;
								end else begin
									data_reg <= reg_init[cnt];	
									if(cnt==16'd0) num_delay <= 16'd50000;
									else num_delay <= 16'd50;
									cnt <= cnt + 16'd1;
									state <= WRITE;
									state_back <= INIT;
								end
							end
							3'd5:	begin cnt_init <= 1'b0; state <= MAIN; end
							default: state <= IDLE;
						endcase
					end
				SCAN: begin
						case(cnt_scan)
							3'd0: begin
								if(cnt >= 11) begin	//
									cnt <= 16'd0;
									cnt_scan <= cnt_scan + 1'b1;
								end else begin
									data_reg <= reg_setxy[cnt];
									cnt <= cnt + 16'd1;
									num_delay <= 16'd50;
									state <= WRITE;
									state_back <= SCAN;
								end
							end
							3'd1: begin
								ram_lcd_clk_en <= HIGH;
								ram_lcd_addr <= y_cnt;
								cnt_scan <= cnt_scan + 1'b1;
							end
							3'd2: begin
								cnt_scan <= cnt_scan + 1'b1; 
							end
							3'd3: begin
								ram_lcd_clk_en <= LOW;
								ram_data_r <= ram_lcd_data;
								cnt_scan <= cnt_scan + 1'b1;
							end
							3'd4: begin
								if(x_cnt>=LCD_W) begin
									x_cnt <= 8'd0;	
									if(y_cnt>=LCD_H) begin
										y_cnt <= 8'd0;
										cnt_scan <= cnt_scan + 1'b1;
									end
									else begin
										y_cnt <= y_cnt + 1'b1;
										cnt_scan <= 3'd1;
									end
								end
								else begin
									if(high_word) data_reg <= {1'b1, ram_lcd_data[15:8]};
									else begin 
										data_reg <= {1'b1, ram_lcd_data[7:0]};
										x_cnt <= x_cnt + 1'b1;
									end
									high_word <= ~high_word;
									num_delay <= 16'd50;
									state <= WRITE;
									state_back <= SCAN;
								end
							end
							3'd5: begin 
								cnt_scan <= 1'b0; lcd_bl_out <= HIGH;
								state <= MAIN;
							end
							default: state <= IDLE;
						endcase
					end
				WRITE: begin
						if(cnt_write >= 6'd17) cnt_write <= 1'b0;
						else cnt_write <= cnt_write + 1'b1;
						case(cnt_write)
							6'd0: lcd_dc_out <= data_reg[8];
							6'd1: begin
								lcd_clk_out <= LOW;
								lcd_data_out <= data_reg[7];
							end
							6'd2: lcd_clk_out <= HIGH;
							6'd3: begin
								lcd_clk_out <= LOW;
								lcd_data_out <= data_reg[6];
							end
							6'd4: lcd_clk_out <= HIGH;
							6'd5: begin 
								lcd_clk_out <= LOW;
								lcd_data_out <= data_reg[5]; 
							end
							6'd6: lcd_clk_out <= HIGH;
							6'd7: begin
								lcd_clk_out <= LOW; 
								lcd_data_out <= data_reg[4];
							end
							6'd8: lcd_clk_out <= HIGH;
							6'd9: begin
								lcd_clk_out <= LOW; 
								lcd_data_out <= data_reg[3]; 
							end
							6'd10: lcd_clk_out <= HIGH;
							6'd11: begin
								lcd_clk_out <= LOW; 
								lcd_data_out <= data_reg[2];
							end
							6'd12: lcd_clk_out <= HIGH;
							6'd13: begin
								lcd_clk_out <= LOW; 
								lcd_data_out <= data_reg[1];
							end
							6'd14: lcd_clk_out <= HIGH;
							6'd15: begin
								lcd_clk_out <= LOW; 
								lcd_data_out <= data_reg[0];
							end
							6'd16: lcd_clk_out <= HIGH;
							6'd17: begin
								lcd_clk_out <= LOW;
							 	state <= DELAY; 
							end	
							default: state <= IDLE;
						endcase
					end
				DELAY:begin	//延时状态
						if(cnt_delay >= num_delay) begin
							cnt_delay <= 16'd0;
							state <= state_back; 
						end else cnt_delay <= cnt_delay + 1'b1;
					end
				default: state <= IDLE;
			endcase
		end
	end
 
	// data for setxy
	initial
		begin
			reg_setxy[0]	=	{1'b0,8'h2a};
			reg_setxy[1]	=	{1'b1,8'h00};
			reg_setxy[2]	=	{1'b1,8'h00};
			reg_setxy[3]	=	{1'b1,8'h00};
			reg_setxy[4]	=	{1'b1,LCD_W-1};
			reg_setxy[5]	=	{1'b0,8'h2b};
			reg_setxy[6]	=	{1'b1,8'h00};
			reg_setxy[7]	=	{1'b1,8'h00};
			reg_setxy[8]	=	{1'b1,8'h00};
			reg_setxy[9]	=	{1'b1,LCD_H-1};
			reg_setxy[10]	=	{1'b0,8'h2c};
		end
 
	// data for init
	initial	
		begin
			reg_init[0]		=	{1'b0,8'h11}; 
			reg_init[1]		=	{1'b0,8'hb1}; 
			reg_init[2]		=	{1'b1,8'h05}; 
			reg_init[3]		=	{1'b1,8'h3c}; 
			reg_init[4]		=	{1'b1,8'h3c}; 
			reg_init[5]		=	{1'b0,8'hb2}; 
			reg_init[6]		=	{1'b1,8'h05}; 
			reg_init[7]		=	{1'b1,8'h3c}; 
			reg_init[8]		=	{1'b1,8'h3c}; 
			reg_init[9]		=	{1'b0,8'hb3}; 
			reg_init[10]	=	{1'b1,8'h05}; 
			reg_init[11]	=	{1'b1,8'h3c}; 
			reg_init[12]	=	{1'b1,8'h3c}; 
			reg_init[13]	=	{1'b1,8'h05}; 
			reg_init[14]	=	{1'b1,8'h3c}; 
			reg_init[15]	=	{1'b1,8'h3c}; 
			reg_init[16]	=	{1'b0,8'hb4}; 
			reg_init[17]	=	{1'b1,8'h03}; 
			reg_init[18]	=	{1'b0,8'hc0}; 
			reg_init[19]	=	{1'b1,8'h28}; 
			reg_init[20]	=	{1'b1,8'h08}; 
			reg_init[21]	=	{1'b1,8'h04}; 
			reg_init[22]	=	{1'b0,8'hc1}; 
			reg_init[23]	=	{1'b1,8'hc0}; 
			reg_init[24]	=	{1'b0,8'hc2}; 
			reg_init[25]	=	{1'b1,8'h0d}; 
			reg_init[26]	=	{1'b1,8'h00}; 
			reg_init[27]	=	{1'b0,8'hc3}; 
			reg_init[28]	=	{1'b1,8'h8d}; 
			reg_init[29]	=	{1'b1,8'h2a}; 
			reg_init[30]	=	{1'b0,8'hc4}; 
			reg_init[31]	=	{1'b1,8'h8d}; 
			reg_init[32]	=	{1'b1,8'hee}; 
			reg_init[32]	=	{1'b0,8'hc5}; 
			reg_init[33]	=	{1'b1,8'h1a}; 
			reg_init[34]	=	{1'b0,8'h36}; 
			reg_init[35]	=	{1'b1,8'hc0}; 
			reg_init[36]	=	{1'b0,8'he0}; 
			reg_init[37]	=	{1'b1,8'h04}; 
			reg_init[38]	=	{1'b1,8'h22}; 
			reg_init[39]	=	{1'b1,8'h07}; 
			reg_init[40]	=	{1'b1,8'h0a}; 
			reg_init[41]	=	{1'b1,8'h2e}; 
			reg_init[42]	=	{1'b1,8'h30}; 
			reg_init[43]	=	{1'b1,8'h25}; 
			reg_init[44]	=	{1'b1,8'h2a}; 
			reg_init[45]	=	{1'b1,8'h28}; 
			reg_init[46]	=	{1'b1,8'h26}; 
			reg_init[47]	=	{1'b1,8'h2e}; 
			reg_init[48]	=	{1'b1,8'h3a}; 
			reg_init[49]	=	{1'b1,8'h00}; 
			reg_init[50]	=	{1'b1,8'h01}; 
			reg_init[51]	=	{1'b1,8'h03}; 
			reg_init[52]	=	{1'b1,8'h13}; 
			reg_init[53]	=	{1'b0,8'he1}; 
			reg_init[54]	=	{1'b1,8'h04}; 
			reg_init[55]	=	{1'b1,8'h16}; 
			reg_init[56]	=	{1'b1,8'h06}; 
			reg_init[57]	=	{1'b1,8'h0d}; 
			reg_init[58]	=	{1'b1,8'h2d}; 
			reg_init[59]	=	{1'b1,8'h26}; 
			reg_init[60]	=	{1'b1,8'h23}; 
			reg_init[61]	=	{1'b1,8'h27}; 
			reg_init[62]	=	{1'b1,8'h27}; 
			reg_init[63]	=	{1'b1,8'h25}; 
			reg_init[64]	=	{1'b1,8'h2d}; 
			reg_init[65]	=	{1'b1,8'h3b}; 
			reg_init[66]	=	{1'b1,8'h00}; 
			reg_init[67]	=	{1'b1,8'h01}; 
			reg_init[68]	=	{1'b1,8'h04}; 
			reg_init[69]	=	{1'b1,8'h13}; 
			reg_init[70]	=	{1'b0,8'h3a}; 
			reg_init[71]	=	{1'b1,8'h05}; 
			reg_init[72]	=	{1'b0,8'h29}; 
		end
 
endmodule