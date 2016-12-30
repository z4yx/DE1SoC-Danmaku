#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 13.1.0 Build 162 10/23/2013 SJ Full Version
#
#************************************************************

# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.



# Clock constraints

create_clock -name "clock_50_1" -period 20.000ns [get_ports {CLOCK_50}]
create_clock -name "clock_50_2" -period 20.000ns [get_ports {CLOCK2_50}]
create_clock -name "clock_50_3" -period 20.000ns [get_ports {CLOCK3_50}]
create_clock -name "clock_50_4" -period 20.000ns [get_ports {CLOCK4_50}]
create_clock -name "clock_27_1" -period 37.000ns [get_ports {TD_CLK27}]

create_clock -name {pixel_clock_in} -period 6.000 [get_ports {GPIO_0[24]}]
create_clock -name {pixel_clock} -period 6.000 
create_clock -name {VGA_CLK} -period 6.000  [get_ports {VGA_CLK}]
#create_clock -name {VGA_CLK} -period 6.000

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[0]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[1]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[2]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[3]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[4]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[5]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[6]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[7]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[8]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[9]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[10]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[11]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[12]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[13]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[14]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[15]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[16]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[17]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[18]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[19]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[20]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[21]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[22]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[23]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[26]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[27]}]
set_input_delay   -clock [get_clocks {pixel_clock}]  1.500 [get_ports {GPIO_0[28]}]

set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_BLANK_N}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_BLANK_N}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[0]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[0]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[1]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[1]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[2]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[2]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[3]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[3]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[4]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[4]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[5]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[5]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[6]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[6]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_B[7]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_B[7]}]
#set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_CLK}]
#set_output_delay  -min -clock [get_clocks {VGA_CLK}]  1.500 [get_ports {VGA_CLK}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[0]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[0]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[1]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[1]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[2]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[2]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[3]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[3]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[4]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[4]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[5]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[5]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[6]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[6]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_G[7]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_G[7]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_HS}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_HS}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[0]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[0]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[1]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[1]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[2]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[2]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[3]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[3]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[4]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[4]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[5]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[5]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[6]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[6]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_R[7]}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_R[7]}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_SYNC_N}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_SYNC_N}]
set_output_delay  -max -clock [get_clocks {VGA_CLK}]  0.5 [get_ports {VGA_VS}]
set_output_delay  -min -clock [get_clocks {VGA_CLK}]  -1.500 [get_ports {VGA_VS}]