library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity improc_controller_v1_0 is
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
	port (
		-- Users to add ports here
        THRESHOLD : out std_logic_vector(9 downto 0); -- Threshold
        HMASK : inout std_logic_vector(26 downto 0); -- Horizontal Maskvalues
        VMASK : inout std_logic_vector(26 downto 0); -- Vertical Maskvalues
        DMASK0 : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues0
        DMASK1 : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues1
                        
        STATUSREG : out std_logic_vector(31 downto 0); -- Statusregister
        CONTROLREG : inout std_logic_vector(31 downto 0); -- Controlregister
        IMDATAREG0 : inout std_logic_vector(31 downto 0); -- Imagedataregister0
        IMDATAREG1 : inout std_logic_vector(31 downto 0); -- Imagedataregister1
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end improc_controller_v1_0;

architecture arch_imp of improc_controller_v1_0 is

	-- component declaration
	component improc_controller_v1_0_S00_AXI is
		generic (
		HPIXELS : integer := 1280;  -- Horizontal Live Pixels
        VLINES : integer :=  720;  -- Vertical Live Lines
        HSYNCPW : integer :=   80;  -- HSYNC Pulse Width
        VSYNCPW : integer :=    2;  -- VSYNC Pulse Width
        HFNPRCH : integer :=   72;  -- Horizontal Front Portch
        VFNPRCH : integer :=    3;  -- Vertical Front Portch
        HBKPRCH : integer :=  216;  -- Horizontal Back Portch
        VBKPRCH : integer :=   22;  -- Vertical Back Portch
        BORDER : integer :=    1;   -- Left/Right/Up/Bottom Border Size
		
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 7
		);
		port (
		THRESHOLD : out std_logic_vector(7 downto 0); -- Threshold
        HMASK : inout std_logic_vector(26 downto 0); -- Horizontal Maskvalues
        VMASK : inout std_logic_vector(26 downto 0); -- Vertical Maskvalues
        DMASK0 : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues0
        DMASK1 : inout std_logic_vector(26 downto 0); -- Diagonal Maskvalues1
                               
        STATUSREG : out std_logic_vector(31 downto 0); -- Statusregister
        CONTROLREG : inout std_logic_vector(31 downto 0); -- Controlregister
        IMDATAREG0 : inout std_logic_vector(31 downto 0); -- Imagedataregister0
        IMDATAREG1 : inout std_logic_vector(31 downto 0); -- Imagedataregister1
		
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component improc_controller_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
--improc_controller_v1_0_S00_AXI_inst : improc_controller_v1_0_S00_AXI
--	generic map (
--	    HPIXELS => HPIXELS, 
--        VLINES => VLINES, 
--        HSYNCPW => HSYNCPW, 
--        VSYNCPW => VSYNCPW, 
--        HFNPRCH => HFNPRCH,
--        VFNPRCH => VFNPRCH, 
--        HBKPRCH => HBKPRCH, 
--        VBKPRCH => VBKPRCH, 
--        BORDER => BORDER, 
	    
--		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
--		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
--	)
--	port map (
--	    THRESHOLD => THRESHOLD, 
--        HMASK => HMASK, 
--        VMASK => VMASK, 
--        DMASK0 => DMASK0, 
--        DMASK1 => DMASK1,
                                    
--        STATUSREG => STATUSREG, 
--        CONTROLREG => CONTROLREG, 
--        IMDATAREG0 => IMDATAREG0, 
--        IMDATAREG1 => IMDATAREG1, 
	
--		S_AXI_ACLK	=> s00_axi_aclk,
--		S_AXI_ARESETN	=> s00_axi_aresetn,
--		S_AXI_AWADDR	=> s00_axi_awaddr,
--		S_AXI_AWPROT	=> s00_axi_awprot,
--		S_AXI_AWVALID	=> s00_axi_awvalid,
--		S_AXI_AWREADY	=> s00_axi_awready,
--		S_AXI_WDATA	=> s00_axi_wdata,
--		S_AXI_WSTRB	=> s00_axi_wstrb,
--		S_AXI_WVALID	=> s00_axi_wvalid,
--		S_AXI_WREADY	=> s00_axi_wready,
--		S_AXI_BRESP	=> s00_axi_bresp,
--		S_AXI_BVALID	=> s00_axi_bvalid,
--		S_AXI_BREADY	=> s00_axi_bready,
--		S_AXI_ARADDR	=> s00_axi_araddr,
--		S_AXI_ARPROT	=> s00_axi_arprot,
--		S_AXI_ARVALID	=> s00_axi_arvalid,
--		S_AXI_ARREADY	=> s00_axi_arready,
--		S_AXI_RDATA	=> s00_axi_rdata,
--		S_AXI_RRESP	=> s00_axi_rresp,
--		S_AXI_RVALID	=> s00_axi_rvalid,
--		S_AXI_RREADY	=> s00_axi_rready
--	);

	-- Add user logic here
     THRESHOLD <= X"5F"&"00";--slv_reg0(7 downto 0);
     HMASK <=  "111000001110000010111000001";--slv_reg1(26 downto 0); -- Horizontal Maskvalues
     VMASK <= "111000001110000010111000001";--slv_reg2(26 downto 0); -- Vertical Maskvalues
     DMASK0 <= "000000000000000000000000000";--slv_reg3(26 downto 0); -- Diagonal Maskvalues0
     DMASK1 <= "000000000000000000000000000";--slv_reg4(26 downto 0); -- Diagonal Maskvalues1
                       
--     HPIXELS <= slv_reg5(1280);  -- Horizontal Live Pixels
--     VLINES <= slv_reg6(720);  -- Vertical Live Lines
--     HSYNCPW <= slv_reg7(80);  -- HSYNC Pulse Width
--     VSYNCPW <= slv_reg8(2);  -- VSYNC Pulse Width
--     HFNPRCH <= slv_reg9(72);  -- Horizontal Front Portch
--     VFNPRCH <= slv_reg10(3);  -- Vertical Front Portch
--     HBKPRCH <= slv_reg11(216);  -- Horizontal Back Portch
--     VBKPRCH <= slv_reg12(22);  -- Vertical Back Portch
--     BORDER <= slv_reg13(1);   -- Left/Right/Up/Bottom Border Size
       
--     STATUSREG <= slv_reg14(31 downto 0); -- Statusregister
--     CONTROLREG <= slv_reg15(31 downto 0); -- Controlregister
--     IMDATAREG0 <= slv_reg16(31 downto 0); -- Imagedataregister0
--     IMDATAREG1 <= slv_reg17(31 downto 0); -- Imagedataregister1
	-- User logic ends

end arch_imp;