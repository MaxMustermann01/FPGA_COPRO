library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity sobel_filter_top is
  generic (
		-- Users to add parameters here
        HPIXELS : integer := 1280;  -- Horizontal Live Pixels
        VLINES : integer :=  720;  -- Vertical Live Lines
        HSYNCPW : integer :=   80;  -- HSYNC Pulse Width
        VSYNCPW : integer :=    2;  -- VSYNC Pulse Width
        HFNPRCH : integer :=   72;  -- Horizontal Front Portch
        VFNPRCH : integer :=    3;  -- Vertical Front Portch
        HBKPRCH : integer :=  216;  -- Horizontal Back Portch
        VBKPRCH : integer :=   22;  -- Vertical Back Portch
        BORDER : integer :=    1;   -- Left/Right/Up/Bottom Border Size  
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 7
	);
  port(  
            axi_awaddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            axi_awprot	  : in std_logic_vector(2 downto 0);
            axi_awvalid	  : in std_logic;
            axi_awready	  : out std_logic;
            axi_wdata	    : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            axi_wstrb	    : in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
            axi_wvalid	  : in std_logic;
            axi_wready	  : out std_logic;
            axi_bresp	    : out std_logic_vector(1 downto 0);
            axi_bvalid	  : out std_logic;
            axi_bready	  : in std_logic;
            axi_araddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
            axi_arprot	  : in std_logic_vector(2 downto 0);
            axi_arvalid	  : in std_logic;
            axi_arready	  : out std_logic;
            axi_rdata	    : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
            axi_rresp	    : out std_logic_vector(1 downto 0);
            axi_rvalid	  : out std_logic;
            axi_rready	  : in std_logic;
  
            clk           : in std_logic;
            rst           : in std_logic; 
            enable: in std_logic;
            frame_valid : in std_logic;
            line_valid : in std_logic;
            pixel_in : in std_logic_vector (7 downto 0);
            HSYNC, VSYNC, ACTIVE : OUT std_logic;
            DOUT : OUT std_logic_vector(23 downto 0)
    
  );
end sobel_filter_top;

architecture Behavioral of sobel_filter_top is

signal RESET_FIFO       : std_logic;
signal PIXEL_TO_FILTER  : std_logic_vector(7 downto 0);
signal threshold        : std_logic_vector(9 downto 0);
signal mask_h           : std_logic_vector(26 downto 0);
signal mask_v           : std_logic_vector(26 downto 0);
signal PIXEL_CLK        : std_logic;
signal filter_ready     : std_logic;
signal PIXEL_VALID      : std_logic;
signal pixel_to_output  : std_logic_vector(7 downto 0);
signal pixel_to_output_valid : std_logic;

-- filter module
component dataflow is
    Port ( clk, rst, enable: in STD_LOGIC;
           grey_data_in : in STD_LOGIC_VECTOR (7 downto 0);
           threshold_in : in STD_LOGIC_VECTOR (9 downto 0);
           mask1_in : in STD_LOGIC_VECTOR (26 downto 0);
           mask2_in : in STD_LOGIC_VECTOR (26 downto 0);
           grey_data_out : out std_logic_vector (7 downto 0);
           grey_data_out_valid : out std_logic;
           ready: out std_logic);
end component;

-- input state machine
component cam_fsm is
	port (  PIXEL_CLK : in  STD_LOGIC; 
			    RST : in  STD_LOGIC;
			    FRAME_VALID : in  STD_LOGIC;
			    LINE_VALID : in  STD_LOGIC;
			    DATA : in  STD_LOGIC_VECTOR (7 downto 0);
			    RESET_FIFO : out STD_LOGIC;
			    PIXEL_VALID : out  STD_LOGIC;
          PIXEL_OUT : out  STD_LOGIC_VECTOR (7 downto 0));			 
end component;

component hdmi_fsm is
  generic (HPIXELS  : integer := 1280;  -- Horizontal Live Pixels
			     VLINES 	: integer :=  720;  -- Vertical Live ines
			     HSYNCPW	: integer :=   80;  -- HSYNC Pulse Width
			     VSYNCPW  : integer :=    2;  -- VSYNC Pulse Width
			     HFNPRCH	: integer :=   72;  -- Horizontal Front Portch
			     VFNPRCH	: integer :=	3;  -- Vertical Front Portch
			     HBKPRCH	: integer :=  216;  -- Horizontal Back Portch
			     VBKPRCH	: integer :=   22;  -- Vertical Back Portch
			     BORDER	  : integer :=    1   -- Left/Right/Up/Bottom Border Size
			 );
			
  port( CLK, RST : IN std_logic;
        DIN : IN  std_logic_vector(7 downto 0);
        HSYNC, VSYNC, ACTIVE : OUT std_logic;
		    DOUT : OUT std_logic_vector(23 downto 0));
		  
end component;

-- axi register module
component improc_controller_v1_0 is
	generic (
		-- Users to add parameters here
        HPIXELS : integer := 1280;  -- Horizontal Live Pixels
        VLINES  : integer :=  720;  -- Vertical Live Lines
        HSYNCPW : integer :=   80;  -- HSYNC Pulse Width
        VSYNCPW : integer :=    2;  -- VSYNC Pulse Width
        HFNPRCH : integer :=   72;  -- Horizontal Front Portch
        VFNPRCH : integer :=    3;  -- Vertical Front Portch
        HBKPRCH : integer :=  216;  -- Horizontal Back Portch
        VBKPRCH : integer :=   22;  -- Vertical Back Portch
        BORDER  : integer :=    1;   -- Left/Right/Up/Bottom Border Size  
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
      C_S00_AXI_DATA_WIDTH	: integer	:= 32;
      C_S00_AXI_ADDR_WIDTH	: integer	:= 7
	);
	port (
		-- Users to add ports here
        THRESHOLD     : out std_logic_vector(7 downto 0); -- Threshold
        HMASK         : inout std_logic_vector(26 downto 0); -- Horizontal Maskvalues
        VMASK         : inout std_logic_vector(26 downto 0); -- Vertical Maskvalues
        DMASK0        : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues0
        DMASK1        : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues1
                        
        STATUSREG     : out std_logic_vector(31 downto 0); -- Statusregister
        CONTROLREG    : inout std_logic_vector(31 downto 0); -- Controlregister
        IMDATAREG0    : inout std_logic_vector(31 downto 0); -- Imagedataregister0
        IMDATAREG1    : inout std_logic_vector(31 downto 0); -- Imagedataregister1
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	    : in std_logic;
		s00_axi_aresetn	  : in std_logic;
		s00_axi_awaddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	  : in std_logic_vector(2 downto 0);
		s00_axi_awvalid	  : in std_logic;
		s00_axi_awready	  : out std_logic;
		s00_axi_wdata	    : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	    : in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	  : in std_logic;
		s00_axi_wready	  : out std_logic;
		s00_axi_bresp	    : out std_logic_vector(1 downto 0);
		s00_axi_bvalid	  : out std_logic;
		s00_axi_bready	  : in std_logic;
		s00_axi_araddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	  : in std_logic_vector(2 downto 0);
		s00_axi_arvalid	  : in std_logic;
		s00_axi_arready	  : out std_logic;
		s00_axi_rdata	    : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	    : out std_logic_vector(1 downto 0);
		s00_axi_rvalid	  : out std_logic;
		s00_axi_rready	  : in std_logic
	);
end component;

begin 

axi_register_inst : improc_controller_v1_0 
  generic map(  -- Users to add parameters here
                    HPIXELS => HPIXELS,    -- Horizontal Liv
                    VLINES  => VLINES ,    -- Vertical Live 
                    HSYNCPW => HSYNCPW,    -- HSYNC Pulse Wi
                    VSYNCPW => VSYNCPW,    -- VSYNC Pulse Wi
                    HFNPRCH => HFNPRCH,    -- Horizontal Fro
                    VFNPRCH => VFNPRCH,    -- Vertical Front
                    HBKPRCH => HBKPRCH,    -- Horizontal Bac
                    VBKPRCH => VBKPRCH,    -- Vertical Back 
                    BORDER  => BORDER ,     -- Left/Right/Up
                
                -- Parameters of Axi Slave Bus Interface S00_AXI
                  C_S00_AXI_DATA_WIDTH  => C_S00_AXI_DATA_WIDTH,
                  C_S00_AXI_ADDR_WIDTH  => C_S00_AXI_ADDR_WIDTH
  )
  port map(   s00_axi_aclk	     =>  clk,
              s00_axi_aresetn	   =>  not rst,
              s00_axi_awaddr	   =>  axi_awaddr	 ,
              s00_axi_awprot	   =>  axi_awprot	 ,
              s00_axi_awvalid	   =>  axi_awvalid ,
              s00_axi_awready	   =>  axi_awready ,
              s00_axi_wdata	     =>  axi_wdata	 ,
              s00_axi_wstrb	     =>  axi_wstrb	 ,
              s00_axi_wvalid	   =>  axi_wvalid	 ,
              s00_axi_wready	   =>  axi_wready	 ,
              s00_axi_bresp	     =>  axi_bresp	 ,
              s00_axi_bvalid	   =>  axi_bvalid	 ,
              s00_axi_bready	   =>  axi_bready	 ,
              s00_axi_araddr	   =>  axi_araddr	 ,
              s00_axi_arprot	   =>  axi_arprot	 ,
              s00_axi_arvalid	   =>  axi_arvalid ,
              s00_axi_arready	   =>  axi_arready ,
              s00_axi_rdata	     =>  axi_rdata	 ,
              s00_axi_rresp	     =>  axi_rresp	 ,
              s00_axi_rvalid	   =>  axi_rvalid	 ,
              s00_axi_rready	   =>  axi_rready	 ,
  
              THRESHOLD     => threshold ,
              HMASK         => mask_h,
              VMASK         => mask_v,
              DMASK0        => mask_d1,
              DMASK1        => mask_d2,

              STATUSREG     => status,
              CONTROLREG    => control,
              IMDATAREG0    => imgdata0,
              IMDATAREG1    => imgdata1
  );

dataflow_inst : dataflow 
  port map( clk => clk,
            rst => rst or RESET_FIFO,
            enable => enable,
            grey_data_in => PIXEL_TO_FILTER,
            threshold_in => threshold,
            mask1_in => mask_h,
            mask2_in => mask_v,
            ready => filter_ready,
            grey_data_out => pixel_to_output,
            grey_data_out_valid => pixel_to_output_valid

  );

cam_fsm_inst : cam_fsm
  port map( PIXEL_CLK => clk,
            RST => rst,
            FRAME_VALID => frame_valid,
            LINE_VALID => line_valid,
            DATA => pixel_in,
            RESET_FIFO => RESET_FIFO,
            PIXEL_VALID => PIXEL_VALID,
            PIXEL_OUT => PIXEL_TO_FILTER
  );

hdmi_fsm_inst : hdmi_fsm
  generic map(  -- Users to add parameters here
                HPIXELS => HPIXELS,    -- Horizontal Liv
                VLINES  => VLINES ,    -- Vertical Live 
                HSYNCPW => HSYNCPW,    -- HSYNC Pulse Wi
                VSYNCPW => VSYNCPW,    -- VSYNC Pulse Wi
                HFNPRCH => HFNPRCH,    -- Horizontal Fro
                VFNPRCH => VFNPRCH,    -- Vertical Front
                HBKPRCH => HBKPRCH,    -- Horizontal Bac
                VBKPRCH => VBKPRCH,    -- Vertical Back 
                BORDER  => BORDER      -- Left/Right/Up
  ) 
  port map( CLK     => clk, 
            RST     => rst,
            DIN     => pixel_to_output,
            HSYNC   => HSYNC, 
            VSYNC   => VSYNC, 
            ACTIVE  => ACTIVE,
            DOUT    => DOUT 
  );
end Behavioral;





