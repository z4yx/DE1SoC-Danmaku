set_global_assignment -entity "feeder_pll" -library "lib_feeder_pll" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "feeder_pll" -library "lib_feeder_pll" -name IP_TOOL_VERSION "15.1"
set_global_assignment -entity "feeder_pll" -library "lib_feeder_pll" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_feeder_pll" -name SPD_FILE [file join $::quartus(sip_path) "feeder_pll.spd"]

set_global_assignment -library "lib_feeder_pll" -name MISC_FILE [file join $::quartus(sip_path) "feeder_pll_sim/feeder_pll.vo"]
