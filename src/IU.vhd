library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IU is port (
	rst				: in std_logic;							-- Reset
	clk				: in std_logic;							-- Clock
	Offset			: in std_logic_vector (23 downto 0);	-- Offset
	nPCsel			: in std_logic;							-- PC select
	instruction		: out std_logic_vector (31 downto 0));	-- 32 bits instruction
end entity IU;

architecture behav of IU is
	
	signal ExtOut	: std_logic_vector (31 downto 0);
	signal PCout	: std_logic_vector (31 downto 0);
	signal MuxOut	: std_logic_vector (31 downto 0);
	signal sig0		: signed (31 downto 0) := (others => '0');
	signal sig1		: signed (31 downto 0) := (others => '0');
	signal one		: signed (31 downto 0) := X"00000001";
	
component InstrMem port(
	rst				: in std_logic;							-- Reset
	clk				: in std_logic;							-- Clock
	input			: in std_logic_vector (31 downto 0);	-- 32 bits input
	Instruction		: out std_logic_vector (31 downto 0));	-- 32 bits instruction
end component;

component EXT generic(N : integer := 8); port(
	E				: in std_logic_vector (N-1 downto 0);	-- N bits input
	S				: out std_logic_vector (31 downto 0));	-- 32 bits output
end component;
	
component MUX generic (N : integer := 32); port(
	A				: in std_logic_vector (N-1 downto 0);	-- N bits input
	B				: in std_logic_vector (N-1 downto 0);	-- N bits input
	COM				: in std_logic;							-- Select control
	S				: out std_logic_vector (N-1 downto 0));	-- N bits output
end component;

component PC port(
	clk				: in std_logic;							-- Clock
	rst				: in std_logic;							-- Reset
	input			: in std_logic_vector (31 downto 0);	-- 32 bits input
	output			: out std_logic_vector (31 downto 0));	-- 32 bits output
end component;
	
begin
C0 : InstrMem 	port map(
	rst => rst,
	clk => clk,
	input => PCout,
	Instruction => Instruction);
C1 : EXT generic map(24)	port map(
	E => Offset,
	S => ExtOut);
C2 : MUX generic map(32) port map(
	A => std_logic_vector(sig0),
	B => std_logic_vector(sig1),
	COM => nPCsel,
	S => MuxOut);
C3 : sig0 <= signed(PCout) + one;
C4 : sig1 <= signed(ExtOut) + sig0;
C5 : PC port map(
	clk => clk,
	rst => rst,
	input => MuxOut,
	output => PCout);
end behav;
