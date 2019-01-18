library ieee;
use ieee.std_logic_1164.all;

-- Registre d'etat du Processeur
entity PSR is port (
	dataIn		: in std_logic_vector (31 downto 0);		-- 32 bits input
	rst			: in std_logic;								-- Reset
	clk			: in std_logic;								-- Clock
	WE			: in std_logic;								-- Write Enable
	dataOut		: out std_logic_vector (31 downto 0));		-- 32 bits output
end entity;

architecture behav of PSR is

	signal reg	: std_logic_vector (31 downto 0) := (others => '0');

begin
process(rst, clk, dataIn, WE) begin

	if rst = '1' then
		reg <= (others => '0');
	end if;
	if rising_edge(clk) and WE = '1' then
		reg <= dataIn;
	end if;
	
end process;
dataOut <= reg;
end behav;
