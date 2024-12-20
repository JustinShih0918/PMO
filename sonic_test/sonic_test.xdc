# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

# rst
 set_property PACKAGE_PIN U18 [get_ports rst]
    set_property IOSTANDARD LVCMOS33 [get_ports rst]

# 7 segment Display
 set_property PACKAGE_PIN W7 [get_ports {Display[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[0]}]
 set_property PACKAGE_PIN W6 [get_ports {Display[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[1]}]
 set_property PACKAGE_PIN U8 [get_ports {Display[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[2]}]
 set_property PACKAGE_PIN V8 [get_ports {Display[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[3]}]
 set_property PACKAGE_PIN U5 [get_ports {Display[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[4]}]
 set_property PACKAGE_PIN V5 [get_ports {Display[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[5]}]
 set_property PACKAGE_PIN U7 [get_ports {Display[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Display[6]}]

 set_property PACKAGE_PIN U2 [get_ports {Digit[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[0]}]
 set_property PACKAGE_PIN U4 [get_ports {Digit[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[1]}]
 set_property PACKAGE_PIN V4 [get_ports {Digit[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[2]}]
 set_property PACKAGE_PIN W4 [get_ports {Digit[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Digit[3]}]
 
# sonic sensor
 set_property PACKAGE_PIN A14 [get_ports {Trig}]
    set_property IOSTANDARD LVCMOS33 [get_ports {Trig}]
 set_property PACKAGE_PIN A16 [get_ports {echo}]
    set_property IOSTANDARD LVCMOS33 [get_ports {echo}]