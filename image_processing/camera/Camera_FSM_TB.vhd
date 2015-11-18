--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:28:33 11/09/2015
-- Design Name:   
-- Module Name:   /media/sf_FPGA/ex03/FSM_Stimu/Camera_FSM_TB.vhd
-- Project Name:  FSM_Stimu
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Camera_FSM_TB IS
END Camera_FSM_TB;
 
ARCHITECTURE behavior OF Camera_FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   COMPONENT cam_fsm
	PORT(
		PIXEL_CLK : IN std_logic;
		RST : IN std_logic;
		FRAME_VALID : IN std_logic;
		LINE_VALID : IN std_logic;
		DATA : IN std_logic_vector(7 downto 0);          
		RESET_FIFO : OUT std_logic;
		PIXEL_VALID : OUT std_logic;
		PIXEL_OUT : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
    

   --Inputs
   signal PIXEL_CLK : std_logic := '0';
	signal RST : std_logic := '0';
   signal FRAME_VALID : std_logic := '0';
   signal LINE_VALID : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
	signal RESET_FIFO : std_logic;
   signal PIXEL_VALID : std_logic;
   signal PIXEL_OUT : std_logic_vector(7 downto 0);
	
	--Helper
	signal line_count : integer := 0;
	signal length_count : integer := 0;
	

   -- Clock period definition
	-- 40 Mhz
   constant PIXEL_CLK_period : time := 25 ns;
	-- Image Size
	constant line_width : integer := 1280;
	constant lines : integer := 720;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: cam_fsm PORT MAP(
		PIXEL_CLK => PIXEL_CLK,
		RST => RST,
		FRAME_VALID => FRAME_VALID,
		LINE_VALID => LINE_VALID,
		DATA => DATA,
		RESET_FIFO => RESET_FIFO,
		PIXEL_VALID => PIXEL_VALID,
		PIXEL_OUT => PIXEL_OUT
	);

   -- Clock process definitions
   PIXEL_CLK_process :process
   begin
		PIXEL_CLK <= '0';
		wait for PIXEL_CLK_period/2;
		PIXEL_CLK <= '1';
		wait for PIXEL_CLK_period/2;
   end process;
	
	DATA_create_process : process (PIXEL_CLK)
	begin
		if (RST = '1') then
			DATA <= "00000000";
		elsif (rising_edge(PIXEL_CLK)) then
			if(LINE_VALID = '1') then
				DATA <= std_logic_vector(unsigned(DATA)+1);
			end if;
		end if;
	end process;
	
	FRAME_Process : process (PIXEL_CLK, RST)
	begin
		if (RST = '1') then
		
		elsif (rising_edge(PIXEL_CLK)) then
			if (FRAME_VALID = '1') then
				if(length_count = 0) then
				LINE_VALID <= '1';
				length_count <= length_count +1;
				elsif (length_count = line_width +1) then --todo bed. überprüfen
				LINE_VALID <= '0';
				length_count <= 0;
				line_count <= line_count +1;
				elsif (line_count = lines) then
				LINE_VALID <= '0';
				FRAME_VALID <= '0';
				line_count <= 0;
				length_count <= 0;
				else 
				length_count <= length_count +1;
				end if;
			else
				FRAME_VALID <= '1';
			end if;
		end if;
	end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;	
		RST <= '0';

      wait for PIXEL_CLK_period*10;
		--FRAME_VALID <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
