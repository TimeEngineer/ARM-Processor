library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Multiplexeur
entity MUX is generic (N : integer := 32); port (
	A : in std_logic_vector (N-1 downto 0);
	B : in std_logic_vector (N-1 downto 0);
	COM : in std_logic;
	S : out std_logic_vector (N-1 downto 0));
end entity;


architecture behav of MUX is
begin  
process(A, B, COM) begin

	case COM is
		when '0' => S <= A;
		when others => S <= B;
	end case;

end process;
end behav;
