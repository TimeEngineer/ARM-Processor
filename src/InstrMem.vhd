library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Memoire d'instruction
entity InstrMem is port (
	rst : in std_logic;
	clk : in std_logic;
	PCin : in std_logic_vector (31 downto 0);
	PCout : out std_logic_vector (31 downto 0);
	Instruction : out std_logic_vector (31 downto 0));
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
	signal PC : std_logic_vector (31 downto 0);

begin
process(clk, PCin, rst) begin
  
	if rst = '1' then
		PC <= (others => '0');  
	end if;
	if rising_edge(clk) then
		PCout <= PC;
		Instruction <= tab_mem(to_integer(unsigned(PC(5 downto 0))));
	end if;
	
end process;

end behav;
