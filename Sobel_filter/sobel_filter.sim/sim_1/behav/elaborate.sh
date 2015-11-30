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
ExecStep $xv_path/bin/xelab -wto bbec1d9b8cb84bdfa8550d71c295e0bf -m32 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_sobel_filter_top_behav xil_defaultlib.tb_sobel_filter_top xil_defaultlib.glbl -log elaborate.log
