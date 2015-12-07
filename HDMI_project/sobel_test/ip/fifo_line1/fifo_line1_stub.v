// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2014.4 (lin32) Build 1071353 Tue Nov 18 16:37:30 MST 2014
// Date        : Mon Nov 16 15:48:04 2015
// Host        : localhost.localdomain running 32-bit unknown
// Command     : write_verilog -force -mode synth_stub
//               /home/fel/Vivado_Projects/Df_HDMI_filter/Df_HDMI_filter.srcs/sources_1/ip/fifo_line1/fifo_line1_stub.v
// Design      : fifo_line1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v12_0,Vivado 2014.4" *)
module fifo_line1(clk, rst, din, wr_en, rd_en, dout, full, empty, prog_full)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,din[7:0],wr_en,rd_en,dout[7:0],full,empty,prog_full" */;
  input clk;
  input rst;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output empty;
  output prog_full;
endmodule
