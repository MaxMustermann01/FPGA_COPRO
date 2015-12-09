----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2015 02:23:26 PM
-- Design Name: 
-- Module Name: sobel_calc - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package pixel_value_type is
--type pixel_value is Array (8 downto 0 ) of std_logic_vector (7 downto 0);
type multiplication_value is Array (8 downto 0 ) of std_logic_vector (8 downto 0);
--type filter_value is Array (8 downto 0) of std_logic_vector (2 downto 0);
end package pixel_value_type;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use work.pixel_value_type.all;

entity sobel_calc is
    --generic (FILTER_VALUE_DATAWIDTH : integer := 3);   -- datawidth of the filter values including sign 
    Port ( clk : in STD_LOGIC;                        -- clock signal
           rst : in STD_LOGIC;                        -- reset signal low active
           en : in STD_LOGIC;                         -- enable signal
           in_valid : in STD_LOGIC;                   -- input valid signal
           out_valid : out STD_LOGIC;                 -- output valid signal

           in_value : in std_logic_vector (71 downto 0);  -- Array with 9 entrys of 8bit vectors
                                                      --  value array with following structure
                                                      --  --                        --
                                                      --  | val(0) , val(1) , val(2) |
                                                      --  | val(3) , val(4) , val(5) |
                                                      --  | val(6) , val(7) , val(8) |
                                                      --  --                        --
           threshold : in std_logic_vector(9 downto 0);

           filter : in std_logic_vector (26 downto 0); -- filter array. same structure as value array

           out_value : out STD_LOGIC_VECTOR (7 downto 0)); -- calculated output value at center position
end sobel_calc;

architecture Behavioral of sobel_calc is

signal mult_val : multiplication_value;
signal mult_val_valid : std_logic;
signal sum_val : std_logic_vector (9 downto 0);
signal sum_val_valid : std_logic;

begin


process (clk, rst)
variable i : integer;
  begin
    if rst = '0' then
      for i in 0 to 8 loop
        mult_val(i) <= b"000000000";
        mult_val_valid <= '0';
      end loop;
    elsif rising_edge(clk) then
      if en = '1' then
        for i in 0 to 8 loop
          if to_integer(signed(filter(((i+1)*3-1) downto (i*3)))) = -2 then
            mult_val(i) <= in_value(((i+1)*8-1) downto (i*8)) & '0';
          elsif to_integer(signed(filter(((i+1)*3-1) downto (i*3)))) = 2 then
            mult_val(i) <= in_value(((i+1)*8-1) downto (i*8)) & '0';
	        elsif to_integer(signed(filter(((i+1)*3-1) downto (i*3)))) = -1 then
            mult_val(i) <= '0' & in_value(((i+1)*8-1) downto (i*8));
	        elsif to_integer(signed(filter(((i+1)*3-1) downto (i*3)))) = 1 then
            mult_val(i) <= '0' & in_value(((i+1)*8-1) downto (i*8));
          else 
            mult_val(i) <= b"000000000";
          end if;
          --mult_val(i) <= in_value(((i+1)*8-1) downto (i*8)) * filter(((i+1)*3-1) downto (i*3));
          mult_val_valid <= in_valid;
        end loop; -- i
      end if;--enable
    end if;--posedge clk
  end process;

process (clk, rst)
variable j : integer;
variable sum_mult_val : integer;
  begin
    if rst = '0' then
      sum_mult_val := 0;
      sum_val <= x"00"&"00";
      sum_val_valid <= '0';
    elsif rising_edge(clk) then
      if en = '1' then
        sum_mult_val := 0;
        for j in mult_val'range loop
          if to_integer(signed(filter(((j+1)*3-1) downto (j*3)))) = -2 then
            sum_mult_val := sum_mult_val - to_integer(unsigned(mult_val(j)));
          elsif to_integer(signed(filter(((j+1)*3-1) downto (j*3)))) = 2 then
            sum_mult_val := sum_mult_val + to_integer(unsigned(mult_val(j)));
          elsif to_integer(signed(filter(((j+1)*3-1) downto (j*3)))) = -1 then
            sum_mult_val := sum_mult_val - to_integer(unsigned(mult_val(j)));
          elsif to_integer(signed(filter(((j+1)*3-1) downto (j*3)))) = 1 then
            sum_mult_val := sum_mult_val + to_integer(unsigned(mult_val(j)));
          end if;
        end loop;
        if sum_mult_val < 0 then
          sum_val <= std_logic_vector(to_signed(-sum_mult_val,10));
        else
          sum_val <= std_logic_vector(to_signed(sum_mult_val,10));
        end if;
        --sum_val <= std_logic_vector(to_signed(sum_mult_val,10));
        sum_val_valid <= mult_val_valid;
      end if;--enable
    end if; -- posedge clk
      
  end process;
  
process (clk, rst)
  begin
    if rst = '0' then
      out_value <= x"00";
      out_valid <= '0';
    elsif rising_edge(clk) then
      if en = '1' then
        if to_integer(unsigned(sum_val)) >= to_integer(unsigned(threshold)) then
          out_value <= x"FF";
        else
          out_value <= x"00";
        end if; -- sum_val >= threshold
        out_valid <= sum_val_valid;
      end if; --if enable
    end if; --posedge clk
  end process;
  

end Behavioral;
