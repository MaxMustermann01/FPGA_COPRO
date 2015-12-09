-- (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: user.org:user:sobel9:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_sobel9_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    enable : IN STD_LOGIC;
    hsync_in : IN STD_LOGIC;
    vsync_in : IN STD_LOGIC;
    grey_data_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    rb_data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    g_data_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    grey_data_out_valid : OUT STD_LOGIC;
    hsync_out : OUT STD_LOGIC;
    vsync_out : OUT STD_LOGIC;
    threshold_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    mask1_in : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    mask2_in : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
    ready : OUT STD_LOGIC
  );
END design_1_sobel9_0_0;

ARCHITECTURE design_1_sobel9_0_0_arch OF design_1_sobel9_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : string;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_sobel9_0_0_arch: ARCHITECTURE IS "yes";

  COMPONENT dataflow IS
    GENERIC (
      DELAY : INTEGER
    );
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      hsync_in : IN STD_LOGIC;
      vsync_in : IN STD_LOGIC;
      grey_data_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      rb_data_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      g_data_out : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      grey_data_out_valid : OUT STD_LOGIC;
      hsync_out : OUT STD_LOGIC;
      vsync_out : OUT STD_LOGIC;
      threshold_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      mask1_in : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
      mask2_in : IN STD_LOGIC_VECTOR(26 DOWNTO 0);
      ready : OUT STD_LOGIC
    );
  END COMPONENT dataflow;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_sobel9_0_0_arch: ARCHITECTURE IS "dataflow,Vivado 2014.4";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_sobel9_0_0_arch : ARCHITECTURE IS "design_1_sobel9_0_0,dataflow,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 signal_clock CLK";
BEGIN
  U0 : dataflow
    GENERIC MAP (
      DELAY => 2750
    )
    PORT MAP (
      clk => clk,
      rst => rst,
      enable => enable,
      hsync_in => hsync_in,
      vsync_in => vsync_in,
      grey_data_in => grey_data_in,
      rb_data_out => rb_data_out,
      g_data_out => g_data_out,
      grey_data_out_valid => grey_data_out_valid,
      hsync_out => hsync_out,
      vsync_out => vsync_out,
      threshold_in => threshold_in,
      mask1_in => mask1_in,
      mask2_in => mask2_in,
      ready => ready
    );
END design_1_sobel9_0_0_arch;
