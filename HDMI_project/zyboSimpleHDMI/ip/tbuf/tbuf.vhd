
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tbuf is 
    port (
        i: in std_logic;
        t: in std_logic;
        o: out std_logic;
        p: inout std_logic
        );
end entity;

architecture a of tbuf is

begin

    p <= i when t = '0' else 'Z';
    o <= p;

end a;

