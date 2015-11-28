library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hdmi_fsm is

generic (		HPIXELS : integer := 1280;  -- Horizontal Live Pixels
			VLINES 	: integer :=  720;  -- Vertical Live ines
			HSYNCPW	: integer :=   80;  -- HSYNC Pulse Width
			VSYNCPW : integer :=    2;  -- VSYNC Pulse Width
			HFNPRCH	: integer :=   72;  -- Horizontal Front Portch
			VFNPRCH	: integer :=	3;  -- Vertical Front Portch
			HBKPRCH	: integer :=  216;  -- Horizontal Back Portch
			VBKPRCH	: integer :=   22;  -- Vertical Back Portch
			BORDER	: integer :=    1   -- Left/Right/Up/Bottom Border Size
			);
			
port(   CLK, RST : IN std_logic;
        DIN : IN  std_logic_vector(7 downto 0);
        HSYNC, VSYNC, ACTIVE : OUT std_logic;
		  DOUT : OUT std_logic_vector(23 downto 0));
		  
end hdmi_fsm;

architecture Behavioral of hdmi_fsm is
	type STATE_TYPE is  (START, VERTICAL_SYNC_PULSE, VERTICAL_BACK_PORCH, HORIZONTAL_SYNC_PULSE,
								HORIZONTAL_BACK_PORCH, TOP_BOTTOM_BORDER, LEFT_BORDER, RIGHT_BORDER,
								ACTIVE_PIXEL, HORIZONTAL_FRONT_PORCH, VERTICAL_FRONT_PORCH);
    signal STATE : STATE_TYPE := START;
	 signal top_border, bottom_border : std_logic := '0';
begin

	process(CLK, RST)
		variable h_count : integer := 0;
		variable v_count : integer := 0;
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				STATE <= START;
			else
				case STATE is
				
				when START =>
					HSYNC <= '0';
					VSYNC <= '0';
					ACTIVE <= '0';
					h_count := 0;
					v_count := 0;
					top_border <= '1';
					bottom_border <= '0';
					DOUT <= X"000000";
					STATE <= VERTICAL_SYNC_PULSE;
					
				when VERTICAL_SYNC_PULSE =>
					VSYNC <= '1';
					v_count := v_count + 1;
					if v_count < VSYNCPW then
						STATE <= VERTICAL_SYNC_PULSE;
					else
						STATE <= VERTICAL_BACK_PORCH;
					end if;
					
				when VERTICAL_BACK_PORCH =>
					VSYNC <= '0';
					v_count := v_count + 1;
					if v_count < (VBKPRCH + VSYNCPW) then
						STATE <= VERTICAL_BACK_PORCH;
					else
						STATE <= HORIZONTAL_SYNC_PULSE;
					end if;
					
				when HORIZONTAL_SYNC_PULSE =>
					HSYNC <= '1';
					h_count := h_count + 1;
					if h_count < HSYNCPW then
						STATE <= HORIZONTAL_SYNC_PULSE;
					else
						STATE <= HORIZONTAL_BACK_PORCH;
					end if;
					
				when HORIZONTAL_BACK_PORCH =>
					HSYNC <= '0';
					h_count := h_count + 1;
					if h_count < (HBKPRCH + HSYNCPW) then
						STATE <= HORIZONTAL_BACK_PORCH;
					elsif top_border = '1' then
						STATE <= TOP_BOTTOM_BORDER;
						top_border <= '0';
					elsif bottom_border = '1' then
						STATE <= TOP_BOTTOM_BORDER;
						bottom_border <= '0';
					else
						STATE <= LEFT_BORDER;
					end if;
					
				when TOP_BOTTOM_BORDER =>
					h_count := h_count + 1;
					ACTIVE <= '1';
					DOUT <= X"000000";
					if h_count < (HPIXELS + HBKPRCH + HSYNCPW) then
						STATE <= TOP_BOTTOM_BORDER;
					else
						ACTIVE <= '0';
						STATE <= HORIZONTAL_FRONT_PORCH;
					end if;
					
				when LEFT_BORDER =>
					h_count := h_count + 1;
					ACTIVE <= '1';
					DOUT <= X"000000";
					if h_count < (HBKPRCH + HSYNCPW + BORDER) then
						STATE <= LEFT_BORDER;
					else
						STATE <= ACTIVE_PIXEL;
					end if;
					
				when RIGHT_BORDER =>
					h_count := h_count + 1;
					ACTIVE <= '1';
					DOUT <= X"000000";
					if h_count < (HBKPRCH + HSYNCPW + BORDER) then
						STATE <= RIGHT_BORDER;
					else
						STATE <= HORIZONTAL_FRONT_PORCH;
						ACTIVE <= '0';
					end if;
					
				when ACTIVE_PIXEL =>
					h_count := h_count + 1;
					ACTIVE <= '1';
					if DIN = (7 downto 0=>'0') then
						DOUT <= X"000000";
					else
						DOUT <= X"FFFFFF";
					end if;
					if h_count < (HBKPRCH + HSYNCPW + HPIXELS - BORDER - BORDER) then
						STATE <= ACTIVE_PIXEL;
					else
						STATE <= RIGHT_BORDER;
					end if;
					
				when HORIZONTAL_FRONT_PORCH =>
					h_count := h_count + 1;
					if h_count < (HFNPRCH + HBKPRCH + HSYNCPW + HPIXELS) then
						STATE <= HORIZONTAL_FRONT_PORCH;
					else
						HSYNC <= '1';
						h_count := 0;
						v_count := v_count + 1;
						if v_count < (VLINES + VBKPRCH + VSYNCPW) then
							if v_count = (VLINES + VBKPRCH + VSYNCPW - BORDER) then
								bottom_border <= '1';
							end if;
							STATE <= HORIZONTAL_SYNC_PULSE;
						else
							STATE <= VERTICAL_FRONT_PORCH;
						end if;
					end if;
					
				when VERTICAL_FRONT_PORCH =>
					v_count := v_count + 1;
					if v_count < (VLINES + VBKPRCH + VSYNCPW + VFNPRCH) then
						STATE <= VERTICAL_FRONT_PORCH;
					else
						STATE <= START;
						VSYNC <= '1';
					end if;
					
				end case;
			end if;
		end if;
	end process;

end Behavioral;