library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unite de Traitement
entity TU is port (
	rst				: in std_logic;								-- Reset
	clk				: in std_logic;								-- Clock
	W				: in std_logic_vector (31 downto 0);		-- Bus write
	RA				: in std_logic_vector (3 downto 0);			-- Bus address A
	RB				: in std_logic_vector (3 downto 0);			-- Bus address B
	RW				: in std_logic_vector (3 downto 0);			-- Bus address write
	WE				: in std_logic;								-- Write enable
	OP				: in std_logic_vector (1 downto 0);			-- Command signal
	S				: out std_logic_vector (31 downto 0);		-- 32 bits output
	N				: out std_logic;							-- Output sign, 1 for strictly negative value, 0 for positive 
	Z				: out std_logic;							-- 1 if result is zero/null
	C				: out std_logic;							-- 1 if there is a carry
	V				: out std_logic);							-- 1 if there is an overflow
end entity TU;

architecture behav of TU is

	signal A_sig	: std_logic_vector (31 downto 0);
	signal B_sig	: std_logic_vector (31 downto 0);

component REG port(
	rst				: in std_logic;
	clk				: in std_logic;
	W				: in std_logic_vector (31 downto 0); 		-- Bus write
	RA				: in std_logic_vector (3 downto 0); 		-- Bus address A
	RB				: in std_logic_vector (3 downto 0); 		-- Bus address B
	RW				: in std_logic_vector (3 downto 0); 		-- Bus address write
	WE				: in std_logic;								-- Write enable
	A				: out std_logic_vector (31 downto 0); 		-- Bus A
	B				: out std_logic_vector (31 downto 0)); 		-- Bus B
end component;

component ALU port(
	OP				: in std_logic_vector (1 downto 0);			-- Command signal
	A				:  in std_logic_vector (31 downto 0);		-- 32 bits input
	B				: in std_logic_vector (31 downto 0);		-- 32 bits input
	S				: out std_logic_vector (31 downto 0);		-- 32 bits output
	N				: out std_logic;							-- Output sign, 1 for strictly negative value, 0 for positive
	Z				: out std_logic;							-- 1 if result is zero/null
	C				: out std_logic;							-- 1 if there is a carry
	V				: out std_logic);							-- 1 if there is an overflow
end component;

begin
C0 : REG port map(
	rst => rst,
	clk => clk,
	W => W,
	RA => RA,
	RB => RB,
	RW => RW,
	WE => WE,
	A => A_sig,
	B => B_sig);
C1 : ALU port map(
	OP => OP,
	A => A_sig,
	B => B_sig,
	S => S,
	N => N,
	Z => Z,
	C => C,
	V => V);
end behav;
