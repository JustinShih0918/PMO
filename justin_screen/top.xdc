## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
##   (if you are using the editor in Vivado, you can select lines and hit "Ctrl + /" to comment/uncomment.)
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# Buttons
 set_property PACKAGE_PIN U18 [get_ports rst]
    set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN T18 [get_ports go]
   set_property IOSTANDARD LVCMOS33 [get_ports go]

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
# # Sch name = XA1_N
# set_property PACKAGE_PIN K3 [get_ports {Echo}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {Echo}]
# # Sch name = XA2_N
# set_property PACKAGE_PIN M3 [get_ports {Trig}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {Trig}]
## Sch name = XA3_N
# set_property PACKAGE_PIN M1 [get_ports {JXADC[6]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
## Sch name = XA4_N
# set_property PACKAGE_PIN N1 [get_ports {JXADC[7]}]
#    set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]



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




