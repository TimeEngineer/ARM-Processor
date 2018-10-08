library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REG is port (
	rst : in std_logic;
	clk : in std_logic;
	W : in std_logic_vector (31 downto 0); 		-- Bus write
	RA : in std_logic_vector (3 downto 0); 		-- Bus address A
	RB : in std_logic_vector (3 downto 0); 		-- Bus address B
	RW : in std_logic_vector (3 downto 0); 		-- Bus address write
	WE : in std_logic; 				-- Write enable
	A : out std_logic_vector (31 downto 0); 	-- Bus A
	B : out std_logic_vector (31 downto 0)); 	-- Bus B
end entity;

architecture behav of REG is

	-- Declaration type
	type table is array (15 downto 0) of std_logic_vector (31 downto 0);
	
	-- Function init
	function init_reg return table is variable result : table;
	begin
		for i in 15 downto 0 loop
			result(i) := (others => '0');
		end loop;
		return result;
	end init_reg;
	
	-- Initialize tab_reg
	signal tab_reg : table := init_reg;

begin
process(clk, W, RW, WE) begin
	
	if rst = '1' then
		tab_reg <= init_reg;
	end if;
	if rising_edge(clk) and WE = '1' then
		tab_reg(to_integer(unsigned(RW))) <= W;
	end if;

end process;

A <= tab_reg(to_integer(unsigned(RA)));
B <= tab_reg(to_integer(unsigned(RB)));

end behav;