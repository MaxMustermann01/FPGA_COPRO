----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2015 01:38:52 PM
-- Design Name: 
-- Module Name: w_sum_user_logic_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE, ieee_proposed;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


--use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
--use ieee_proposed.float_pkg.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity w_sum_user_logic_tb is
--  Port ( );
end w_sum_user_logic_tb;

architecture Behavioral of w_sum_user_logic_tb is
    --component
component w_sum_user_logic is
    generic (
        C_S_AXI_DATA_WIDTH    : integer    := 32
    );
    Port ( S_AXI_ACLK : in STD_LOGIC;
           S_AXI_ARESETN : in STD_LOGIC;
           reg_0 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
           reg_1 : in STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
           reg_2 : out STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
           reg_3 : out STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
           bram1_rstb : IN STD_LOGIC;
           bram1_clkb : IN STD_LOGIC;
           bram1_enb : IN STD_LOGIC;
           bram1_web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           bram1_addrb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
           bram1_dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
           bram1_doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
           bram2_rstb : IN STD_LOGIC;
           bram2_clkb : IN STD_LOGIC;
           bram2_enb : IN STD_LOGIC;
           bram2_web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           bram2_addrb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
           bram2_dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
           bram2_doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
end component w_sum_user_logic;

        
        
        signal clk, rst_n, enable, ready: STD_LOGIC := '0';
        signal slv_reg0, slv_reg1, slv_reg2, slv_reg3: std_logic_vector (31 downto 0) := (others => '0');
        signal bram1_rstb :  STD_LOGIC := '0';
        signal bram1_enb :  STD_LOGIC := '0';
        signal bram1_web :  STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
        signal bram1_addrb :  STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
        signal bram1_addrb_con :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        signal bram1_dinb :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        signal bram1_doutb :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        signal bram2_rstb :  STD_LOGIC := '0';
        signal bram2_enb :  STD_LOGIC := '0';
        signal bram2_web :  STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
        signal bram2_addrb :  STD_LOGIC_VECTOR(9 DOWNTO 0) := (others => '0');
        signal bram2_addrb_con :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        signal bram2_dinb :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        signal bram2_doutb :  STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        
        signal y: integer;
        signal z: integer;
        
        constant ckTime: time := 10 ns;
        constant C_S_AXI_DATA_WIDTH    : integer    := 32;
begin

	-- Add user logic here
DUT:    w_sum_user_logic
    generic map (
            C_S_AXI_DATA_WIDTH    => C_S_AXI_DATA_WIDTH
            )
    port map (
        S_AXI_ACLK	=> clk,
        S_AXI_ARESETN    => rst_n,
        reg_0   => slv_reg0,
        reg_1   => slv_reg1,
        reg_2   => slv_reg2,
        reg_3   => slv_reg3,
        bram1_rstb => bram1_rstb,
        bram1_clkb => clk,
        bram1_enb =>bram1_enb,
        bram1_web =>bram1_web,
        bram1_addrb => bram1_addrb_con,
        bram1_dinb =>bram1_dinb,
        bram1_doutb=>bram1_doutb,
        bram2_rstb => bram2_rstb,
        bram2_clkb  => clk,
        bram2_enb =>bram2_enb,
        bram2_web =>bram2_web,
        bram2_addrb => bram2_addrb_con,
        bram2_dinb =>bram2_dinb,
        bram2_doutb=>bram2_doutb
    );
bram1_addrb_con <= "00000000000000000000" & bram1_addrb & "00";
bram2_addrb_con <= "00000000000000000000" & bram1_addrb & "00";
bram1_rstb <= rst_n;
bram2_rstb <= rst_n;

    ckProc: process
        begin
            clk <= '0';
            wait for ckTime/2;
            clk <= '1';
            wait for ckTime/2;
        end process;
    
    
        rProc: process
        begin
        
        -- reset
        rst_n <= '0';
        wait for 10 * ckTime;
        rst_n <= '1';
        wait;
        end process;
        
        sproc: process
        
        begin
            wait until falling_edge(clk);
            if rst_n = '1' then   
                
                --write bram
                bram1_enb <= '1';
                bram1_web  <= "0001";
                bram2_enb <= '1';
                bram2_web  <= "0001";
                for i in 0 to 127 loop
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8, 10));
                    bram1_dinb <= "00111111100000000000000000000000";-- 1.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8, 10));
                    bram2_dinb <= "00111101100000000000000000000000"; --0.0625
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+1, 10));
                    bram1_dinb <= "01000000000000000000000000000000";-- 2.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+1, 10));
                    bram2_dinb <= "00111110000000000000000000000000"; --0.125
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+2, 10));
                    bram1_dinb <= "01000000010000000000000000000000";-- 3.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+2, 10));
                    bram2_dinb <= "00111110100000000000000000000000"; --0.25
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+3, 10));
                    bram1_dinb <= "01000000100000000000000000000000";-- 4.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+3, 10));
                    bram2_dinb <= "00111110110000000000000000000000"; --0.375
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+4, 10));
                    bram1_dinb <= "01000000101000000000000000000000";-- 5.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+4, 10));
                    bram2_dinb <= "00111111000000000000000000000000"; -- 0.5
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+5, 10));
                    bram1_dinb <= "01000000110000000000000000000000";--6.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+5, 10));
                    bram2_dinb <= "00111111001000000000000000000000"; --0.625
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+6, 10));
                    bram1_dinb <= "01000000111000000000000000000000";--7.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+6, 10));
                    bram2_dinb <= "00111111010000000000000000000000"; -- 0.75
                    wait until falling_edge(clk);
                    bram1_addrb <= std_logic_vector (to_unsigned(i*8+7, 10));
                    bram1_dinb <= "01000001000000000000000000000000";--8.0
                    bram2_addrb <= std_logic_vector (to_unsigned(i*8+7, 10));
                    bram2_dinb <= "00111111011000000000000000000000"; --0.875
                    wait until falling_edge(clk);
                end loop;
                
                bram1_enb <= '0';
                bram1_web  <= "000";
                bram2_enb <= '0';
                bram2_web  <= "000";
                
                --wait ten cycles
                for i in 0 to 9 loop   
                    wait until falling_edge(clk);
                end loop;
                
                --START
                slv_reg0 <= (0 => '1', others => '0');
                
                --wait till finished
                while (slv_reg2 = x"0000_0000") or (slv_reg2 = x"0000_0001") or (slv_reg2 = x"0000_0002") loop  
                    wait until falling_edge(clk);
                end loop;

                --reset
                slv_reg0 <= (1 => '1', others => '0');
                
                for i in 0 to 10 loop
                    wait until falling_edge(clk);
                end loop;
                --no ctrlSeq
                slv_reg0 <= (others => '0');
                
                  --START
                              slv_reg0 <= (0 => '1', others => '0');
                              
                              --wait till finished
                              while (not(slv_reg2 = x"0000_0003")) loop  
                                  wait until falling_edge(clk);
                              end loop;
              
                              --reset
                              slv_reg0 <= (1 => '1', others => '0');
                              
                              for i in 0 to 10 loop
                                  wait until falling_edge(clk);
                              end loop;
                              --no ctrlSeq
                              slv_reg0 <= (others => '0');

                wait;                            
            end if;
        end process;   
end Behavioral;
