`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Andrew Skreen
// 
// Create Date:    08/16/2011
// Module Name:    PmodGYRO_Demo
// Project Name: 	 PmodGYRO_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This demo configures the PmodGYRO to output data at a rate of 100 Hz
// 				 with 8.75 mdps/digit at 250 dps maximum.  SPI mode 3 is used for data
//					 communication with the PmodGYRO.
//
//					 Switches SW3 and SW2 are used to select temperature or axis data that is 
//					 to be displayed on the seven segment display (SSD).  For details about
//					 selecting data see below.
//
//						SW3  |  SW2  |  Display Data
//						----------------------------
//						 0   |   0   |  X axis data
//						 0	  |   1   |  Y axis data
//						 1   |   0   |  Z axis data
//						 1   |   1   |  Temperature
//
//  Inputs:
//		clk 						Base system clock of 100 MHz
//		sw[0]						Reset signal
//		sw[1] 					start tied to external user input
//		sw[2]						Data select bit 0
//		sw[3]						Data select bit 1
//		sw[4]						Select hex display or decimal display
//		JA[2] 					Master in slave out (MISO)
//		
//  Outputs:
//		JA[0]						Slave select (SS)
//		JA[1]						Master out slave in (MOSI)
//		JA[3]						Serial clock (SCLK)
//		seg						Cathodes on SSD
//		dp							Decimal on SSD
//		an							Anodes on SSD
//
// Revision History: 
// 						Revision 0.01 - File Created (Andrew Skreen)
//							Revision 1.00 - Added Comments and Converted to Verilog (Josh Sackos)
// 		   +x
// 	      ----
//        |. |
// -y <---|. |--> +y
//        |  |
//        |  |
//        ----
// 		   -x
//////////////////////////////////////////////////////////////////////////////////////////

// ==============================================================================
// 										  Define Module
// ==============================================================================
module PmodGYRO_Demo(
		sw,
		clk,
		an,
		seg,
		dp,
		JA,
		x_data,
		awaking
);

// ==============================================================================
// 										Port Declarations
// ==============================================================================
   input [4:0]  sw;
   input        clk;
   output [3:0] an;
   output [6:0] seg;
   output       dp;
   inout [3:0]  JA;
   output [14:0] x_data;
   output awaking;
   
// ==============================================================================
// 							  Parameters, Registers, and Wires
// ==============================================================================   
   wire         begin_transmission;
   wire         end_transmission;
   wire [7:0]   send_data;
   wire [7:0]   recieved_data;
   wire [7:0]   temp_data;
   wire [15:0]  x_axis_data;
   wire [15:0]  y_axis_data;
   wire [15:0]  z_axis_data;
   wire         slave_select;
   wire [15:0] y_data;
   wire [15:0] z_data;
   
// ==============================================================================
// 							  		   Implementation
// ==============================================================================      

			//--------------------------------------
			//		Serial Port Interface Controller
			//--------------------------------------
			master_interface C0(
						.begin_transmission(begin_transmission),
						.end_transmission(end_transmission),
						.send_data(send_data),
						.recieved_data(recieved_data),
						.clk(clk),
						.rst(sw[0]),
						.slave_select(slave_select),
						.start(sw[1]),
						.temp_data(temp_data),
						.x_axis_data(x_axis_data),
						.y_axis_data(y_axis_data),
						.z_axis_data(z_axis_data)
			);
   
   
			//--------------------------------------
			//		    Serial Port Interface
			//--------------------------------------
			spi_interface C1(
						.begin_transmission(begin_transmission),
						.slave_select(slave_select),
						.send_data(send_data),
						.recieved_data(recieved_data),
						.miso(JA[2]),
						.clk(clk),
						.rst(sw[0]),
						.end_transmission(end_transmission),
						.mosi(JA[1]),
						.sclk(JA[3])
			);


			//--------------------------------------
			//		      Display Controller
			//--------------------------------------
			display_controller C2(
						.clk(clk),
						.rst(sw[0]),
						.sel(sw[3:2]),
						.temp_data(temp_data),
						.x_axis(x_axis_data[15:0]),
						.y_axis(y_axis_data[15:0]),
						.z_axis(z_axis_data[15:0]),
						.dp(dp),
						.an(an),
						.seg(seg),
						.display_sel(sw[4])
			);

			//  Assign slave select output
			assign JA[0] = slave_select;
			wire [15:0] tmp;
			assign awaking = (tmp[11] == 1) ? 1 : 0;
			assign x_data = tmp[14:0];
			data_transform trans(
				.x_axis_data(x_axis_data),
				.y_axis_data(y_axis_data),
				.z_axis_data(z_axis_data),
				.x_data(tmp),
				.y_data(y_data),
				.z_data(z_data)
			);
   
endmodule
