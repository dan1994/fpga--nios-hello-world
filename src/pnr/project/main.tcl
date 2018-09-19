# Check that project exists
if { ![project_exists [lindex $argv 0])] } {
	post_message -type error "Project [lindex $argv 0] does not exist"
	exit
}

# Set the files to source, and get their absolute paths
set sources [list global.tcl pinout.tcl [lindex $argv 1]]
set sources [lmap s $sources {file normalize $s}]

# Open the project and source the files
project_open [lindex $argv 0]
foreach s $sources {
	source $s
}
project_close