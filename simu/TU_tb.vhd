library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TU_tb is
end entity;

architecture bench of TU_tb is
	signal rst_tb	: std_logic := '0';
	signal clk_tb 	: std_logic := '0';
	signal W_tb 	: std_logic_vector (31 downto 0) := X"00000000";	-- Bus write
	signal RA_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address A
	signal RB_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address B
	signal RW_tb 	: std_logic_vector (3 downto 0) := X"0"; 		-- Bus address write
	signal WE_tb 	: std_logic := '0'; 					-- Write enable
	signal OP_tb	: std_logic_vector (1 downto 0) := "00";
	signal S_tb	: std_logic_vector (31 downto 0);
	signal N_tb	: std_logic;
	signal Z_tb : std_logic;
	signal C_tb : std_logic;
	signal V_tb : std_logic;
	signal Done 	: boolean := False;

begin
UUT1 : entity work.tu(behav) port map(
	rst => rst_tb,
	clk => clk_tb,
	W => W_tb,
	RA => RA_tb,
	RB => RB_tb,
	RW => RW_tb,
	WE => WE_tb,
	OP => OP_tb,
	S => S_tb,
	N => N_tb,
	Z => Z_tb,
	C => C_tb,
	V => V_tb);
	
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
	RW_tb <= X"1";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000002";
	RW_tb <= X"2";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000003";
	RW_tb <= X"3";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000004";
	RW_tb <= X"3";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000005";
	RW_tb <= X"5";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000006";
	RW_tb <= X"6";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000007";
	RW_tb <= X"7";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000008";
	RW_tb <= X"8";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"00000009";
	RW_tb <= X"9";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000A";
	RW_tb <= X"A";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000B";
	RW_tb <= X"B";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000C";
	RW_tb <= X"C";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000D";
	RW_tb <= X"D";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000E";
	RW_tb <= X"E";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	W_tb <= X"0000000F";
	RW_tb <= X"F";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	RA_tb <= X"F";
	OP_tb <= "01";
	W_tb <= S_tb;
	RW_tb <= X"1";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	RB_tb <= X"1";
	OP_tb <= "00";
	W_tb <= S_tb;
	RW_tb <= X"1";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	RW_tb <= X"2";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	RA_tb <= X"1";
	RB_tb <= X"F";
	OP_tB <= "10";
	W_tb <= S_tb;
	RW_tb <= X"3";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

	RA_tb <= X"7";
	W_tb <= S_tb;
	RW_tb <= X"5";
	WE_tb <= '1';
	wait for 100 ns;
	WE_tb <= '0';
	wait for 100 ns;

  Done <= True;
  report "Test done" severity note;
  wait;
end process STIMULUS;
end bench;
