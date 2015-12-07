--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (lin32) Build 1071353 Tue Nov 18 16:37:30 MST 2014
--Date        : Mon Dec  7 15:02:52 2015
--Host        : localhost.localdomain running 32-bit unknown
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    BTN : in STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    HDMI_CLK_N : in STD_LOGIC;
    HDMI_CLK_P : in STD_LOGIC;
    HDMI_D_N : in STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_D_P : in STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_HPD : out STD_LOGIC;
    HDMI_OUT_EN : out STD_LOGIC;
    VGA_B : out STD_LOGIC_VECTOR ( 4 downto 0 );
    VGA_G : out STD_LOGIC_VECTOR ( 5 downto 0 );
    VGA_HS : out STD_LOGIC;
    VGA_R : out STD_LOGIC_VECTOR ( 4 downto 0 );
    VGA_VS : out STD_LOGIC
  );
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_processing_system7_0_0 is
  port (
    ENET0_PTP_DELAY_REQ_RX : out STD_LOGIC;
    ENET0_PTP_DELAY_REQ_TX : out STD_LOGIC;
    ENET0_PTP_PDELAY_REQ_RX : out STD_LOGIC;
    ENET0_PTP_PDELAY_REQ_TX : out STD_LOGIC;
    ENET0_PTP_PDELAY_RESP_RX : out STD_LOGIC;
    ENET0_PTP_PDELAY_RESP_TX : out STD_LOGIC;
    ENET0_PTP_SYNC_FRAME_RX : out STD_LOGIC;
    ENET0_PTP_SYNC_FRAME_TX : out STD_LOGIC;
    ENET0_SOF_RX : out STD_LOGIC;
    ENET0_SOF_TX : out STD_LOGIC;
    SDIO0_WP : in STD_LOGIC;
    TTC0_WAVE0_OUT : out STD_LOGIC;
    TTC0_WAVE1_OUT : out STD_LOGIC;
    TTC0_WAVE2_OUT : out STD_LOGIC;
    USB0_PORT_INDCTL : out STD_LOGIC_VECTOR ( 1 downto 0 );
    USB0_VBUS_PWRSELECT : out STD_LOGIC;
    USB0_VBUS_PWRFAULT : in STD_LOGIC;
    FCLK_CLK0 : out STD_LOGIC;
    FCLK_RESET0_N : out STD_LOGIC;
    MIO : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    DDR_CAS_n : inout STD_LOGIC;
    DDR_CKE : inout STD_LOGIC;
    DDR_Clk_n : inout STD_LOGIC;
    DDR_Clk : inout STD_LOGIC;
    DDR_CS_n : inout STD_LOGIC;
    DDR_DRSTB : inout STD_LOGIC;
    DDR_ODT : inout STD_LOGIC;
    DDR_RAS_n : inout STD_LOGIC;
    DDR_WEB : inout STD_LOGIC;
    DDR_BankAddr : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_Addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_VRN : inout STD_LOGIC;
    DDR_VRP : inout STD_LOGIC;
    DDR_DM : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQ : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_DQS_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_DQS : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    PS_SRSTB : inout STD_LOGIC;
    PS_CLK : inout STD_LOGIC;
    PS_PORB : inout STD_LOGIC
  );
  end component design_1_processing_system7_0_0;
  component design_1_hdmi_rx_0_0 is
  port (
    SYSCLK : in STD_LOGIC;
    BTN : in STD_LOGIC;
    LED : out STD_LOGIC_VECTOR ( 3 downto 0 );
    JE : out STD_LOGIC_VECTOR ( 7 downto 0 );
    VGA_HS : out STD_LOGIC;
    VGA_VS : out STD_LOGIC;
    VGA_DE : out STD_LOGIC;
    VGA_DATA : out STD_LOGIC_VECTOR ( 23 downto 0 );
    VGA_R : out STD_LOGIC_VECTOR ( 4 downto 0 );
    VGA_G : out STD_LOGIC_VECTOR ( 5 downto 0 );
    VGA_B : out STD_LOGIC_VECTOR ( 4 downto 0 );
    PXL_CLK : out STD_LOGIC;
    PXL_CLK_LOCKED : out STD_LOGIC;
    HDMI_OUT_EN : out STD_LOGIC;
    HDMI_HPD : out STD_LOGIC;
    HDMI_SCL : in STD_LOGIC;
    HDMI_SDA_I : in STD_LOGIC;
    HDMI_SDA_O : out STD_LOGIC;
    HDMI_SDA_T : out STD_LOGIC;
    HDMI_CLK_P : in STD_LOGIC;
    HDMI_CLK_N : in STD_LOGIC;
    HDMI_D_P : in STD_LOGIC_VECTOR ( 2 downto 0 );
    HDMI_D_N : in STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  end component design_1_hdmi_rx_0_0;
  component design_1_xlconstant_0_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_xlconstant_0_0;
  component design_1_xlconstant_1_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  end component design_1_xlconstant_1_0;
  component design_1_xlconstant_2_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 26 downto 0 )
  );
  end component design_1_xlconstant_2_0;
  component design_1_xlconstant_3_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 26 downto 0 )
  );
  end component design_1_xlconstant_3_0;
  component design_1_xlconstant_4_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );
  end component design_1_xlconstant_4_0;
  component design_1_xlconstant_5_0 is
  port (
    dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_xlconstant_5_0;
  component design_1_sobel9_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    enable : in STD_LOGIC;
    hsync_in : in STD_LOGIC;
    vsync_in : in STD_LOGIC;
    grey_data_in : in STD_LOGIC_VECTOR ( 5 downto 0 );
    rb_data_out : out STD_LOGIC_VECTOR ( 4 downto 0 );
    g_data_out : out STD_LOGIC_VECTOR ( 5 downto 0 );
    grey_data_out_valid : out STD_LOGIC;
    hsync_out : out STD_LOGIC;
    vsync_out : out STD_LOGIC;
    threshold_in : in STD_LOGIC_VECTOR ( 9 downto 0 );
    mask1_in : in STD_LOGIC_VECTOR ( 26 downto 0 );
    mask2_in : in STD_LOGIC_VECTOR ( 26 downto 0 );
    delay : in STD_LOGIC_VECTOR ( 9 downto 0 );
    ready : out STD_LOGIC
  );
  end component design_1_sobel9_0_0;
  signal BTN_1 : STD_LOGIC;
  signal GND_1 : STD_LOGIC;
  signal HDMI_CLK_N_1 : STD_LOGIC;
  signal HDMI_CLK_P_1 : STD_LOGIC;
  signal HDMI_D_N_1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal HDMI_D_P_1 : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal hdmi_rx_0_HDMI_HPD : STD_LOGIC;
  signal hdmi_rx_0_HDMI_OUT_EN : STD_LOGIC;
  signal hdmi_rx_0_PXL_CLK : STD_LOGIC;
  signal hdmi_rx_0_VGA_DE : STD_LOGIC;
  signal hdmi_rx_0_VGA_G : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal hdmi_rx_0_VGA_HS : STD_LOGIC;
  signal hdmi_rx_0_VGA_VS : STD_LOGIC;
  signal processing_system7_0_DDR_ADDR : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal processing_system7_0_DDR_BA : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal processing_system7_0_DDR_CAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_CKE : STD_LOGIC;
  signal processing_system7_0_DDR_CK_N : STD_LOGIC;
  signal processing_system7_0_DDR_CK_P : STD_LOGIC;
  signal processing_system7_0_DDR_CS_N : STD_LOGIC;
  signal processing_system7_0_DDR_DM : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal processing_system7_0_DDR_DQS_N : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_DQS_P : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal processing_system7_0_DDR_ODT : STD_LOGIC;
  signal processing_system7_0_DDR_RAS_N : STD_LOGIC;
  signal processing_system7_0_DDR_RESET_N : STD_LOGIC;
  signal processing_system7_0_DDR_WE_N : STD_LOGIC;
  signal processing_system7_0_FCLK_CLK0 : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRN : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_DDR_VRP : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_MIO : STD_LOGIC_VECTOR ( 53 downto 0 );
  signal processing_system7_0_FIXED_IO_PS_CLK : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_PORB : STD_LOGIC;
  signal processing_system7_0_FIXED_IO_PS_SRSTB : STD_LOGIC;
  signal sobel4_0_rb_data_out : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal sobel9_0_g_data_out : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal sobel9_0_hsync_out : STD_LOGIC;
  signal sobel9_0_vsync_out : STD_LOGIC;
  signal xlconstant_0_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlconstant_1_dout : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal xlconstant_2_dout : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal xlconstant_3_dout : STD_LOGIC_VECTOR ( 26 downto 0 );
  signal xlconstant_4_dout : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal xlconstant_5_dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_hdmi_rx_0_HDMI_SDA_O_UNCONNECTED : STD_LOGIC;
  signal NLW_hdmi_rx_0_HDMI_SDA_T_UNCONNECTED : STD_LOGIC;
  signal NLW_hdmi_rx_0_PXL_CLK_LOCKED_UNCONNECTED : STD_LOGIC;
  signal NLW_hdmi_rx_0_JE_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal NLW_hdmi_rx_0_LED_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_hdmi_rx_0_VGA_B_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_hdmi_rx_0_VGA_DATA_UNCONNECTED : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal NLW_hdmi_rx_0_VGA_R_UNCONNECTED : STD_LOGIC_VECTOR ( 4 downto 0 );
  signal NLW_processing_system7_0_ENET0_PTP_DELAY_REQ_RX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_DELAY_REQ_TX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_PDELAY_REQ_RX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_PDELAY_REQ_TX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_PDELAY_RESP_RX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_PDELAY_RESP_TX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_SYNC_FRAME_RX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_PTP_SYNC_FRAME_TX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_SOF_RX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_ENET0_SOF_TX_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_FCLK_RESET0_N_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED : STD_LOGIC;
  signal NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_sobel9_0_grey_data_out_valid_UNCONNECTED : STD_LOGIC;
  signal NLW_sobel9_0_ready_UNCONNECTED : STD_LOGIC;
begin
  BTN_1 <= BTN;
  HDMI_CLK_N_1 <= HDMI_CLK_N;
  HDMI_CLK_P_1 <= HDMI_CLK_P;
  HDMI_D_N_1(2 downto 0) <= HDMI_D_N(2 downto 0);
  HDMI_D_P_1(2 downto 0) <= HDMI_D_P(2 downto 0);
  HDMI_HPD <= hdmi_rx_0_HDMI_HPD;
  HDMI_OUT_EN <= hdmi_rx_0_HDMI_OUT_EN;
  VGA_B(4 downto 0) <= sobel4_0_rb_data_out(4 downto 0);
  VGA_G(5 downto 0) <= sobel9_0_g_data_out(5 downto 0);
  VGA_HS <= sobel9_0_hsync_out;
  VGA_R(4 downto 0) <= sobel4_0_rb_data_out(4 downto 0);
  VGA_VS <= sobel9_0_vsync_out;
GND: unisim.vcomponents.GND
    port map (
      G => GND_1
    );
hdmi_rx_0: component design_1_hdmi_rx_0_0
    port map (
      BTN => BTN_1,
      HDMI_CLK_N => HDMI_CLK_N_1,
      HDMI_CLK_P => HDMI_CLK_P_1,
      HDMI_D_N(2 downto 0) => HDMI_D_N_1(2 downto 0),
      HDMI_D_P(2 downto 0) => HDMI_D_P_1(2 downto 0),
      HDMI_HPD => hdmi_rx_0_HDMI_HPD,
      HDMI_OUT_EN => hdmi_rx_0_HDMI_OUT_EN,
      HDMI_SCL => xlconstant_0_dout(0),
      HDMI_SDA_I => xlconstant_0_dout(0),
      HDMI_SDA_O => NLW_hdmi_rx_0_HDMI_SDA_O_UNCONNECTED,
      HDMI_SDA_T => NLW_hdmi_rx_0_HDMI_SDA_T_UNCONNECTED,
      JE(7 downto 0) => NLW_hdmi_rx_0_JE_UNCONNECTED(7 downto 0),
      LED(3 downto 0) => NLW_hdmi_rx_0_LED_UNCONNECTED(3 downto 0),
      PXL_CLK => hdmi_rx_0_PXL_CLK,
      PXL_CLK_LOCKED => NLW_hdmi_rx_0_PXL_CLK_LOCKED_UNCONNECTED,
      SYSCLK => processing_system7_0_FCLK_CLK0,
      VGA_B(4 downto 0) => NLW_hdmi_rx_0_VGA_B_UNCONNECTED(4 downto 0),
      VGA_DATA(23 downto 0) => NLW_hdmi_rx_0_VGA_DATA_UNCONNECTED(23 downto 0),
      VGA_DE => hdmi_rx_0_VGA_DE,
      VGA_G(5 downto 0) => hdmi_rx_0_VGA_G(5 downto 0),
      VGA_HS => hdmi_rx_0_VGA_HS,
      VGA_R(4 downto 0) => NLW_hdmi_rx_0_VGA_R_UNCONNECTED(4 downto 0),
      VGA_VS => hdmi_rx_0_VGA_VS
    );
processing_system7_0: component design_1_processing_system7_0_0
    port map (
      DDR_Addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_BankAddr(2 downto 0) => DDR_ba(2 downto 0),
      DDR_CAS_n => DDR_cas_n,
      DDR_CKE => DDR_cke,
      DDR_CS_n => DDR_cs_n,
      DDR_Clk => DDR_ck_p,
      DDR_Clk_n => DDR_ck_n,
      DDR_DM(3 downto 0) => DDR_dm(3 downto 0),
      DDR_DQ(31 downto 0) => DDR_dq(31 downto 0),
      DDR_DQS(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_DQS_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_DRSTB => DDR_reset_n,
      DDR_ODT => DDR_odt,
      DDR_RAS_n => DDR_ras_n,
      DDR_VRN => FIXED_IO_ddr_vrn,
      DDR_VRP => FIXED_IO_ddr_vrp,
      DDR_WEB => DDR_we_n,
      ENET0_PTP_DELAY_REQ_RX => NLW_processing_system7_0_ENET0_PTP_DELAY_REQ_RX_UNCONNECTED,
      ENET0_PTP_DELAY_REQ_TX => NLW_processing_system7_0_ENET0_PTP_DELAY_REQ_TX_UNCONNECTED,
      ENET0_PTP_PDELAY_REQ_RX => NLW_processing_system7_0_ENET0_PTP_PDELAY_REQ_RX_UNCONNECTED,
      ENET0_PTP_PDELAY_REQ_TX => NLW_processing_system7_0_ENET0_PTP_PDELAY_REQ_TX_UNCONNECTED,
      ENET0_PTP_PDELAY_RESP_RX => NLW_processing_system7_0_ENET0_PTP_PDELAY_RESP_RX_UNCONNECTED,
      ENET0_PTP_PDELAY_RESP_TX => NLW_processing_system7_0_ENET0_PTP_PDELAY_RESP_TX_UNCONNECTED,
      ENET0_PTP_SYNC_FRAME_RX => NLW_processing_system7_0_ENET0_PTP_SYNC_FRAME_RX_UNCONNECTED,
      ENET0_PTP_SYNC_FRAME_TX => NLW_processing_system7_0_ENET0_PTP_SYNC_FRAME_TX_UNCONNECTED,
      ENET0_SOF_RX => NLW_processing_system7_0_ENET0_SOF_RX_UNCONNECTED,
      ENET0_SOF_TX => NLW_processing_system7_0_ENET0_SOF_TX_UNCONNECTED,
      FCLK_CLK0 => processing_system7_0_FCLK_CLK0,
      FCLK_RESET0_N => NLW_processing_system7_0_FCLK_RESET0_N_UNCONNECTED,
      MIO(53 downto 0) => FIXED_IO_mio(53 downto 0),
      PS_CLK => FIXED_IO_ps_clk,
      PS_PORB => FIXED_IO_ps_porb,
      PS_SRSTB => FIXED_IO_ps_srstb,
      SDIO0_WP => GND_1,
      TTC0_WAVE0_OUT => NLW_processing_system7_0_TTC0_WAVE0_OUT_UNCONNECTED,
      TTC0_WAVE1_OUT => NLW_processing_system7_0_TTC0_WAVE1_OUT_UNCONNECTED,
      TTC0_WAVE2_OUT => NLW_processing_system7_0_TTC0_WAVE2_OUT_UNCONNECTED,
      USB0_PORT_INDCTL(1 downto 0) => NLW_processing_system7_0_USB0_PORT_INDCTL_UNCONNECTED(1 downto 0),
      USB0_VBUS_PWRFAULT => GND_1,
      USB0_VBUS_PWRSELECT => NLW_processing_system7_0_USB0_VBUS_PWRSELECT_UNCONNECTED
    );
sobel9_0: component design_1_sobel9_0_0
    port map (
      clk => hdmi_rx_0_PXL_CLK,
      delay(9 downto 0) => xlconstant_4_dout(9 downto 0),
      enable => hdmi_rx_0_VGA_DE,
      g_data_out(5 downto 0) => sobel9_0_g_data_out(5 downto 0),
      grey_data_in(5 downto 0) => hdmi_rx_0_VGA_G(5 downto 0),
      grey_data_out_valid => NLW_sobel9_0_grey_data_out_valid_UNCONNECTED,
      hsync_in => hdmi_rx_0_VGA_HS,
      hsync_out => sobel9_0_hsync_out,
      mask1_in(26 downto 0) => xlconstant_2_dout(26 downto 0),
      mask2_in(26 downto 0) => xlconstant_3_dout(26 downto 0),
      rb_data_out(4 downto 0) => sobel4_0_rb_data_out(4 downto 0),
      ready => NLW_sobel9_0_ready_UNCONNECTED,
      rst => xlconstant_5_dout(0),
      threshold_in(9 downto 0) => xlconstant_1_dout(9 downto 0),
      vsync_in => hdmi_rx_0_VGA_VS,
      vsync_out => sobel9_0_vsync_out
    );
xlconstant_0: component design_1_xlconstant_0_0
    port map (
      dout(0) => xlconstant_0_dout(0)
    );
xlconstant_1: component design_1_xlconstant_1_0
    port map (
      dout(9 downto 0) => xlconstant_1_dout(9 downto 0)
    );
xlconstant_2: component design_1_xlconstant_2_0
    port map (
      dout(26 downto 0) => xlconstant_2_dout(26 downto 0)
    );
xlconstant_3: component design_1_xlconstant_3_0
    port map (
      dout(26 downto 0) => xlconstant_3_dout(26 downto 0)
    );
xlconstant_4: component design_1_xlconstant_4_0
    port map (
      dout(9 downto 0) => xlconstant_4_dout(9 downto 0)
    );
xlconstant_5: component design_1_xlconstant_5_0
    port map (
      dout(0) => xlconstant_5_dout(0)
    );
end STRUCTURE;
