`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Josh Sackos
// 
// Create Date:    07/11/2012
// Module Name:    PmodJSTK_Demo 
// Project Name: 	 PmodJSTK_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This is a demo for the Digilent PmodJSTK. Data is sent and received
//					 to and from the PmodJSTK at a frequency of 5Hz, and positional 
//					 data is displayed on the seven segment display (SSD). The positional
//					 data of the joystick ranges from 0 to 1023 in both the X and Y
//					 directions. Only one coordinate can be displayed on the SSD at a
//					 time, therefore switch SW0 is used to select which coordinate's data
//	   			 to display. The status of the buttons on the PmodJSTK are
//					 displayed on LD2, LD1, and LD0 on the Nexys3. The LEDs will
//					 illuminate when a button is pressed. Switches SW2 and SW1 on the
//					 Nexys3 will turn on LD1 and LD2 on the PmodJSTK respectively. Button
//					 BTND on the Nexys3 is used for resetting the demo. The PmodJSTK
//					 connects to pins [4:1] on port JA on the Nexys3. SPI mode 0 is used
//					 for communication between the PmodJSTK and the Nexys3.
//
//					 NOTE: The digits on the SSD may at times appear to flicker, this
//						    is due to small pertebations in the positional data being read
//							 by the PmodJSTK's ADC. To reduce the flicker simply reduce
//							 the rate at which the data being displayed is updated.
//
// Revision History: 
// 						Revision 0.01 - File Created (Josh Sackos)
//////////////////////////////////////////////////////////////////////////////////


// ============================================================================== 
// 										  Define Module
// ==============================================================================
module joystick_top(
    input wire clk, // 100Mhz onboard clock
    input wire rst, // Button D
    input wire joystick_MISO, // Master In Slave Out, Pin 3, Port JA
    output joystick_SS, // Slave Select, Pin 1, Port JA
    output joystick_MOSI, // Master Out Slave In, Pin 2, Port JA
    output joystick_SCLK, // Serial Clock, Pin 4, Port JA
	output pressed,
	output up,
	output down,
	output left,
	output right
);

	// Holds data to be sent to PmodJSTK
	wire [7:0] sndData;

	// Signal to send/receive data to/from PmodJSTK
	wire sndRec;

	// Data read from PmodJSTK
	wire [39:0] jstkData;

	// ===========================================================================
	// 										Implementation
	// ===========================================================================


			//-----------------------------------------------
			//  	  			PmodJSTK Interface
			//-----------------------------------------------
			PmodJSTK PmodJSTK_Int(
					.CLK(clk),
					.RST(rst),
					.sndRec(sndRec),
					.DIN(sndData),
					.MISO(joystick_MISO),
					.SS(joystick_SS),
					.SCLK(joystick_SCLK),
					.MOSI(joystick_MOSI),
					.DOUT(jstkData)
			);
			
			
			one_pulse pressed_pulse(
				.clk(clk),
				.pb_in(jstkData[0]),
				.pb_out(pressed)
			);

			// select direction
			wire up_pb, down_pb, left_pb, right_pb;
			one_pulse up_pulse(.clk(clk), .pb_in(up_pb), .pb_out(up));
			one_pulse down_pulse(.clk(clk), .pb_in(down_pb), .pb_out(down));
			one_pulse left_pulse(.clk(clk), .pb_in(left_pb), .pb_out(left));
			one_pulse right_pulse(.clk(clk), .pb_in(right_pb), .pb_out(right));

			// X
			assign right_pb = ({jstkData[23:16]} > 8'd800) ? 1'b1 : 1'b0;
			assign left_pb = ({jstkData[23:16]} < 8'd200) ? 1'b1 : 1'b0;

			// Y
			assign up_pb = ({jstkData[39:32]} > 8'd800) ? 1'b1 : 1'b0;
			assign down_pb = ({jstkData[39:32]} < 8'd200) ? 1'b1 : 1'b0;
			

			// Data to be sent to PmodJSTK, lower two bits will turn on leds on PmodJSTK
			assign sndData = {8'b100000, {0, 0}};
endmodule
