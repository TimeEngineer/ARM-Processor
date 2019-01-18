library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IU_tb is
end entity;

architecture bench of IU_tb is

	signal rst_tb : std_logic := '0';
  	signal clk_tb : std_logic := '0';
  	signal Offset_tb : std_logic_vector (23 downto 0) := X"000000";
  	signal nPCsel_tb : std_logic := '0';
  	signal Instruction_tb : std_logic_vector (31 downto 0);
	signal Done 	: boolean := False;

begin

UUT1: entity work.iu(behav) port map(
	rst => rst_tb,
	clk => clk_tb,
	Offset => Offset_tb,
	nPCsel => nPCsel_tb,
	Instruction => Instruction_tb);

-- Generate a clock
clk_tb <= '0' when Done else not clk_tb after 20 ns;

stimulus: process begin

	wait for 1 us;
	rst_tb <= '1';
	wait for 1 us;
	rst_tb <= '0';
	wait for 1 us;

	nPCsel_tb <= '0';
	wait for 1 us;


	Offset_tb <= X"000004";
	nPCsel_tb <= '1';
	wait for 1 us;

	end process stimulus;
end bench;