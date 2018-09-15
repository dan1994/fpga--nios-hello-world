# Pin Locations
set_location_assignment PIN_E1 		-to sys_clk_50m
set_location_assignment PIN_J15 	-to reset_n
set_location_assignment PIN_E15 	-to buttons[0]
set_location_assignment PIN_F14 	-to buttons[1]
set_location_assignment PIN_C11 	-to buttons[2]
set_location_assignment PIN_D9 		-to buttons[3]
set_location_assignment PIN_L14 	-to leds[0]
set_location_assignment PIN_K15 	-to leds[1]
set_location_assignment PIN_J14 	-to leds[2]
set_location_assignment PIN_J13 	-to leds[3]

# IO Standard
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sys_clk_50m
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to buttons[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to buttons[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to buttons[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to buttons[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to leds[3]