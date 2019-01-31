library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Memoire de donnees
entity DataMem is port (
	clk		: in std_logic;							-- Clock
	DataIn	: in std_logic_vector (31 downto 0);	-- 32 bits input
	Addr	: in std_logic_vector (5 downto 0);		-- 6 bits address
	WE		: in std_logic;							-- Write enable
	DataOut	: out std_logic_vector (31 downto 0));	-- 32 bits output
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
		result (32):=x"00000001"; -- 0x20
		result (33):=x"00000002";
		result (34):=x"00000003";
		result (35):=x"00000004";
		result (36):=x"00000005";
		result (37):=x"00000006";
		result (38):=x"00000007";
		result (39):=x"00000008";
		result (40):=x"00000009";
		result (41):=x"0000000A";
		result (42):=x"0000000B"; -- 0x2A
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
