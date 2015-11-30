#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2014.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim tb_sobel_filter_top_behav -key {Behavioral:sim_1:Functional:tb_sobel_filter_top} -tclbatch tb_sobel_filter_top.tcl -log simulate.log
