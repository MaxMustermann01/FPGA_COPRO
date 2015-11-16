LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_hdmi_fsm IS
END tb_hdmi_fsm;
 
ARCHITECTURE behavior OF tb_hdmi_fsm IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT hdmi_fsm
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DIN : IN  std_logic_vector(7 downto 0);
         HSYNC : OUT  std_logic;
         VSYNC : OUT  std_logic;
         ACTIVE : OUT  std_logic;
         DOUT : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal DIN : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal HSYNC : std_logic;
   signal VSYNC : std_logic;
   signal ACTIVE : std_logic;
   signal DOUT : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: hdmi_fsm PORT MAP (
          CLK => CLK,
          RST => RST,
          DIN => DIN,
          HSYNC => HSYNC,
          VSYNC => VSYNC,
          ACTIVE => ACTIVE,
          DOUT => DOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		DIN <= X"FF";
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
