
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXT is generic (N : integer := 32); port (
	E : in std_logic_vector (N-1 downto 0);
	S : out std_logic_vector (31 downto 0));
end entity;

architecture behav of EXT is
	signal S_sig : std_logic_vector (31 downto 0);
begin
process(E) begin
	S_sig(N-2 downto 0) <= E(N-2 downto 0);
	S_sig(31) <= E(N-1);
end process;
S <= S_sig;
end behav;