proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z010clg400-1
  set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.cache/wt [current_project]
  set_property parent.project_path /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.xpr [current_project]
  set_property ip_repo_paths {
  /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.cache/ip
  /home/fel/zyboSimpleHDMI/ip_repo/sobel_filter_1.0
  /home/fel/zyboSimpleHDMI/ip/tbuf
  /home/fel/zyboSimpleHDMI/ip/hdmi_rx_v1_00_a
  /home/fel/sobel_test/src
  /home/fel
} [current_project]
  set_property ip_output_repo /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.cache/ip [current_project]
  add_files -quiet /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.runs/synth_1/design_1_wrapper.dcp
  read_xdc -ref design_1_processing_system7_0_0 -cells inst /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
  read_xdc -ref fifo_line1 -cells U0 /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.srcs/sources_1/bd/design_1/ip/design_1_sobel9_0_0/src/fifo_line1/fifo_line1/fifo_line1.xdc
  set_property processing_order EARLY [get_files /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.srcs/sources_1/bd/design_1/ip/design_1_sobel9_0_0/src/fifo_line1/fifo_line1/fifo_line1.xdc]
  read_xdc /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.srcs/constrs_1/new/hdmi.xdc
  link_design -top design_1_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force design_1_wrapper_opt.dcp
  catch {report_drc -file design_1_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force design_1_wrapper_placed.dcp
  catch { report_io -file design_1_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file design_1_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file design_1_wrapper_utilization_placed.rpt -pb design_1_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file design_1_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force design_1_wrapper_routed.dcp
  catch { report_drc -file design_1_wrapper_drc_routed.rpt -pb design_1_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file design_1_wrapper_timing_summary_routed.rpt -rpx design_1_wrapper_timing_summary_routed.rpx }
  catch { report_power -file design_1_wrapper_power_routed.rpt -pb design_1_wrapper_power_summary_routed.pb }
  catch { report_route_status -file design_1_wrapper_route_status.rpt -pb design_1_wrapper_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force design_1_wrapper.bit 
  if { [file exists /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.runs/synth_1/design_1_wrapper.hwdef] } {
    catch { write_sysdef -hwdef /home/fel/zyboSimpleHDMI/hdmiPassThrough14.4/hdmiPassThrough14.4.runs/synth_1/design_1_wrapper.hwdef -bitfile design_1_wrapper.bit -meminfo design_1_wrapper.mmi -file design_1_wrapper.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

