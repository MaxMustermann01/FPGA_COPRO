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
echo "xvlog -m32 -prj tb_sobel_filter_top_vlog.prj"
ExecStep $xv_path/bin/xvlog -m32 -prj tb_sobel_filter_top_vlog.prj 2>&1 | tee compile.log
echo "xvhdl -m32 -prj tb_sobel_filter_top_vhdl.prj"
ExecStep $xv_path/bin/xvhdl -m32 -prj tb_sobel_filter_top_vhdl.prj 2>&1 | tee compile.log
