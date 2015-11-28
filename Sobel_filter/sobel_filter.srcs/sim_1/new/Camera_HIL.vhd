----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:50 11/22/2015 
-- Design Name: 
-- Module Name:    Camera_HIL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Camera_HIL is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  PIXEL_CLK : out  STD_LOGIC;
			  LINE_VALID : out  STD_LOGIC;
			  FRAME_VALID : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end Camera_HIL;

architecture Behavioral of Camera_HIL is

	--Helper
	signal line_count : integer := 0;
	signal length_count : integer := 0;
	signal LV : STD_LOGIC;
	signal FV : STD_LOGIC;
	signal DATA : STD_LOGIC_VECTOR (7 downto 0);
	

   -- Clock period definition
	-- 40 Mhz
   -- constant PIXEL_CLK_period : time := 25 ns;
	-- Image Size
	constant line_width : integer := 1280;
	constant lines : integer := 720;

begin

	PIXEL_CLK <= CLK;
	LINE_VALID <= LV;
	FRAME_VALID <= FV;
	DATA_OUT <= DATA;
	
	DATA_create_process : process (CLK, RST)
	begin
		if (RST = '1') then
			DATA <= "00000000";
		elsif (rising_edge(CLK)) then
			if(LV = '1') then
				DATA <= std_logic_vector(unsigned(DATA)+1);
			end if;
		end if;
	end process;
	
	FRAME_Process : process (CLK, RST)
	begin
		if (RST = '1') then
		
		elsif (rising_edge(CLK)) then
			if (FV = '1') then
				if(length_count = 0) then
				LV <= '1';
				length_count <= length_count +1;
				elsif (length_count = line_width +1) then --todo bed. überprüfen
				LV <= '0';
				length_count <= 0;
				line_count <= line_count +1;
				elsif (line_count = lines) then
				LV <= '0';
				FV <= '0';
				line_count <= 0;
				length_count <= 0;
				else 
				length_count <= length_count +1;
				end if;
			else
				FV <= '1';
			end if;
		end if;
	end process;

end Behavioral;