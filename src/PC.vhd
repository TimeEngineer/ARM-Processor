library ieee;
use ieee.std_logic_1164.all;

entity PC is port (
	clk		: in std_logic;								-- Clock
	rst		: in std_logic;								-- Reset
	input	: in std_logic_vector (31 downto 0);		-- 32 bits input
	output	: out std_logic_vector (31 downto 0));		-- 32 bits output
end entity PC;

architecture behav of PC is

begin
process(clk, input, rst) begin

	if rst = '1' then
		output <= (others => '0');
	elsif rising_edge(clk) then
		output <= input;
	end if;

end process;
end behav;