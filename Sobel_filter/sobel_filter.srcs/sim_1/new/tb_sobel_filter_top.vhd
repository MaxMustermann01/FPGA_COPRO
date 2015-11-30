library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;



entity tb_sobel_filter_top is

end entity;


architecture Behaviour of tb_sobel_filter_top is

component sobel_filter_top is
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
        BORDER  : integer :=    1;  -- Left/Right/Up/Bottom Border Size  
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 7
	);
  port(  
            axi_awaddr	  : in std_logic_vector(7-1 downto 0);
            axi_awprot	  : in std_logic_vector(2 downto 0);
            axi_awvalid	  : in std_logic;
            axi_awready	  : out std_logic;
            axi_wdata	    : in std_logic_vector(32-1 downto 0);
            axi_wstrb	    : in std_logic_vector((32/8)-1 downto 0);
            axi_wvalid	  : in std_logic;
            axi_wready	  : out std_logic;
            axi_bresp	    : out std_logic_vector(1 downto 0);
            axi_bvalid	  : out std_logic;
            axi_bready	  : in std_logic;
            axi_araddr	  : in std_logic_vector(7-1 downto 0);
            axi_arprot	  : in std_logic_vector(2 downto 0);
            axi_arvalid	  : in std_logic;
            axi_arready	  : out std_logic;
            axi_rdata	    : out std_logic_vector(32-1 downto 0);
            axi_rresp	    : out std_logic_vector(1 downto 0);
            axi_rvalid	  : out std_logic;
            axi_rready	  : in std_logic;
  
            clk           : in std_logic;
            rst           : in std_logic; 
            enable        : in std_logic;
            frame_valid   : in std_logic;
            line_valid    : in std_logic;
            pixel_in      : in std_logic_vector (7 downto 0);
            HSYNC, VSYNC, ACTIVE : OUT std_logic;
            DOUT          : OUT std_logic_vector(23 downto 0)
    
  );
end component;

component Camera_HIL is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			     PIXEL_CLK : out  STD_LOGIC;
			     LINE_VALID : out  STD_LOGIC;
			     FRAME_VALID : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal axi_awaddr	  : std_logic_vector(7-1 downto 0);
signal axi_awprot	  : std_logic_vector(2 downto 0);
signal axi_awvalid	: std_logic;
signal axi_awready	: std_logic;
signal axi_wdata	  : std_logic_vector(32-1 downto 0);
signal axi_wstrb	  : std_logic_vector((32/8)-1 downto 0);
signal axi_wvalid	  : std_logic;
signal axi_wready	  : std_logic;
signal axi_bresp	  : std_logic_vector(1 downto 0);
signal axi_bvalid	  : std_logic;
signal axi_bready	  : std_logic;
signal axi_araddr	  : std_logic_vector(7-1 downto 0);
signal axi_arprot	  : std_logic_vector(2 downto 0);
signal axi_arvalid	: std_logic;
signal axi_arready	: std_logic;
signal axi_rdata	  : std_logic_vector(32-1 downto 0);
signal axi_rresp	  : std_logic_vector(1 downto 0);
signal axi_rvalid	  : std_logic;
signal axi_rready	  : std_logic;

signal clk          : std_logic;
signal glob_clk     : std_logic;
signal rst          : std_logic; 
signal enable       : std_logic;
signal frame_valid  : std_logic;
signal line_valid   : std_logic;
signal pixel_in     : std_logic_vector (7 downto 0);
signal HSYNC, VSYNC, ACTIVE : std_logic;
signal DOUT         : std_logic_vector(23 downto 0);
signal data_out     : std_logic_vector(7 downto 0);

constant CLK_PERIOD :time := 10ns;--ns

begin

clk_process : process 
begin
  glob_clk <= '1';
  wait for CLK_PERIOD/2;
  glob_clk <= '0';
  wait for CLK_PERIOD/2;
end process;

reset_proc : process
begin
  rst <= '1';
  wait for 10*CLK_PERIOD;
  rst <= '0';
  wait;
end process;

camera_hil_inst : camera_hil
  port map(
             CLK          => glob_clk,
             RST          => rst,
             PIXEL_CLK    => clk,
             LINE_VALID   => line_valid,
             FRAME_VALID  => frame_valid,
             DATA_OUT     => pixel_in
  );

uut : sobel_filter_top 
 
  port map(
   axi_awaddr	  =>  axi_awaddr	,
   axi_awprot	  =>  axi_awprot	,
   axi_awvalid	=>  axi_awvalid ,  
   axi_awready	=>  axi_awready ,  
   axi_wdata	  =>  axi_wdata	  ,  
   axi_wstrb	  =>  axi_wstrb	  ,  
   axi_wvalid	  =>  axi_wvalid	,
   axi_wready	  =>  axi_wready	,
   axi_bresp	  =>  axi_bresp	  ,  
   axi_bvalid	  =>  axi_bvalid	,
   axi_bready	  =>  axi_bready	,
   axi_araddr	  =>  axi_araddr	,
   axi_arprot	  =>  axi_arprot	,
   axi_arvalid	=>  axi_arvalid ,  
   axi_arready	=>  axi_arready ,  
   axi_rdata	  =>  axi_rdata	  ,  
   axi_rresp	  =>  axi_rresp	  ,  
   axi_rvalid	  =>  axi_rvalid	,
   axi_rready	  =>  axi_rready	,
  
   clk          =>  clk         , 
   rst          =>  rst         , 
   enable       =>  enable      , 
   frame_valid  =>  frame_valid , 
   line_valid   =>  line_valid  , 
   pixel_in     =>  pixel_in    , 
   HSYNC        =>  HSYNC       ,
   VSYNC        =>  VSYNC       ,
   ACTIVE       =>  ACTIVE      ,
   DOUT         =>  DOUT       
  );

end architecture;
