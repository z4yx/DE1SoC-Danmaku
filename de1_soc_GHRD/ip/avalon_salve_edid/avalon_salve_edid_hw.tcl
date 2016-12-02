# +-----------------------------------
# | module avalon_slave_edid
# | 
set_module_property DESCRIPTION "EDID Memory"
set_module_property NAME avalon_slave_edid
set_module_property VERSION 1.1
set_module_property GROUP Templates
set_module_property AUTHOR JCJB
set_module_property ICON_PATH ALTERA_LOGO_ANIM.gif
set_module_property DISPLAY_NAME avalon_slave_edid
set_module_property TOP_LEVEL_HDL_FILE avalon_slave_edid.v
set_module_property TOP_LEVEL_HDL_MODULE avalon_slave_edid
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property SIMULATION_MODEL_IN_VERILOG false
set_module_property SIMULATION_MODEL_IN_VHDL false
set_module_property SIMULATION_MODEL_HAS_TULIPS false
set_module_property SIMULATION_MODEL_IS_OBFUSCATED false
# | 
# +-----------------------------------


set_module_property ELABORATION_CALLBACK    elaborate_me


# +-----------------------------------
# | files
# | 
add_file avalon_slave_edid.v {SYNTHESIS SIMULATION}
add_file i2cSlave.v {SYNTHESIS SIMULATION}
add_file i2cSlave_define.v {SYNTHESIS SIMULATION}
add_file serialInterface.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
add_parameter DATA_WIDTH int 8 "Width of each input or output"
set_parameter_property DATA_WIDTH DISPLAY_NAME "Word Size"
set_parameter_property DATA_WIDTH GROUP "Register File Properties"
set_parameter_property DATA_WIDTH AFFECTS_PORT_WIDTHS true
set_parameter_property DATA_WIDTH ALLOWED_RANGES {8}

# add_parameter ENABLE_SYNC_SIGNALS int 0 "Output syncronization signals"
# set_parameter_property ENABLE_SYNC_SIGNALS DISPLAY_NAME "Syncronization signals"
# set_parameter_property ENABLE_SYNC_SIGNALS GROUP "Register File Properties"
# set_parameter_property ENABLE_SYNC_SIGNALS AFFECTS_PORT_WIDTHS true
# set_parameter_property ENABLE_SYNC_SIGNALS ALLOWED_RANGES { "0:Disabled" "1:Enabled" }

# add_parameter MODE_0 int 2 "Set the read/write capabilites of the register pair 0"
# set_parameter_property MODE_0 DISPLAY_NAME "Register 0 capabilites"
# set_parameter_property MODE_0 GROUP "Register File"
# set_parameter_property MODE_0 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_0 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_1 int 2 "Set the read/write capabilites of the register pair 1"
# set_parameter_property MODE_1 DISPLAY_NAME "Register 1 capabilites"
# set_parameter_property MODE_1 GROUP "Register File"
# set_parameter_property MODE_1 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_1 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_2 int 2 "Set the read/write capabilites of the register pair 2"
# set_parameter_property MODE_2 DISPLAY_NAME "Register 2 capabilites"
# set_parameter_property MODE_2 GROUP "Register File"
# set_parameter_property MODE_2 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_2 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_3 int 2 "Set the read/write capabilites of the register pair 3"
# set_parameter_property MODE_3 DISPLAY_NAME "Register 3 capabilites"
# set_parameter_property MODE_3 GROUP "Register File"
# set_parameter_property MODE_3 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_3 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_4 int 2 "Set the read/write capabilites of the register pair 4"
# set_parameter_property MODE_4 DISPLAY_NAME "Register 4 capabilites"
# set_parameter_property MODE_4 GROUP "Register File"
# set_parameter_property MODE_4 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_4 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_5 int 2 "Set the read/write capabilites of the register pair 5"
# set_parameter_property MODE_5 DISPLAY_NAME "Register 5 capabilites"
# set_parameter_property MODE_5 GROUP "Register File"
# set_parameter_property MODE_5 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_5 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_6 int 2 "Set the read/write capabilites of the register pair 6"
# set_parameter_property MODE_6 DISPLAY_NAME "Register 6 capabilites"
# set_parameter_property MODE_6 GROUP "Register File"
# set_parameter_property MODE_6 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_6 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_7 int 2 "Set the read/write capabilites of the register pair 7"
# set_parameter_property MODE_7 DISPLAY_NAME "Register 7 capabilites"
# set_parameter_property MODE_7 GROUP "Register File"
# set_parameter_property MODE_7 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_7 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_8 int 2 "Set the read/write capabilites of the register pair 8"
# set_parameter_property MODE_8 DISPLAY_NAME "Register 8 capabilites"
# set_parameter_property MODE_8 GROUP "Register File"
# set_parameter_property MODE_8 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_8 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_9 int 2 "Set the read/write capabilites of the register pair 9"
# set_parameter_property MODE_9 DISPLAY_NAME "Register 9 capabilites"
# set_parameter_property MODE_9 GROUP "Register File"
# set_parameter_property MODE_9 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_9 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_10 int 2 "Set the read/write capabilites of the register pair 10"
# set_parameter_property MODE_10 DISPLAY_NAME "Register 10 capabilites"
# set_parameter_property MODE_10 GROUP "Register File"
# set_parameter_property MODE_10 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_10 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_11 int 2 "Set the read/write capabilites of the register pair 11"
# set_parameter_property MODE_11 DISPLAY_NAME "Register 11 capabilites"
# set_parameter_property MODE_11 GROUP "Register File"
# set_parameter_property MODE_11 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_11 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_12 int 2 "Set the read/write capabilites of the register pair 12"
# set_parameter_property MODE_12 DISPLAY_NAME "Register 12 capabilites"
# set_parameter_property MODE_12 GROUP "Register File"
# set_parameter_property MODE_12 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_12 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_13 int 2 "Set the read/write capabilites of the register pair 13"
# set_parameter_property MODE_13 DISPLAY_NAME "Register 13 capabilites"
# set_parameter_property MODE_13 GROUP "Register File"
# set_parameter_property MODE_13 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_13 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_14 int 2 "Set the read/write capabilites of the register pair 14"
# set_parameter_property MODE_14 DISPLAY_NAME "Register 14 capabilites"
# set_parameter_property MODE_14 GROUP "Register File"
# set_parameter_property MODE_14 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_14 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }

# add_parameter MODE_15 int 2 "Set the read/write capabilites of the register pair 15"
# set_parameter_property MODE_15 DISPLAY_NAME "Register 15 capabilites"
# set_parameter_property MODE_15 GROUP "Register File"
# set_parameter_property MODE_15 AFFECTS_PORT_WIDTHS true
# set_parameter_property MODE_15 ALLOWED_RANGES { "0:Write Only" "1:Read Only" "2:Write/Read" "3:Write with Loopback" "4:Disabled" }
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock_reset
# | 
add_interface clock_reset clock end
set_interface_property clock_reset ptfSchematicName ""

add_interface_port clock_reset clk clk Input 1
add_interface_port clock_reset reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s0
# | 
add_interface s0 avalon end
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 minimumUninterruptedRunLength 1
set_interface_property s0 bridgesToMaster ""
set_interface_property s0 isMemoryDevice false
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 addressSpan 256
set_interface_property s0 timingUnits Cycles
set_interface_property s0 setupTime 0
set_interface_property s0 writeWaitTime 0
set_interface_property s0 isNonVolatileStorage false
set_interface_property s0 addressAlignment DYNAMIC
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 readWaitTime 0
set_interface_property s0 readLatency 3
set_interface_property s0 printableDevice false

set_interface_property s0 ASSOCIATED_CLOCK clock_reset

add_interface_port s0 slave_address address Input 8
add_interface_port s0 slave_read read Input 1
add_interface_port s0 slave_write write Input 1
add_interface_port s0 slave_readdata readdata Output -1
add_interface_port s0 slave_writedata writedata Input -1



# | 
# +-----------------------------------

# +-----------------------------------
# | connection point user_interface
# | 
add_interface user_interface conduit end

set_interface_property user_interface ASSOCIATED_CLOCK clock_reset

add_interface_port user_interface edid_scl export Bidir 1
add_interface_port user_interface edid_sda export Bidir 1

# add_interface_port user_interface user_dataout_0 export Output -1
# add_interface_port user_interface user_dataout_1 export Output -1
# add_interface_port user_interface user_dataout_2 export Output -1
# add_interface_port user_interface user_dataout_3 export Output -1
# add_interface_port user_interface user_dataout_4 export Output -1
# add_interface_port user_interface user_dataout_5 export Output -1
# add_interface_port user_interface user_dataout_6 export Output -1
# add_interface_port user_interface user_dataout_7 export Output -1
# add_interface_port user_interface user_dataout_8 export Output -1
# add_interface_port user_interface user_dataout_9 export Output -1
# add_interface_port user_interface user_dataout_10 export Output -1
# add_interface_port user_interface user_dataout_11 export Output -1
# add_interface_port user_interface user_dataout_12 export Output -1
# add_interface_port user_interface user_dataout_13 export Output -1
# add_interface_port user_interface user_dataout_14 export Output -1
# add_interface_port user_interface user_dataout_15 export Output -1
# add_interface_port user_interface user_datain_0 export Input -1
# add_interface_port user_interface user_datain_1 export Input -1
# add_interface_port user_interface user_datain_2 export Input -1
# add_interface_port user_interface user_datain_3 export Input -1
# add_interface_port user_interface user_datain_4 export Input -1
# add_interface_port user_interface user_datain_5 export Input -1
# add_interface_port user_interface user_datain_6 export Input -1
# add_interface_port user_interface user_datain_7 export Input -1
# add_interface_port user_interface user_datain_8 export Input -1
# add_interface_port user_interface user_datain_9 export Input -1
# add_interface_port user_interface user_datain_10 export Input -1
# add_interface_port user_interface user_datain_11 export Input -1
# add_interface_port user_interface user_datain_12 export Input -1
# add_interface_port user_interface user_datain_13 export Input -1
# add_interface_port user_interface user_datain_14 export Input -1
# add_interface_port user_interface user_datain_15 export Input -1
# add_interface_port user_interface user_write export Output 1
# add_interface_port user_interface user_read export Output 1
# add_interface_port user_interface user_chipselect export Output 4
# | 
# +-----------------------------------


proc elaborate_me {}  {
  set the_data_width [get_parameter_value DATA_WIDTH]
  # set the_enable_sync_signals [get_parameter_value ENABLE_SYNC_SIGNALS]
  # set the_mode_0 [get_parameter_value MODE_0]
  # set the_mode_1 [get_parameter_value MODE_1]
  # set the_mode_2 [get_parameter_value MODE_2]
  # set the_mode_3 [get_parameter_value MODE_3]
  # set the_mode_4 [get_parameter_value MODE_4]
  # set the_mode_5 [get_parameter_value MODE_5]
  # set the_mode_6 [get_parameter_value MODE_6]
  # set the_mode_7 [get_parameter_value MODE_7]
  # set the_mode_8 [get_parameter_value MODE_8]
  # set the_mode_9 [get_parameter_value MODE_9]
  # set the_mode_10 [get_parameter_value MODE_10]
  # set the_mode_11 [get_parameter_value MODE_11]
  # set the_mode_12 [get_parameter_value MODE_12]
  # set the_mode_13 [get_parameter_value MODE_13]
  # set the_mode_14 [get_parameter_value MODE_14]
  # set the_mode_15 [get_parameter_value MODE_15]
  
  
  
  ## ----------------------- setting up the data width of all the inputs and outputs ----------------------------
  set_port_property slave_readdata WIDTH $the_data_width
  set_port_property slave_writedata WIDTH $the_data_width
  # set_port_property user_dataout_0 WIDTH $the_data_width
  # set_port_property user_dataout_1 WIDTH $the_data_width
  # set_port_property user_dataout_2 WIDTH $the_data_width
  # set_port_property user_dataout_3 WIDTH $the_data_width
  # set_port_property user_dataout_4 WIDTH $the_data_width
  # set_port_property user_dataout_5 WIDTH $the_data_width
  # set_port_property user_dataout_6 WIDTH $the_data_width
  # set_port_property user_dataout_7 WIDTH $the_data_width
  # set_port_property user_dataout_8 WIDTH $the_data_width
  # set_port_property user_dataout_9 WIDTH $the_data_width
  # set_port_property user_dataout_10 WIDTH $the_data_width
  # set_port_property user_dataout_11 WIDTH $the_data_width
  # set_port_property user_dataout_12 WIDTH $the_data_width
  # set_port_property user_dataout_13 WIDTH $the_data_width
  # set_port_property user_dataout_14 WIDTH $the_data_width
  # set_port_property user_dataout_15 WIDTH $the_data_width
  # set_port_property user_datain_0 WIDTH $the_data_width
  # set_port_property user_datain_1 WIDTH $the_data_width
  # set_port_property user_datain_2 WIDTH $the_data_width
  # set_port_property user_datain_3 WIDTH $the_data_width
  # set_port_property user_datain_4 WIDTH $the_data_width
  # set_port_property user_datain_5 WIDTH $the_data_width
  # set_port_property user_datain_6 WIDTH $the_data_width
  # set_port_property user_datain_7 WIDTH $the_data_width
  # set_port_property user_datain_8 WIDTH $the_data_width
  # set_port_property user_datain_9 WIDTH $the_data_width
  # set_port_property user_datain_10 WIDTH $the_data_width
  # set_port_property user_datain_11 WIDTH $the_data_width
  # set_port_property user_datain_12 WIDTH $the_data_width
  # set_port_property user_datain_13 WIDTH $the_data_width
  # set_port_property user_datain_14 WIDTH $the_data_width
  # set_port_property user_datain_15 WIDTH $the_data_width
  ## ---------------------------- end of variable signal widths -------------------------------------------------
  
  
  
  ## ----------------------- turn the outputs off if mode is 1 or 4, otherwise turn them on ---------------------
  # expr { (($the_mode_0 == 1) || ($the_mode_0 == 4)) ? [set_port_property user_dataout_0 TERMINATION true] : [set_port_property user_dataout_0 TERMINATION false] };
  # expr { (($the_mode_1 == 1) || ($the_mode_1 == 4)) ? [set_port_property user_dataout_1 TERMINATION true] : [set_port_property user_dataout_1 TERMINATION false] };
  # expr { (($the_mode_2 == 1) || ($the_mode_2 == 4)) ? [set_port_property user_dataout_2 TERMINATION true] : [set_port_property user_dataout_2 TERMINATION false] };
  # expr { (($the_mode_3 == 1) || ($the_mode_3 == 4)) ? [set_port_property user_dataout_3 TERMINATION true] : [set_port_property user_dataout_3 TERMINATION false] };
  # expr { (($the_mode_4 == 1) || ($the_mode_4 == 4)) ? [set_port_property user_dataout_4 TERMINATION true] : [set_port_property user_dataout_4 TERMINATION false] };
  # expr { (($the_mode_5 == 1) || ($the_mode_5 == 4)) ? [set_port_property user_dataout_5 TERMINATION true] : [set_port_property user_dataout_5 TERMINATION false] };
  # expr { (($the_mode_6 == 1) || ($the_mode_6 == 4)) ? [set_port_property user_dataout_6 TERMINATION true] : [set_port_property user_dataout_6 TERMINATION false] };
  # expr { (($the_mode_7 == 1) || ($the_mode_7 == 4)) ? [set_port_property user_dataout_7 TERMINATION true] : [set_port_property user_dataout_7 TERMINATION false] };
  # expr { (($the_mode_8 == 1) || ($the_mode_8 == 4)) ? [set_port_property user_dataout_8 TERMINATION true] : [set_port_property user_dataout_8 TERMINATION false] };
  # expr { (($the_mode_9 == 1) || ($the_mode_9 == 4)) ? [set_port_property user_dataout_9 TERMINATION true] : [set_port_property user_dataout_9 TERMINATION false] };
  # expr { (($the_mode_10 == 1) || ($the_mode_10 == 4)) ? [set_port_property user_dataout_10 TERMINATION true] : [set_port_property user_dataout_10 TERMINATION false] };
  # expr { (($the_mode_11 == 1) || ($the_mode_11 == 4)) ? [set_port_property user_dataout_11 TERMINATION true] : [set_port_property user_dataout_11 TERMINATION false] };
  # expr { (($the_mode_12 == 1) || ($the_mode_12 == 4)) ? [set_port_property user_dataout_12 TERMINATION true] : [set_port_property user_dataout_12 TERMINATION false] };
  # expr { (($the_mode_13 == 1) || ($the_mode_13 == 4)) ? [set_port_property user_dataout_13 TERMINATION true] : [set_port_property user_dataout_13 TERMINATION false] };
  # expr { (($the_mode_14 == 1) || ($the_mode_14 == 4)) ? [set_port_property user_dataout_14 TERMINATION true] : [set_port_property user_dataout_14 TERMINATION false] };
  # expr { (($the_mode_15 == 1) || ($the_mode_15 == 4)) ? [set_port_property user_dataout_15 TERMINATION true] : [set_port_property user_dataout_15 TERMINATION false] };
  ## ---------------------------- end of data output enables ----------------------------------------------------
  
  
  
  
  ## ----------------------- turn the inputs on if mode is 1 or 2, otherwise turn them on -----------------------
  # expr { (($the_mode_0 == 1) || ($the_mode_0 == 2)) ? [set_port_property user_datain_0 TERMINATION false] : [set_port_property user_datain_0 TERMINATION true] };
  # expr { (($the_mode_1 == 1) || ($the_mode_1 == 2)) ? [set_port_property user_datain_1 TERMINATION false] : [set_port_property user_datain_1 TERMINATION true] };
  # expr { (($the_mode_2 == 1) || ($the_mode_2 == 2)) ? [set_port_property user_datain_2 TERMINATION false] : [set_port_property user_datain_2 TERMINATION true] };
  # expr { (($the_mode_3 == 1) || ($the_mode_3 == 2)) ? [set_port_property user_datain_3 TERMINATION false] : [set_port_property user_datain_3 TERMINATION true] };
  # expr { (($the_mode_4 == 1) || ($the_mode_4 == 2)) ? [set_port_property user_datain_4 TERMINATION false] : [set_port_property user_datain_4 TERMINATION true] };
  # expr { (($the_mode_5 == 1) || ($the_mode_5 == 2)) ? [set_port_property user_datain_5 TERMINATION false] : [set_port_property user_datain_5 TERMINATION true] };
  # expr { (($the_mode_6 == 1) || ($the_mode_6 == 2)) ? [set_port_property user_datain_6 TERMINATION false] : [set_port_property user_datain_6 TERMINATION true] };
  # expr { (($the_mode_7 == 1) || ($the_mode_7 == 2)) ? [set_port_property user_datain_7 TERMINATION false] : [set_port_property user_datain_7 TERMINATION true] };
  # expr { (($the_mode_8 == 1) || ($the_mode_8 == 2)) ? [set_port_property user_datain_8 TERMINATION false] : [set_port_property user_datain_8 TERMINATION true] };
  # expr { (($the_mode_9 == 1) || ($the_mode_9 == 2)) ? [set_port_property user_datain_9 TERMINATION false] : [set_port_property user_datain_9 TERMINATION true] };
  # expr { (($the_mode_10 == 1) || ($the_mode_10 == 2)) ? [set_port_property user_datain_10 TERMINATION false] : [set_port_property user_datain_10 TERMINATION true] };
  # expr { (($the_mode_11 == 1) || ($the_mode_11 == 2)) ? [set_port_property user_datain_11 TERMINATION false] : [set_port_property user_datain_11 TERMINATION true] };
  # expr { (($the_mode_12 == 1) || ($the_mode_12 == 2)) ? [set_port_property user_datain_12 TERMINATION false] : [set_port_property user_datain_12 TERMINATION true] };
  # expr { (($the_mode_13 == 1) || ($the_mode_13 == 2)) ? [set_port_property user_datain_13 TERMINATION false] : [set_port_property user_datain_13 TERMINATION true] };
  # expr { (($the_mode_14 == 1) || ($the_mode_14 == 2)) ? [set_port_property user_datain_14 TERMINATION false] : [set_port_property user_datain_14 TERMINATION true] };
  # expr { (($the_mode_15 == 1) || ($the_mode_15 == 2)) ? [set_port_property user_datain_15 TERMINATION false] : [set_port_property user_datain_15 TERMINATION true] };
  ## ---------------------------- end of data input enables -----------------------------------------------------

  

  ## -------------------- turn the user CS/Read/Write signals on if the sync signals are enabled-----------------
  # expr { ($the_enable_sync_signals == 1) ? [set_port_property user_chipselect TERMINATION false] : [set_port_property user_chipselect TERMINATION true] }
  # expr { ($the_enable_sync_signals == 1) ? [set_port_property user_read TERMINATION false] : [set_port_property user_read TERMINATION true] }
  # expr { ($the_enable_sync_signals == 1) ? [set_port_property user_write TERMINATION false] : [set_port_property user_write TERMINATION true] }
  ## ---------------------------- end of sync signal enables ----------------------------------------------------  
  
  

  ## adding the slave_byteenable and user_byteenable signals only if the data width is greater than 8 bits
  if { $the_data_width != 8 } {
    add_interface_port s0 slave_byteenable byteenable Input [expr {$the_data_width / 8} ]
	# if { $the_enable_sync_signals == 1 } {
	#   add_interface_port user_interface user_byteenable export Output [expr {$the_data_width / 8} ]
	# }
  }
}
