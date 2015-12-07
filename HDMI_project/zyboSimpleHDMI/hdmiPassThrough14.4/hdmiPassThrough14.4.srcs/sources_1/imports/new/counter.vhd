----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2015 10:59:40 AM
-- Design Name: 
-- Module Name: counter - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter2 is
    Port ( clk, rst: std_logic;
           enable : in STD_LOGIC;
           finished : out STD_LOGIC);
end counter2;

architecture Behavioral of counter2 is
    
    signal value: std_logic_vector(1 downto 0);
    
begin
    a: process (rst, clk)
    begin
        if rst = '1' then
            value <= "00";
            finished <= '0';
        else
            if rising_edge(clk) and enable = '1' then
               case value is
                    when "00" =>
                        value <= "01" after 1 ns;
                    when "01" =>
                        value <= "10" after 1 ns;
                    when "10" =>
                        value <= "11" after 1 ns;
                        finished <= '1';
                    when "11" =>
                        finished <= '1';
                    when others =>
                        assert true report "counter error" severity failure;   
                end case;
            end if;
        end if;
    
    end process;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter3 is
    Port ( clk, rst: std_logic;
           enable : in STD_LOGIC;
           finished : out STD_LOGIC);
end counter3;

architecture Behavioral of counter3 is
    
    signal value: std_logic_vector(1 downto 0);
    
begin
    a: process (rst, clk)
    begin
        if rst = '1' then
            value <= "00";
            finished <= '0';
        else
            if rising_edge(clk) and enable = '1' then
               case value is
                    when "00" =>
                        value <= "01" after 1 ns;
                    when "01" =>
                        value <= "10" after 1 ns;
                    when "10" =>
                        value <= "11" after 1 ns;
                    when "11" =>
                        finished <= '1';
                    when others =>
                        assert true report "counter error" severity failure;   
                end case;
            end if;
        end if;
    
    end process;
end Behavioral;