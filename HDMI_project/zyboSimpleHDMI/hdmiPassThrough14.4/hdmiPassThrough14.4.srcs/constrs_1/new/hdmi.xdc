set_property PACKAGE_PIN C20 [get_ports {HDMI_D_P[1]}]
set_property PACKAGE_PIN D19 [get_ports {HDMI_D_P[0]}]
set_property PACKAGE_PIN B19 [get_ports {HDMI_D_P[2]}]
set_property PACKAGE_PIN H16 [get_ports HDMI_CLK_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_CLK_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_CLK_N]
set_property PACKAGE_PIN E18 [get_ports HDMI_HPD]
set_property PACKAGE_PIN F17 [get_ports HDMI_OUT_EN]
#set_property PACKAGE_PIN G17 [get_ports HDMI_SCL]
#set_property PACKAGE_PIN G18 [get_ports HDMI_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_HPD]
set_property IOSTANDARD LVCMOS33 [get_ports HDMI_OUT_EN]
#set_property IOSTANDARD LVCMOS33 [get_ports HDMI_SCL]
#set_property IOSTANDARD LVCMOS33 [get_ports HDMI_SDA]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[0]}]
set_property SLEW FAST [get_ports {VGA_B[4]}]
set_property SLEW FAST [get_ports {VGA_B[3]}]
set_property SLEW FAST [get_ports {VGA_B[2]}]
set_property SLEW FAST [get_ports {VGA_B[1]}]
set_property SLEW FAST [get_ports {VGA_B[0]}]
set_property SLEW FAST [get_ports {VGA_G[5]}]
set_property SLEW FAST [get_ports {VGA_G[4]}]
set_property SLEW FAST [get_ports {VGA_G[3]}]
set_property SLEW FAST [get_ports {VGA_G[2]}]
set_property SLEW FAST [get_ports {VGA_G[1]}]
set_property SLEW FAST [get_ports {VGA_G[0]}]
set_property SLEW FAST [get_ports {VGA_R[4]}]
set_property SLEW FAST [get_ports {VGA_R[3]}]
set_property SLEW FAST [get_ports {VGA_R[2]}]
set_property SLEW FAST [get_ports {VGA_R[1]}]
set_property SLEW FAST [get_ports {VGA_R[0]}]
set_property PACKAGE_PIN G19 [get_ports {VGA_B[4]}]
set_property PACKAGE_PIN J18 [get_ports {VGA_B[3]}]
set_property PACKAGE_PIN K19 [get_ports {VGA_B[2]}]
set_property PACKAGE_PIN M20 [get_ports {VGA_B[1]}]
set_property PACKAGE_PIN P20 [get_ports {VGA_B[0]}]
set_property PACKAGE_PIN F20 [get_ports {VGA_G[5]}]
set_property PACKAGE_PIN H20 [get_ports {VGA_G[4]}]
set_property PACKAGE_PIN J19 [get_ports {VGA_G[3]}]
set_property PACKAGE_PIN L19 [get_ports {VGA_G[2]}]
set_property PACKAGE_PIN N20 [get_ports {VGA_G[1]}]
set_property PACKAGE_PIN H18 [get_ports {VGA_G[0]}]
set_property PACKAGE_PIN F19 [get_ports {VGA_R[4]}]
set_property PACKAGE_PIN G20 [get_ports {VGA_R[3]}]
set_property PACKAGE_PIN J20 [get_ports {VGA_R[2]}]
set_property PACKAGE_PIN L20 [get_ports {VGA_R[1]}]
set_property PACKAGE_PIN M19 [get_ports {VGA_R[0]}]

create_clock -period 25.000 -name hdmi -waveform {0.000 12.500} [get_ports HDMI_CLK_P]

set_property PACKAGE_PIN P19 [get_ports VGA_HS]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_HS]
set_property SLEW FAST [get_ports VGA_HS]
set_property SLEW FAST [get_ports VGA_VS]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_VS]
set_property PACKAGE_PIN R19 [get_ports VGA_VS]

set_property PACKAGE_PIN G15 [get_ports BTN]
set_property IOSTANDARD LVCMOS33 [get_ports BTN]

set_property OFFCHIP_TERM NONE [get_ports HDMI_HPD]
set_property OFFCHIP_TERM NONE [get_ports HDMI_OUT_EN]
set_property OFFCHIP_TERM NONE [get_ports VGA_B[0]]
set_property OFFCHIP_TERM NONE [get_ports VGA_B[1]]
set_property OFFCHIP_TERM NONE [get_ports VGA_B[2]]
set_property OFFCHIP_TERM NONE [get_ports VGA_B[3]]
set_property OFFCHIP_TERM NONE [get_ports VGA_B[4]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[0]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[1]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[2]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[3]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[4]]
set_property OFFCHIP_TERM NONE [get_ports VGA_G[5]]
set_property OFFCHIP_TERM NONE [get_ports VGA_HS]
set_property OFFCHIP_TERM NONE [get_ports VGA_R[0]]
set_property OFFCHIP_TERM NONE [get_ports VGA_R[1]]
set_property OFFCHIP_TERM NONE [get_ports VGA_R[2]]
set_property OFFCHIP_TERM NONE [get_ports VGA_R[3]]
set_property OFFCHIP_TERM NONE [get_ports VGA_R[4]]
set_property OFFCHIP_TERM NONE [get_ports VGA_VS]