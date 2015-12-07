----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2015 02:20:50 PM
-- Design Name: 
-- Module Name: dataflow - Behavioral
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataflow is
    --generic (
		-- Users to add parameters here
        --threshold_in : integer := 0;
        --mask1_in : integer := 0;
        --mask2_in : integer := 0;
        --delay : integer := 0
    --);
    Port ( clk, rst, enable: in STD_LOGIC;
           hsync_in : in std_logic;
           vsync_in : in std_logic;
           --grey_data_in : in STD_LOGIC_VECTOR (7 downto 0);
           grey_data_in : in STD_LOGIC_VECTOR (5 downto 0);
           --grey_data_out : out std_logic_vector (7 downto 0);
           rb_data_out : out std_logic_vector (4 downto 0);
           g_data_out : out std_logic_vector (5 downto 0);
           grey_data_out_valid : out std_logic;
           hsync_out : out std_logic;
           vsync_out : out std_logic;
           threshold_in : in STD_LOGIC_VECTOR (9 downto 0);
           mask1_in : in STD_LOGIC_VECTOR (26 downto 0);
           mask2_in : in STD_LOGIC_VECTOR (26 downto 0);
           delay : in std_logic_vector (9 downto 0);
           ready: out std_logic);
end dataflow;

architecture Behavioral of dataflow is
    signal rst_n: std_logic;
    signal rst_delay_n: std_logic;
    signal rst_delay: std_logic; --delay the reset because fifos need 3 cycles after rst to start work;
    
    signal reg11, reg12, reg13: STD_LOGIC_VECTOR(7 downto 0);
    signal reg21, reg22, reg23: STD_LOGIC_VECTOR(7 downto 0);
    signal reg31, reg32, reg33: STD_LOGIC_VECTOR(7 downto 0);
    
    signal regs_ready: std_logic;
    
    signal fifo1_wr, fifo1_rd, fifo1_full, fifo1_empty, fifo1_prog_full: STD_LOGIC;

    
    signal fifo2_wr, fifo2_rd, fifo2_full, fifo2_empty, fifo2_prog_full: STD_LOGIC;
 
    signal pixel_out: STD_LOGIC_VECTOR(7 downto 0);
    signal pixel_valid: std_logic;
    
    signal in_value: std_logic_vector (71 downto 0);
    
    signal hsync, vsync : std_logic;
    signal grey_data_out : std_logic_vector(7 downto 0);
    --signal s_count : std_logic_vector(9 downto 0) := "0000000000";
    signal c : integer := 0;
    signal c_h : integer := 0;
    --constant d : integer := 100; --number of clock cycles by which input should be delayed.
    --signal data_temp : std_logic := '0';
    type state_type is (idle,delay_c); --defintion of state machine type
    signal next_s : state_type; --declare the state machine signal.
    signal next_s_h : state_type; --declare the state machine signal.
    signal vsync_valid : std_logic := '0';
    signal hsync_valid : std_logic := '0';

    component fifo_line1
       PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        prog_full : OUT STD_LOGIC
      );
    END COMPONENT;
    
    component counter2
        Port ( clk, rst: std_logic;
               enable : in STD_LOGIC;
               finished : out STD_LOGIC);
    end component;
     component counter3
           Port ( clk, rst: std_logic;
                  enable : in STD_LOGIC;
                  finished : out STD_LOGIC);
       end component;
    component sobel_calc
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
   end component;
begin

    rb_data_out <= std_logic_vector(resize(signed(grey_data_out), rb_data_out'length));
    g_data_out <= std_logic_vector(resize(signed(grey_data_out), g_data_out'length));
    rst_n <= not rst;
    rst_delay <= not rst_delay_n;
    ready <=rst_delay_n;
    
    in_value <= reg33 & reg32 & reg31 & reg23 & reg22 &reg21 & reg13 &reg12 &reg11;

fifo1: fifo_line1
    Port Map(clk, rst, reg13, fifo1_wr, fifo1_rd, reg21,
         fifo1_full, fifo1_empty, fifo1_prog_full);
fifo2: fifo_line1
     Port Map(clk, rst, reg23, fifo2_wr, fifo2_rd, reg31,
         fifo2_full, fifo2_empty, fifo2_prog_full);
rst_dalay_cnt: counter3 port map(clk, rst, rst_n, rst_delay_n);
stage1_cnt: counter2 port map(clk, rst_delay, enable, fifo1_wr);
stage2_cnt: counter2 port map(clk, rst_delay, fifo1_prog_full, fifo2_wr);
stage3_cnt: counter2 port map(clk, rst_delay, fifo2_prog_full, regs_ready);

sobel: sobel_calc port map(clk, rst_delay_n, '1', regs_ready, grey_data_out_valid,  in_value, threshold_in, mask1_in, grey_data_out );
    
    shift_data: process (rst, clk)
    begin
        if rst_delay = '1' then
            reg11 <= "00000000";
            reg12 <= "00000000";
            reg13 <= "00000000";
            reg22 <= "00000000";
            reg23 <= "00000000";
            reg32 <= "00000000";
            reg33 <= "00000000";
        else
            
            if rising_edge(clk) and enable = '1' then
                --reg11 <= grey_data_in after 1 ns;
                reg11 <= std_logic_vector(resize(signed(grey_data_in), reg11'length));
                reg12 <= reg11 after 1 ns;
                reg13 <= reg12 after 1 ns;
                
                reg22 <= reg21 after 1 ns;
                reg23 <= reg22 after 1 ns;
                
                reg32 <= reg31 after 1 ns;
                reg33 <= reg32 after 1 ns;
            end if;
        end if;
    end process;
    
    --hsync_out <= hsync;
    --vsync_out <= vsync; 
    process(vsync_in)
            begin
                if(rising_edge(vsync_in)) then
                    vsync_valid <= '1';
                 end if;
    end process;
          
    process(clk)
        begin
            if(rising_edge(Clk)) then
                case next_s is
                    when idle =>
                        if(vsync_valid = '1') then
                            next_s <= delay_c;
                            vsync <= vsync_in; --register the input data.
                            c <= 1;
                            vsync_valid <= '0';
                        end if;
                    when delay_c =>
                        if(c = to_integer(unsigned(delay))) then
                            c <= 1; --reset the count
                            vsync_out <= vsync; --assign the output
                            next_s <= idle; --go back to idle state and wait for another valid data.
                        else
                            c <= c + 1;
                        end if;
                    when others =>
                        NULL;
                end case;
            end if;
        end process;
        
            process(hsync_in)
                    begin
                        if(rising_edge(hsync_in)) then
                            hsync_valid <= '1';
                         end if;
            end process;
                  
            process(clk)
                begin
                    if(rising_edge(Clk)) then
                        case next_s_h is
                            when idle =>
                                if(hsync_valid = '1') then
                                    next_s_h <= delay_c;
                                    hsync <= hsync_in; --register the input data.
                                    c_h <= 1;
                                    hsync_valid <= '0';
                                end if;
                            when delay_c =>
                                if(c_h = to_integer(unsigned(delay))) then
                                    c_h <= 1; --reset the count
                                    hsync_out <= hsync; --assign the output
                                    next_s_h <= idle; --go back to idle state and wait for another valid data.
                                else
                                    c_h <= c_h + 1;
                                end if;
                            when others =>
                                NULL;
                        end case;
                    end if;
                end process;
    
    fifo1_rd <= fifo1_prog_full;
    fifo2_rd <= fifo2_prog_full;
    
end Behavioral;
