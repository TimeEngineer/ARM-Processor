library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstrMem is port (
	rst			: in std_logic;							-- Reset
	clk			: in std_logic;							-- Clock
	input		: in std_logic_vector (31 downto 0);	-- 32 bits input
	Instruction	: out std_logic_vector (31 downto 0));	-- 32 bits instruction
end entity;

architecture behav of InstrMem is

	-- Declaration type
	type table is array (63 downto 0) of std_logic_vector (31 downto 0);
	
	-- Function init
	function init_mem return table is variable result : table;
	begin
		for i in 63 downto 0 loop 
			result(i) := (others => '0');
		end loop;
		return result;
	end init_mem;
	
	-- Initialize tab_mem
	signal tab_mem : table := init_mem;

begin
process(clk, input, rst) begin
	if rst = '1' then
		tab_mem <= init_mem;
	elsif rising_edge(clk) then
		Instruction <= tab_mem(to_integer(unsigned(input(5 downto 0))));	
	end if;
	
end process;
end behav;
