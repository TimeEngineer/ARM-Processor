library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Processeur MIPS
entity Main is port (
	rst 					: in std_logic;
	clk 					: in std_logic);
end entity Main;

architecture behav of Main is
	signal Offset_sig		: std_logic_vector (23 downto 0);
	signal nPCsel_sig		: std_logic;
	signal instruction_sig	: std_logic_vector (31 downto 0);
	signal Imm_sig			: std_logic_vector (7 downto 0);
	signal Rn_sig			: std_logic_vector (3 downto 0);
	signal Rm_sig			: std_logic_vector (3 downto 0);
	signal Rd_sig			: std_logic_vector (3 downto 0);
	signal RegSel_sig		: std_logic;
	signal Rb_sig			: std_logic_vector (3 downto 0);
	signal RegWr_sig		: std_logic;
	signal WrSrc_sig		: std_logic;
	signal MemWr_sig		: std_logic;
	signal ALUSrc_sig		: std_logic;
	signal ALUCtr_sig		: std_logic_vector (1 downto 0);
	signal flag				: std_logic_vector (31 downto 0);
	signal buf0				: std_logic;
	signal buf1				: std_logic;
	signal buf2				: std_logic;
  
component IU port(
	rst 					: in std_logic;
	clk 					: in std_logic;
	Offset 					: in std_logic_vector (23 downto 0);
	nPCsel 					: in std_logic;
	Instruction 			: out std_logic_vector (31 downto 0));
end component;

component ATU port(
	rst 					: in std_logic;
	clk						: in std_logic;
	RA 						: in std_logic_vector (3 downto 0);			-- Bus address A
	RB						: in std_logic_vector (3 downto 0);			-- Bus address B
	RW 						: in std_logic_vector (3 downto 0);			-- Bus address write
	WE 						: in std_logic;								-- Write enable
	OP 						: in std_logic_vector (1 downto 0);
	Imm						: in std_logic_vector (7 downto 0);
	WrEn 					: in std_logic;
	COM0 					: in std_logic;
	COM1 					: in std_logic;
	N						: out std_logic;
	Z 						: out std_logic;
	C 						: out std_logic;
	V 						: out std_logic);
end component;

component CU port(
	rst 					: in std_logic;
	clk 					: in std_logic;
	dataIn 					: in std_logic_vector (31 downto 0);
	instruction 			: in std_logic_vector (31 downto 0);
	nPCSel 					: out std_logic;
	RegWr 					: out std_logic;
	ALUSrc 					: out std_logic;
	ALUCtr 					: out std_logic_vector (1 downto 0);
	MemWr 					: out std_logic;
	WrSrc 					: out std_logic;
	RegSel 					: out std_logic;
	Rn 						: out std_logic_vector (3 downto 0);
	Rd 						: out std_logic_vector (3 downto 0);
	Rm 						: out std_logic_vector (3 downto 0);
	Imm 					: out std_logic_vector (7 downto 0);
	Offset 					: out std_logic_vector (23 downto 0));
end component;

component MUX generic (N : integer := 4); port(
	A : in std_logic_vector (N-1 downto 0);
	B : in std_logic_vector (N-1 downto 0);
	COM : in std_logic;
	S : out std_logic_vector (N-1 downto 0));
end component;

begin
C0 : IU port map(
	rst => rst,
	clk => clk,
	Offset => Offset_sig,
	nPCsel => nPCsel_sig,
	Instruction => instruction_sig);
C1 : ATU port map(
	rst => rst,
	clk => clk,
	RA => Rn_sig,
	RB => Rb_sig,
	RW => Rd_sig,
	WE => RegWr_sig,
	OP => ALUCtr_sig,
	Imm => Imm_sig,
	WrEn => MemWr_sig,
	COM0 => ALUSrc_sig,
	COM1 => WrSrc_sig,
	N => flag(0),
	Z => buf0,
	C => buf1,
	V => buf2);
C2 : CU port map(
	rst => rst,
	clk => clk,
	dataIn => flag,
	instruction => instruction_sig,
	nPCSel => nPCsel_sig,
	RegWr => RegWr_sig,
	ALUSrc => ALUSrc_sig,
	ALUCtr => ALUCtr_sig,
	MemWr => MemWr_sig,
	WrSrc => WrSrc_sig,
	RegSel => RegSel_sig,
	Rn => Rn_sig,
	Rd => Rd_sig,
	Rm => Rm_sig,
	Imm => Imm_sig,
	Offset => Offset_sig);
C3 : MUX generic map(4) port map(
	A => Rm_sig,
	B => Rd_sig,
	COM => RegSel_sig,
	S => Rb_sig);
end behav;