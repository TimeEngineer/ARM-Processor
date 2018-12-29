library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unite de Controle
entity CU is port (
	rst : in std_logic;
	clk : in std_logic;
	dataIn : in std_logic_vector (31 downto 0);
	instruction : in std_logic_vector (31 downto 0);
	nPCSel : out std_logic;
	RegWr : out std_logic;
	ALUSrc : out std_logic;
	ALUCtr : out std_logic_vector (1 downto 0);
	MemWr : out std_logic;
	WrSrc : out std_logic;
	RegSel : out std_logic;
	Rn : out std_logic_vector (3 downto 0);
	Rd : out std_logic_vector (3 downto 0);
	Rm : out std_logic_vector (3 downto 0);
	Imm : out std_logic_vector (7 downto 0);
	Offset : out std_logic_vector (23 downto 0));
end entity;

architecture behav of CU is
	signal reg : std_logic_vector (31 downto 0);
	signal regEn : std_logic;
  
component PSR port(
	dataIn : in std_logic_vector (31 downto 0);
	rst : in std_logic;
	clk : in std_logic;
	WE : in std_logic;
	dataOut : out std_logic_vector (31 downto 0));
end component;

component ID port(
	instruction : in std_logic_vector (31 downto 0);
	PSR : in std_logic_vector (31 downto 0);
	nPCSel : out std_logic;
	RegWr : out std_logic;
	ALUSrc : out std_logic;
	ALUCtr : out std_logic_vector (1 downto 0);
	PSREn : out std_logic;
	MemWr : out std_logic;
	WrSrc : out std_logic;
	RegSel : out std_logic;
	Rn : out std_logic_vector (3 downto 0);
	Rd : out std_logic_vector (3 downto 0);
	Rm : out std_logic_vector (3 downto 0);
	Imm : out std_logic_vector (7 downto 0);
	Offset : out std_logic_vector (23 downto 0));
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
