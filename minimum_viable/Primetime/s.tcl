######################################################################
## Step 1: Read RTL/gate-level netlist, parasitics (e.g. SPEF/SDF file for interconnect calcuation) and the constraints (you may adopt the constraints of the sdc file generated by DC after syntehsize or the constraints used for synthesize if it is just gate-level timing anlysis; however, for post-layout anaylsis, you should use the command set_propogated_clock so that the clock delay is calcuated based on the real physical layout) 
set auto_wire_load_selection false
set verilog_file_name control_synth.v
set target_library "NangateOpenCellLibrary_typical.db"
set link_library "* NangateOpenCellLibrary_typical.db"
#fill in the blank here for the appropriate filename

#
#
read_verilog ./source/$verilog_file_name
#
#check the library for timing anlaysis, library (db) information is critical for cell delay calcuation,
#while the SPEF or SDF file is used for wire delay
list_libraries
list_designs

#Fill in the blanks for the appropriate design names
current_design control
link_design control
#

#
#for setup and hold timing check, library setting
set_min_library NangateOpenCellLibrary_slow.db -min_version NangateOpenCellLibrary_fast.db

#create_functional clocks
create_clock [get_ports clk]  -period 100  -waveform {0 50} 
set_clock_uncertainty -setup 0.5  [get_clocks clk]
set_clock_latency -source 0.5 [get_clocks clk]
set_clock_latency 0.5 [get_clocks clk]

#constraints the interface, io_delay
#set_input_delay -max 2.5  -network_latency_included -clock second_clock [get_ports XXX]
#set_input_delay -min 1.5  -network_latency_included -clock second_clock [get_ports XXX]
#set_input_delay -max 2.5  -network_latency_included -clock second_clock [get_ports XXX]
#set_input_delay -min 1.5  -network_latency_included -clock second_clock [get_ports XXX]
set inputs_others [remove_from_collection [all_inputs] [get_ports "clk"]]
set_input_delay -max 0.25 -clock clk $inputs_others
set_input_delay -min 0.25 -clock clk $inputs_others


set_max_fanout 8 [current_design]
## Input max fanout = 1
set_max_fanout 1 [all_inputs]
set_max_transition 2.4 [current_design]
set_max_capacitance 6.0 [current_design]


# Set constraints on output ports
set_output_delay 0.25 -max -clock clk [all_outputs]
set_output_delay 0.25 -min -clock clk [all_outputs]
#

set_load 0.1 [all_outputs]



# Operating Environment
# set_operating_conditions -max "slow" -max_library "NangateOpenCellLibrary_SS" -min "fast" -min_library "NangateOpenCellLibrary_FF"
set_wire_load_model -name 1K_hvratio_1_2
set_wire_load_mode top


##############Advanced Timing Analysis Setting: set_false_path, multiple_cycle_path, set_case_analysis, set_propogated_clocks (for post layout timing check)########## 
#set timing_remove_clock_reconvergence_pessimism true
# Propagate clocks, set operating conditions and set constant values
#
set_propagated_clock [all_clocks]
# 
#Step 2--Perform the timing analysis and report the clock/timing
######################################################################
#
update_timing
#
echo "Design is ready for timing analysis\n"
#
#######################################################################
report_clock
report_clock -skew
#
report_design
#
check_timing -verbose
##check_timing -to [all_registers -data_pins]
##check_timing -to [all_outputs]
#
redirect -append ./report/Timing_rp_MAX.rpt {check_timing -verbose} 
#
##3.
##report_constraint
##report_constraint -all_violators
##report_constraint -all_violators -verbose
#
redirect -append ./report/constraint_MAX.rpt {report_constraint} 
redirect -append ./report/constraint_MAX.rpt {report_constraint -all_violators -verbose} 

# dump out sdf file for back-annoated functional simulation use an appropriate name
# dump out sdf file for back-annoated functional simulation use an appropriate name
write_sdf -version 3.0 -context verilog control.sdf
