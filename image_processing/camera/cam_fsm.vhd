library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cam_fsm is
	port ( PIXEL_CLK : in  STD_LOGIC; 
			 RST : in  STD_LOGIC;
			 FRAME_VALID : in  STD_LOGIC;
			 LINE_VALID : in  STD_LOGIC;
			 DATA : in  STD_LOGIC_VECTOR (7 downto 0);
			 RESET_FIFO : out STD_LOGIC;
			 PIXEL_VALID : out  STD_LOGIC;
          PIXEL_OUT : out  STD_LOGIC_VECTOR (7 downto 0));			 
end cam_fsm;

architecture Behavioral of cam_fsm is
	type FSM_STATE is  (RESET, WAIT_FOR_FRAME, WAIT_FOR_LINE, CAPTURE);
   signal current_state : FSM_STATE :=RESET ;
	signal DATA_Z1 : STD_LOGIC_VECTOR (7 downto 0);
begin

	-- update data buffer
	process(RST, PIXEL_CLK)
	begin
	if RST = '1' then
		DATA_Z1 <= "00000000";
	else
		if rising_edge(PIXEL_CLK) then
			DATA_Z1 <= DATA;
		end if;
	end if;
	end process;
	
	-- choose next  state
	process(RST, PIXEL_CLK)
	begin
	if RST = '1' then
		current_state <= RESET;
	else
		if rising_edge(PIXEL_CLK) then
			-- switch over states
			case current_state is
				when RESET =>
					current_state <= WAIT_FOR_FRAME;
				when WAIT_FOR_FRAME =>
					if FRAME_VALID = '1' and LINE_VALID = '1' then
						current_state <= CAPTURE;
					elsif FRAME_VALID = '1' then
						current_state <= WAIT_FOR_LINE;
					else
						current_state <= WAIT_FOR_FRAME;
					end if;					
				when WAIT_FOR_LINE =>
					if FRAME_VALID = '0' then
						current_state <= WAIT_FOR_FRAME;
					elsif LINE_VALID = '1' then
						current_state <= CAPTURE;
					else
						current_state <= WAIT_FOR_LINE;
					end if;
				when CAPTURE =>
					if LINE_VALID = '1' and FRAME_VALID = '1' then
						current_state <= CAPTURE;
					elsif LINE_VALID = '0' and FRAME_VALID = '1' then
						current_state <= WAIT_FOR_LINE;
					elsif	FRAME_VALID = '0' then
						current_state <= WAIT_FOR_FRAME;
					end if;					
			end case;
		end if;
	end if;
	end process;
	
	-- output
	process(RST, PIXEL_CLK)
	begin
	if RST = '1' then
		RESET_FIFO <= '1';
		PIXEL_VALID <= '0';
		PIXEL_OUT <= "00000000";
	else
		if rising_edge(PIXEL_CLK) then
			-- switch over states
			case current_state is
				when RESET =>
					RESET_FIFO <= '1';
					PIXEL_VALID <= '0';
					PIXEL_OUT <= "00000000";		
				when WAIT_FOR_FRAME =>
					RESET_FIFO <= '1';
					PIXEL_VALID <= '0';
					PIXEL_OUT <= "00000000";		
				when WAIT_FOR_LINE =>
					RESET_FIFO <= '0';
					PIXEL_VALID <= '0';
					PIXEL_OUT <= "00000000";		
				when CAPTURE =>
					RESET_FIFO <= '0';
					PIXEL_VALID <= '1';
					PIXEL_OUT <= DATA_Z1;
			end case;
		end if;
	end if;
	end process;

end Behavioral;
