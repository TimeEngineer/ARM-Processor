library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REG_tb is
end entity;

architecture bench of REG_tb is
	signal rst_tb	: std_logic := '0';
	signal clk_tb 	: std_logic := '0';
	signal W_tb 	: std_logic_vector (31 downto 0) := X"00000000";	-- Bus write
	signal RA_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address A
	signal RB_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address B
	signal RW_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address write
	signal WE_tb 	: std_logic := '0'; 					-- Write enable
	signal A_tb 	: std_logic_vector (31 downto 0); 			-- Bus A
	signal B_tb 	: std_logic_vector (31 downto 0); 			-- Bus B
	signal Done 	: boolean := False;

begin
UUT1 : entity work.reg(behav) port map(
	rst => rst_tb,
	clk => clk_tb,
	W => W_tb,
	RA => RA_tb,
	RB => RB_tb,
	RW => RW_tb,
	WE => WE_tb,
	A => A_tb,
	B => B_tb);
	
-- Generate a clock
clk_tb <= '0' when Done else not clk_tb after 20 ns;
STIMULUS: process
begin
	wait for 1 us;
	rst_tb <= '1';
	wait for 1 us;
	rst_tb <= '0';
	wait for 1 us;

	W_tb <= X"00000001";
	RW_tb <= X"0";
	WE_tb <= '1';
	wait for 1 us;
	WE_tb <= '0';
	wait for 1 us;
	W_tb <= X"00000005";
	RW_tb <= X"1";
	WE_tb <= '1';
	wait for 1 us;
	WE_tb <= '0';
	wait for 1 us;
	RA_tb <= X"0";
	RB_tb <= X"1";
	wait for 1 us;
	RA_tb <= X"1";
	RB_tb <= X"0";
	wait for 1 us;
	
	W_tb <= X"00000055";
	RW_tb <= X"5";
	WE_tb <= '1';
	wait for 1 us;
	WE_tb <= '0';
	wait for 1 us;
	RA_tb <= X"5";
	RB_tb <= X"5";
	wait for 1 us;
	RA_tb <= X"0";
	RB_tb <= X"1";
	wait for 1 us;
	W_tb <= X"00000011";
	RW_tb <= X"0";
	WE_tb <= '1';
	wait for 1 us;
	WE_tb <= '0';
	wait for 1 us;
	
	Done <= True;
  report "Test done" severity note;
  wait;
end process STIMULUS;
end bench;