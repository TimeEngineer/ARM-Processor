library ieee;
use ieee.std_logic_1164.all;

entity Main_tb is
end entity;

architecture bench of Main_tb is

	signal rst_tb: std_logic;
	signal clk_tb: std_logic := '0';
	signal Done 	: boolean := False;


begin

UUT1: entity work.main(behav) port map(
	rst => rst_tb,
	clk => clk_tb);

-- Generate a clock
clk_tb <= '0' when Done else not clk_tb after 20 ns;


stimulus: process begin
	rst_tb <= '0';
	wait for 20 ns;
	rst_tb <= '1';
	wait for 20 ns;
	rst_tb <= '0';
	wait for 1 us;

end process stimulus;


end bench;
