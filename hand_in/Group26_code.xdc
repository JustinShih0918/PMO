## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
##   (if you are using the editor in Vivado, you can select lines and hit "Ctrl + /" to comment/uncomment.)
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Switches
# set_property PACKAGE_PIN V17 [get_ports {enable}]
# set_property IOSTANDARD LVCMOS33 [get_ports {enable}]
#set_property PACKAGE_PIN V16 [get_ports {motor_l_enable}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_l_enable}]
#set_property PACKAGE_PIN W16 [get_ports {motor_l_dir}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_l_dir}]
#set_property PACKAGE_PIN W17 [get_ports {motor_r_enable}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_r_enable}]
#set_property PACKAGE_PIN W15 [get_ports {motor_r_dir}]
#set_property IOSTANDARD LVCMOS33 [get_ports {motor_r_dir}]
# set_property PACKAGE_PIN V15 [get_ports {relay_enable}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {relay_enable}]
# set_property PACKAGE_PIN W14 [get_ports {cur_state[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {cur_state[0]}]
# set_property PACKAGE_PIN W13 [get_ports {cur_state[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {cur_state[1]}]
# set_property PACKAGE_PIN V2 [get_ports {sw[8]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
# set_property PACKAGE_PIN T3 [get_ports {sw[9]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
# set_property PACKAGE_PIN T2 [get_ports {sw[10]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
# set_property PACKAGE_PIN R3 [get_ports {sw[11]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
# set_property PACKAGE_PIN W2 [get_ports {sw[12]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
# set_property PACKAGE_PIN U1 [get_ports {sw[13]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
# set_property PACKAGE_PIN T1 [get_ports {sw[14]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
# set_property PACKAGE_PIN R2 [get_ports {sw[15]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]


# # LEDs
set_property PACKAGE_PIN U16 [get_ports {awaking_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {awaking_de}]
set_property PACKAGE_PIN E19 [get_ports {touched_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {touched_de}]
set_property PACKAGE_PIN U19 [get_ports {expecting_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {expecting_de}]
set_property PACKAGE_PIN V19 [get_ports {pressed_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {pressed_de}]
set_property PACKAGE_PIN W18 [get_ports {up_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {up_de}]
set_property PACKAGE_PIN U15 [get_ports {down_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {down_de}]
set_property PACKAGE_PIN U14 [get_ports {left_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {left_de}]
set_property PACKAGE_PIN V14 [get_ports {right_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {right_de}]
set_property PACKAGE_PIN V13 [get_ports {petting_de}]
set_property IOSTANDARD LVCMOS33 [get_ports {petting_de}]
# set_property PACKAGE_PIN V3 [get_ports {ram_lcd_addr[2]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[2]}]
# set_property PACKAGE_PIN W3 [get_ports {ram_lcd_addr[3]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[3]}]
# set_property PACKAGE_PIN U3 [get_ports {ram_lcd_addr[4]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[4]}]
# set_property PACKAGE_PIN P3 [get_ports {ram_lcd_addr[5]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[5]}]
# set_property PACKAGE_PIN N3 [get_ports {ram_lcd_addr[6]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[6]}]
# set_property PACKAGE_PIN P1 [get_ports {ram_lcd_addr[7]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[7]}]
# set_property PACKAGE_PIN L1 [get_ports {ram_lcd_addr[8]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {ram_lcd_addr[8]}]

# 7 segment display
#  set_property PACKAGE_PIN W7 [get_ports {display[0]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}]
#  set_property PACKAGE_PIN W6 [get_ports {display[1]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}]
#  set_property PACKAGE_PIN U8 [get_ports {display[2]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}]
#  set_property PACKAGE_PIN V8 [get_ports {display[3]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}]
#  set_property PACKAGE_PIN U5 [get_ports {display[4]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}]
#  set_property PACKAGE_PIN V5 [get_ports {display[5]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}]
#  set_property PACKAGE_PIN U7 [get_ports {display[6]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}]

# set_property PACKAGE_PIN V7 [get_ports dp]
#    set_property IOSTANDARD LVCMOS33 [get_ports dp]

#  set_property PACKAGE_PIN U2 [get_ports {digit[0]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
#  set_property PACKAGE_PIN U4 [get_ports {digit[1]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
#  set_property PACKAGE_PIN V4 [get_ports {digit[2]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
#  set_property PACKAGE_PIN W4 [get_ports {digit[3]}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]
#=============================================


# Buttons
 set_property PACKAGE_PIN U18 [get_ports rst]
    set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN T18 [get_ports go]
   set_property IOSTANDARD LVCMOS33 [get_ports go]
# set_property PACKAGE_PIN W19 [get_ports btnL]
#    set_property IOSTANDARD LVCMOS33 [get_ports btnL]
# set_property PACKAGE_PIN T17 [get_ports btnR]
#    set_property IOSTANDARD LVCMOS33 [get_ports btnR]
# set_property PACKAGE_PIN U17 [get_ports btn_down]
#    set_property IOSTANDARD LVCMOS33 [get_ports btn_down]



## Pmod Header JA
## Sch name = JA1
 set_property PACKAGE_PIN J1 [get_ports {joystick_SS}]
    set_property IOSTANDARD LVCMOS33 [get_ports {joystick_SS}]
# Sch name = JA2
 set_property PACKAGE_PIN L2 [get_ports {joystick_MOSI}]
    set_property IOSTANDARD LVCMOS33 [get_ports {joystick_MOSI}]
# Sch name = JA3
 set_property PACKAGE_PIN J2 [get_ports {joystick_MISO}]
    set_property IOSTANDARD LVCMOS33 [get_ports {joystick_MISO}]
# Sch name = JA4
 set_property PACKAGE_PIN G2 [get_ports {joystick_SCLK}]
    set_property IOSTANDARD LVCMOS33 [get_ports {joystick_SCLK}]
# # Sch name = JA7
#  set_property PACKAGE_PIN H1 [get_ports {gyro_ss}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {gyro_ss}]
# # Sch name = JA8
#  set_property PACKAGE_PIN K2 [get_ports {gyro_MOSI}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MOSI}]
# # Sch name = JA9
# set_property PACKAGE_PIN H2 [get_ports {gyro_MISO}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MISO}]
# # Sch name = JA10
# set_property PACKAGE_PIN G3 [get_ports {gyro_SCLK}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {gyro_SCLK}]



## Pmod Header JB
## Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {lcd_clk_out}]
   set_property IOSTANDARD LVCMOS33 [get_ports {lcd_clk_out}]
## Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {lcd_data_out}]
   set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data_out}]
## Sch name = JB3
 set_property PACKAGE_PIN B15 [get_ports {lcd_rst_n_out}]
    set_property IOSTANDARD LVCMOS33 [get_ports {lcd_rst_n_out}]
## Sch name = JB4
 set_property PACKAGE_PIN B16 [get_ports {lcd_dc_out}]
    set_property IOSTANDARD LVCMOS33 [get_ports {lcd_dc_out}]
## Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {lcd_cs_n_out}]
   set_property IOSTANDARD LVCMOS33 [get_ports {lcd_cs_n_out}]
## Sch name = JB8
 set_property PACKAGE_PIN A17 [get_ports {lcd_bl_out}]
    set_property IOSTANDARD LVCMOS33 [get_ports {lcd_bl_out}]
## Sch name = JB9
#  set_property PACKAGE_PIN C15 [get_ports {mid_track}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {mid_track}]
## Sch name = JB10
#  set_property PACKAGE_PIN C16 [get_ports {left_track}]
#     set_property IOSTANDARD LVCMOS33 [get_ports {left_track}]



## Pmod Header JC
## Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {touch1}]
   set_property IOSTANDARD LVCMOS33 [get_ports {touch1}]
# Sch name = JC2
# set_property PACKAGE_PIN M18 [get_ports {touch2}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {touch2}]
# Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {Echo}]
   set_property IOSTANDARD LVCMOS33 [get_ports {Echo}]
# Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {Trig}]
   set_property IOSTANDARD LVCMOS33 [get_ports {Trig}]
# Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {touch2}]
   set_property IOSTANDARD LVCMOS33 [get_ports {touch2}]
# # Sch name = JC8
# set_property PACKAGE_PIN M19 [get_ports {JC[5]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {JC[5]}]
## Sch name = JC9
# set_property PACKAGE_PIN P17 [get_ports {JC[6]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {JC[6]}]
## Sch name = JC10
# set_property PACKAGE_PIN R18 [get_ports {JC[7]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]


## Pmod Header JXADC
# # Sch name = XA1_P
# set_property PACKAGE_PIN J3 [get_ports {gyro_ss}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {gyro_ss}]
# # Sch name = XA2_P
# set_property PACKAGE_PIN L3 [get_ports {gyro_MOSI}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MOSI}]
# # Sch name = XA3_P
# set_property PACKAGE_PIN M2 [get_ports {gyro_MISO}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MISO}]
# # Sch name = XA4_P
# set_property PACKAGE_PIN N2 [get_ports {gyro_SCLK}]
#   set_property IOSTANDARD LVCMOS33 [get_ports {gyro_SCLK}]
#   set_property PULLUP true [get_ports ble_rx]
# Sch name = XA1_N
set_property PACKAGE_PIN K3 [get_ports {gyro_ss}]
   set_property IOSTANDARD LVCMOS33 [get_ports {gyro_ss}]
# Sch name = XA2_N
set_property PACKAGE_PIN M3 [get_ports {gyro_MOSI}]
   set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MOSI}]
# Sch name = XA3_N
set_property PACKAGE_PIN M1 [get_ports {gyro_MISO}]
   set_property IOSTANDARD LVCMOS33 [get_ports {gyro_MISO}]
# Sch name = XA4_N
set_property PACKAGE_PIN N1 [get_ports {gyro_SCLK}]
   set_property IOSTANDARD LVCMOS33 [get_ports {gyro_SCLK}]



## VGA Connector
# set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
# set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
# set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
# set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
# set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
# set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
# set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
# set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
# set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
# set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
# set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
# set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
# set_property PACKAGE_PIN P19 [get_ports hsync]
#    set_property IOSTANDARD LVCMOS33 [get_ports hsync]
# set_property PACKAGE_PIN R19 [get_ports vsync]
#    set_property IOSTANDARD LVCMOS33 [get_ports vsync]


## USB-RS232 Interface
# set_property PACKAGE_PIN B18 [get_ports RsRx]
#    set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
# set_property PACKAGE_PIN A18 [get_ports RsTx]
#    set_property IOSTANDARD LVCMOS33 [get_ports RsTx]


## USB HID (PS/2)
# set_property PACKAGE_PIN C17 [get_ports PS2_CLK]
#    set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
#    set_property PULLUP true [get_ports PS2_CLK]
# set_property PACKAGE_PIN B17 [get_ports PS2_DATA]
#    set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]
#    set_property PULLUP true [get_ports PS2_DATA]


## Quad SPI Flash
## Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
## STARTUPE2 primitive.
# set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
# set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
# set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
# set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
# set_property PACKAGE_PIN K19 [get_ports QspiCSn]
#    set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]

## Don't Touch
# set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
# set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
# set_property CONFIG_MODE SPIx4 [current_design]
# set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

## where 3.3 is the voltage provided to configuration bank 0
set_property CONFIG_VOLTAGE 3.3 [current_design]
## where value1 is either VCCO(for Vdd=3.3) or GND(for Vdd=1.8)
set_property CFGBVS VCCO [current_design]

#set_property PACKAGE_PIN V16 [get_ports speed]
#set_property IOSTANDARD LVCMOS33 [get_ports speed]
#set_property PACKAGE_PIN V16 [get_ports dir]
#set_property IOSTANDARD LVCMOS33 [get_ports dir]
#set_property PACKAGE_PIN V17 [get_ports en]
#set_property IOSTANDARD LVCMOS33 [get_ports en]
#set_property PACKAGE_PIN W16 [get_ports rst]
#set_property IOSTANDARD LVCMOS33 [get_ports rst]




