library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unite de Controle
entity CU is port (
	rst				: in std_logic;								-- Reset
	clk				: in std_logic;								-- Clock
	dataIn			: in std_logic_vector (31 downto 0);		-- 32 bits input
	instruction		: in std_logic_vector (31 downto 0);		-- 32 bots instruction
	nPCSel			: out std_logic;							-- PC Select
	RegWr			: out std_logic;							-- Register write enable
	ALUSrc			: out std_logic;							-- ALU source
	ALUCtr			: out std_logic_vector (1 downto 0);		-- ALU control
	MemWr			: out std_logic;							-- Memory write enable
	WrSrc			: out std_logic;							-- Write source
	RegSel			: out std_logic;							-- Register select
	Rn				: out std_logic_vector (3 downto 0);		-- Bus address N
	Rd				: out std_logic_vector (3 downto 0);		-- Bus address D
	Rm				: out std_logic_vector (3 downto 0);		-- Bus address M
	Imm				: out std_logic_vector (7 downto 0);		-- Immediate
	Offset			: out std_logic_vector (23 downto 0));		-- Offset
end entity;

architecture behav of CU is
	signal reg		: std_logic_vector (31 downto 0);
	signal regEn	: std_logic;

component PSR port(
	dataIn			: in std_logic_vector (31 downto 0);		-- 32 bits input
	rst				: in std_logic;								-- Reset
	clk				: in std_logic;								-- Clock
	WE				: in std_logic;								-- Write enable
	dataOut			: out std_logic_vector (31 downto 0));		-- 32 bits output
end component;

component ID port(
	instruction		: in std_logic_vector (31 downto 0);		-- 32 bits instruction
	PSR				: in std_logic_vector (31 downto 0);		-- Load command
	nPCSel			: out std_logic;							-- PC select
	RegWr			: out std_logic;							-- Register write enable
	ALUSrc			: out std_logic;							-- ALU source
	ALUCtr			: out std_logic_vector (1 downto 0);		-- ALU control
	PSREn			: out std_logic;							-- PSR enable
	MemWr			: out std_logic;							-- Memory write enable
	WrSrc			: out std_logic;							-- Write source
	RegSel			: out std_logic;							-- Register select
	Rn				: out std_logic_vector (3 downto 0);		-- Bus address N
	Rd				: out std_logic_vector (3 downto 0);		-- Bus address D
	Rm				: out std_logic_vector (3 downto 0);		-- Bus address M
	Imm				: out std_logic_vector (7 downto 0);		-- Immediate
	Offset			: out std_logic_vector (23 downto 0));		-- Offset
end component;

begin
C0 : PSR port map(
	dataIn => dataIn,
	rst => rst,
	clk => clk,
	WE => regEn,
	dataOut => reg);
C1 : ID port map(
	instruction => instruction,
	PSR => reg,
	nPCSel => nPCSel,
	RegWr => RegWr,
	ALUSrc => ALUSrc,
	ALUCtr => ALUCtr,
	PSREn => regEn,
	MemWr => MemWr,
	WrSrc => WrSrc,
	RegSel => RegSel,
	Rn => Rn,
	Rd => Rd,
	Rm => Rm,
	Imm => Imm,
	Offset => Offset);
end behav;
