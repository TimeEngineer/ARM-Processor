library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Extension de signe
entity EXT is generic (N : integer := 8); port (
	E	: in std_logic_vector (N-1 downto 0);		-- N bits input
	S	: out std_logic_vector (31 downto 0));		-- 32 bits output
end entity;

architecture behav of EXT is
begin
process(E) begin

	S(N-2 downto 0) <= E(N-2 downto 0);
	S(31 downto N-1) <= (others => E(N-1));

end process;
end behav;
