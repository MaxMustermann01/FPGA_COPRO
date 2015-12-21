----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2015 11:23:40 AM
-- Design Name: 
-- Module Name: w_sum_user_logic - Behavioral
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

entity w_sum_user_logic is
	generic (

    -- Width of S_AXI data bus
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
           
end w_sum_user_logic;

architecture Behavioral of w_sum_user_logic is

component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    rsta : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END component blk_mem_gen_0;
component c_counter_binary_0 IS
      PORT (
        CLK : IN STD_LOGIC;
        CE : IN STD_LOGIC;
        SCLR : IN STD_LOGIC;
        THRESH0 : OUT STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
      );
    END component c_counter_binary_0;

component c_counter_binary_2c_1 IS
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
    end component c_counter_binary_2c_1;
component c_counter_binary_1 IS
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
    end component c_counter_binary_1;

component c_counter_binary_2 IS
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
    end component c_counter_binary_2;

component c_counter_binary_3 IS
  PORT (
    CLK : IN STD_LOGIC;
    CE : IN STD_LOGIC;
    SCLR : IN STD_LOGIC;
    THRESH0 : OUT STD_LOGIC;
    Q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
  );
    end component c_counter_binary_3;

component floating_point_mul_0 IS
  PORT (
    aclk : IN STD_LOGIC;
     aresetn : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END component floating_point_mul_0;

component floating_point_add_0 IS
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_operation_tvalid : IN STD_LOGIC;
    s_axis_operation_tready : OUT STD_LOGIC;
    s_axis_operation_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END component floating_point_add_0;

    signal clk: std_logic;
    signal res_fpus: std_logic;
    
    --brams
    signal ena_blk1, ena_blk2: std_logic;
    signal wea_blk1, wea_blk2: std_logic_vector (0 downto 0);
    signal addra_blk: STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal dina_blk1, dina_blk2: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal douta_blk1, douta_blk2: STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    --cnt1
    signal cnt1_ce, cnt1_sclr, cnt1_thresh0: std_logic;
    --cnt2
    signal cnt2_ce, cnt2_sclr, cnt2_thresh0: std_logic;
    signal cnt2_q: std_logic_vector (1 downto 0);
    --cnt3
    signal cnt3_ce, cnt3_sclr, cnt3_thresh0: std_logic;
    signal cnt3_q: std_logic_vector (2 downto 0);
    --cnt4
    signal cnt4_ce, cnt4_sclr, cnt4_thresh0: std_logic;
    signal cnt4_q: std_logic_vector (2 downto 0);
    --cnt5
    signal cnt5_ce, cnt5_sclr, cnt5_thresh0: std_logic;
    signal cnt5_q: std_logic_vector (4 downto 0);
    
    --mul/add
    signal aresetn, mullOrReg: std_logic;
    signal mul_value_a, mul_value_b: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal dout_mul, add_value_a, add_value_b: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal mul_valid_a, mul_valid_b, mul_valid_result: std_logic;
    signal mul_ready_a, mul_ready_b: std_logic;
    signal add_valid_a, add_valid_b, add_valid_result: std_logic;
    signal add_ready_a, add_ready_b: std_logic;
    signal add_c, add_c_sample: std_logic;
    
    --result of add
    signal c: STD_LOGIC_VECTOR(31 DOWNTO 0);
    --register for final sum
    signal c_temp_valid: std_logic;
    
    --fsm
    type fsmStates is (Reset, Start, Run, PostRun, Finished);
    signal curState, nextState: fsmStates := Reset;
        
    
    --control from registes
    signal ctrlReg: std_logic_vector (1 downto 0);
    signal ready: std_logic;
    signal reg2State: std_logic_vector (3 downto 0);
    --contants
    constant ctrlSeqStart: std_logic_vector (1 downto 0) := std_logic_vector(to_unsigned(1,2));
    constant ctrlSeqReset: std_logic_vector (1 downto 0) := std_logic_vector(to_unsigned(2,2));
    
    constant ctrlSeqReady: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(1,4));
    constant ctrlSeqRunning: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(2,4));
    constant ctrlSeqFinished: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(3,4));
    constant ctrlSeqRunningStateStart: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(4,4));
    constant ctrlSeqRunningStateStartCnt2Thresh: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(5,4));
    constant ctrlSeqRunningStateSWRun: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(6,4));
    constant ctrlSeqRunningStateRun: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(7,4));
    constant ctrlSeqRunningStateRunCnt1Thresu: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(8,4));
    constant ctrlSeqRunningStateRunSwPostRun: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(8,4));
    constant ctrlSeqRunningStatePostRun: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(10,4));
    constant ctrlSeqRunningStatePostRunCnt5Thresh: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(11,4));
    constant ctrlSeqRunningStatePostRunSwFinished: std_logic_vector (3 downto 0) := std_logic_vector(to_unsigned(12,4));


begin
blk1: blk_mem_gen_0
    port map (clka  => S_AXI_ACLK,
        rsta =>aresetn,
        ena =>ena_blk1,
        wea =>wea_blk1,
        addra => addra_blk,
        dina =>dina_blk1,
        douta=>douta_blk1,
        clkb  => bram1_clkb,
        rstb => bram1_rstb,
        enb =>bram1_enb,
        web =>bram1_web(0 downto 0),
        addrb => bram1_addrb(11 downto 2),
        dinb =>bram1_dinb,
        doutb=>bram1_doutb);
blk2: blk_mem_gen_0
     port map (clka  => S_AXI_ACLK,
        rsta =>aresetn,
       ena =>ena_blk2,
       wea =>wea_blk2,
       addra =>addra_blk,
       dina =>dina_blk2,
       douta=>douta_blk2,
       clkb  => bram2_clkb,
       rstb => bram2_rstb,
       enb =>bram2_enb,
       web =>bram2_web(0 downto 0),
       addrb => bram2_addrb(11 downto 2),
       dinb =>bram2_dinb,
       doutb=>bram2_doutb);
-- cnt to 1024
cnt1: c_counter_binary_0
    port map(
    CLK => S_AXI_ACLK,
    CE => cnt1_ce,
    SCLR => cnt1_sclr,
    THRESH0 => cnt1_thresh0,
    Q => addra_blk
    );
--cnt to 2
cnt2: c_counter_binary_2c_1    
    port map(
    CLK => S_AXI_ACLK,
    CE => cnt2_ce,
    SCLR => cnt2_sclr,
    THRESH0 => cnt2_thresh0,
    Q => cnt2_q
    );
--count to 4
cnt3:    c_counter_binary_1
port map(
    CLK => S_AXI_ACLK,
    CE => cnt3_ce,
    SCLR => cnt3_sclr,
    THRESH0 => cnt3_thresh0,
    Q => cnt3_q
    );
--count to 6
    cnt4:    c_counter_binary_2
    port map(
        CLK => S_AXI_ACLK,
        CE => cnt4_ce,
        SCLR => cnt4_sclr,
        THRESH0 => cnt4_thresh0,
        Q => cnt4_q
        );
--count to 22
cnt5:    c_counter_binary_3
port map(
    CLK => S_AXI_ACLK,
    CE => cnt5_ce,
    SCLR => cnt5_sclr,
    THRESH0 => cnt5_thresh0,
    Q => cnt5_q
    );
mul1: floating_point_mul_0
    port map(
        aclk => S_AXI_ACLK,--: IN STD_LOGIC;
        aresetn => S_AXI_ARESETN,
        s_axis_a_tvalid => mul_valid_a,--: IN STD_LOGIC;
        s_axis_a_tready => mul_ready_a, --: OUT STD_LOGIC;
        s_axis_a_tdata => douta_blk1,--: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axis_b_tvalid => mul_valid_b, --: IN STD_LOGIC;
        s_axis_b_tready => mul_ready_b, --: OUT STD_LOGIC;
        s_axis_b_tdata => douta_blk2, --: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_result_tvalid => mul_valid_result,--: OUT STD_LOGIC;
        m_axis_result_tdata => dout_mul--: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

add1: floating_point_add_0
    port map (
        aclk => S_AXI_ACLK,--: IN STD_LOGIC;
        aresetn => S_AXI_ARESETN,
        s_axis_a_tvalid => add_valid_a,--: IN STD_LOGIC;
        s_axis_a_tready => add_ready_a,--: OUT STD_LOGIC;
        s_axis_a_tdata => add_value_a,--: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axis_b_tvalid => add_valid_b, --: IN STD_LOGIC;
        s_axis_b_tready => add_ready_b, --: OUT STD_LOGIC;
        s_axis_b_tdata => add_value_b,--: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axis_operation_tvalid => '1', --: IN STD_LOGIC;
        s_axis_operation_tready => open, --: OUT STD_LOGIC;
        s_axis_operation_tdata => (others => '0'), --: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axis_result_tvalid => add_valid_result,--: OUT STD_LOGIC;
        m_axis_result_tdata => c--: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

--extract ctrlReg from register
ctrlReg(1 downto 0) <= reg_0(1 downto 0);


--build reset for fpus
aresetn <= not S_AXI_ARESETN after 1 ns;
--mul_value_a <= douta_blk1 when (aresetn = '1') else (others => '0');
--mul_value_b <= douta_blk2 when (aresetn = '1') else (others => '0');

add_value_a <= (others => '0') when (res_fpus = '1') else c;
--Mux for adder input port a
--add_c_sample for final sum
add_c_sample <= add_valid_result; 
add_valid_a <= '1' when (res_fpus = '1') else
                add_c when (mullOrReg = '1') else add_c_sample;

--Mux for adder input port b
--c_temp_valid for final sum
c_temp_valid <= (not add_ready_a) and add_valid_result; 
add_value_b <= (others => '0') when (res_fpus = '1') else
                dout_mul when (mullOrReg = '1') else c;
add_valid_b <= '1' when (res_fpus = '1') else
                mul_valid_result when (mullOrReg = '1') else c_temp_valid;

reg_2 <="00000000000"& res_fpus & cnt1_ce &cnt2_ce &cnt3_ce &cnt4_ce &cnt5_ce & cnt1_thresh0 & cnt2_thresh0 & cnt3_thresh0 & cnt4_thresh0 & cnt5_thresh0 & mul_valid_a & mul_valid_b & mul_valid_result & add_valid_a & add_valid_b & add_valid_result & reg2State;

cp: process (ctrlReg, curState, add_valid_result, cnt1_thresh0, cnt2_thresh0, cnt3_thresh0, cnt4_thresh0, mul_valid_result, cnt5_thresh0)
   -- variable x,y,length: float32;
begin
    nextState <= curState after 1 ns;
    
    case curState is
        when Reset =>
            --reset all signals for start
            cnt1_ce <= '0'after 1 ns;
            cnt1_sclr <= '0'after 1 ns;
            cnt2_ce <= '0'after 1 ns;
            cnt2_sclr <= '0'after 1 ns;
            cnt3_ce <= '0'after 1 ns;
            cnt3_sclr <= '0'after 1 ns;
            cnt4_ce <= '0'after 1 ns;
            cnt4_sclr <= '0'after 1 ns;            
            cnt5_ce <= '0'after 1 ns;
            cnt5_sclr <= '0'after 1 ns;
            ena_blk1 <= '1'after 1 ns;
            wea_blk1 <= "0"after 1 ns;
            dina_blk1 <= (others => '0')after 1 ns;
            ena_blk2 <= '1'after 1 ns;
            wea_blk2 <= "0"after 1 ns;
            dina_blk2 <= (others => '0')after 1 ns; 
            mul_valid_a <= '0'after 1 ns;
            mul_valid_b <= '0'after 1 ns;
            add_c <= '0'after 1 ns;
            mullOrReg <= '1'after 1 ns;
            reg2State <= ctrlSeqReady after 1 ns;
            reg_3 <= (others => '0') after 1 ns;
            res_fpus <= '0'after 1 ns;

            --when start sequence switch state
            if ctrlReg = ctrlSeqStart then
                res_fpus <= '0'after 1 ns;
                reg2State <= ctrlSeqRunning after 1 ns;
                cnt2_ce <= '1'after 1 ns;
                cnt1_ce <= '1'after 1 ns;
                nextState <= Start after 1 ns;
            end if;
        when Start =>
            reg2State <= ctrlSeqRunningStateStart after 1 ns;
            --bridging the bram latency 
            if cnt2_thresh0 = '1' then
                mul_valid_a <= '1'after 1 ns;
                mul_valid_b <= '1'after 1 ns;
                add_c <= '1'after 1 ns;
                cnt2_ce <= '0'after 1 ns;
                cnt2_sclr <= '1'after 1 ns;
                reg2State <= ctrlSeqRunningStateStartCnt2Thresh after 1 ns;
            end if;
            -- switch to run mode when first valid sum 
            if add_valid_result = '1' then
                --reg2State <= ctrlSeqRunningStateSWRunafter 1 ns;
                nextState <= Run after 1 ns;
            end if;
        when Run =>
            --start new counter when adress 1023 reached
            reg2State <= ctrlSeqRunningStateRun after 1 ns;
            if cnt1_thresh0 = '1' then      
                cnt3_ce <= '1'after 1 ns;
                reg2State <= ctrlSeqRunningStateRunCnt1Thresu after 1 ns;
            end if;
            --wait for the bram latency
             if cnt3_thresh0 = '1' then 
               --disable the adress counter
               cnt1_ce <= '0'after 1 ns;
               --diable valid signal for mul
               mul_valid_a <= '0'after 1 ns;
               mul_valid_b <= '0'after 1 ns;
               --disable cnt3 and reset
               cnt3_ce <= '0'after 1 ns;
               cnt3_sclr <= '1'after 1 ns;
               --switch in postrun state
               nextState <= PostRun after 1 ns;
               reg2State <= ctrlSeqRunningStateRunSwPostRun after 1 ns;
            end if;
        when PostRun =>
            reg2State <= ctrlSeqRunningStatePostRun after 1 ns;
            --when mul is done do the final sum
            if mul_valid_result = '0'  then
                --mullOr Reg switch the adder input-mux to c and the valid contol values 
                mullOrReg <= '0'after 1 ns;
                --start cnt5, 22 cycles to add all 6 values together
                cnt5_ce <= '1'after 1 ns;
            end if;
            --when cnt5 finished reset adder fpu
            if cnt5_thresh0 = '1' then
                res_fpus <= '1'after 1 ns;
                reg_3 <= c after 1 ns;
                cnt4_ce <= '1'after 1 ns;
                cnt5_ce <= '0'after 1 ns;
                cnt5_sclr <= '1'after 1 ns;
                 reg2State <= ctrlSeqRunningStatePostRunCnt5Thresh after 1 ns;
            end if;
            --when cnt4 finished switch state
            if cnt4_thresh0 = '1' then
                cnt4_ce <= '0'after 1 ns;
                cnt4_sclr <= '1'after 1 ns;
                nextState <= Finished after 1 ns;
                reg2State <= ctrlSeqRunningStatePostRunSwFinished after 1 ns;
            end if;
        when Finished =>
                add_c <= '0'after 1 ns;
                reg2State <= ctrlSeqFinished after 1 ns;
                --reg_3 <= c after 1 ns;
                cnt1_ce <= '0'after 1 ns;
                cnt1_sclr <= '1'after 1 ns;
                if ctrlReg = ctrlSeqReset then
                nextState <= Reset after 1 ns;
            end if;
        when others =>
            assert true report "FSM has encountered an invalid state" severity failure;
            nextState <= Reset after 1 ns;
            
    end case;
end process;

sp: process
begin
    wait until rising_edge(S_AXI_ACLK);
    if S_AXI_ARESETN = '0' then
        curState <= Reset;
    else
        curState <= nextState;
    end if;
end process;

end Behavioral;
