library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Memoire de donnees
entity DataMem is port (
	clk : in std_logic;
	DataIn : in std_logic_vector (31 downto 0);
	Addr : in std_logic_vector (5 downto 0);
	WE : in std_logic;
	DataOut : out std_logic_vector (31 downto 0));
end entity;

architecture behav of DataMem is

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
process(clk, DataIn, Addr, We) begin
	
	if rising_edge(clk) and WE = '1' then
		tab_mem(to_integer(unsigned(Addr))) <= DataIn;
	end if;

end process;

DataOut <= tab_mem(to_integer(unsigned(Addr)));

end behav;
