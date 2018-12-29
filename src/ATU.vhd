library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Assemblage Unite de Traitement
entity ATU is port (
	rst : in std_logic;
	clk	: in std_logic;
	RA : in std_logic_vector (3 downto 0);			-- Bus address A
	RB	: in std_logic_vector (3 downto 0);			-- Bus address B
	RW : in std_logic_vector (3 downto 0);			-- Bus address write
	WE : in std_logic;								-- Write enable
	OP : in std_logic_vector (1 downto 0);
	Imm : in std_logic_vector (7 downto 0);
	WrEn : in std_logic;
	COM0 : in std_logic;
	COM1 : in std_logic;
	N	: out std_logic;
	Z : out std_logic;
	C : out std_logic;
	V : out std_logic);
end entity ATU;

architecture behav of ATU is

	signal A_sig : std_logic_vector (31 downto 0);
	signal B_sig : std_logic_vector (31 downto 0);
	signal ALUout : std_logic_vector (31 downto 0);
	signal DataOut : std_logic_vector (31 downto 0);
	signal ImmOut : std_logic_vector (31 downto 0);
	signal MuxOut0 : std_logic_vector (31 downto 0);
	signal MuxOut1 : std_logic_vector (31 downto 0);
  
component REG port(
	rst : in std_logic;
	clk : in std_logic;
	W : in std_logic_vector (31 downto 0);			-- Bus write
	RA : in std_logic_vector (3 downto 0);			-- Bus address A
	RB : in std_logic_vector (3 downto 0);			-- Bus address B
	RW : in std_logic_vector (3 downto 0);			-- Bus address write
	WE : in std_logic;								-- Write enable
	A : out std_logic_vector (31 downto 0);			-- Bus A
	B : out std_logic_vector (31 downto 0));		-- Bus B
end component;

component ALU port(
	OP : in std_logic_vector (1 downto 0);			-- Command signal
	A :  in std_logic_vector (31 downto 0);			-- 32 bits input
	B : in std_logic_vector (31 downto 0);			-- 32 bits input
	S : out std_logic_vector (31 downto 0);			-- 32 bits output
	N : out std_logic;								-- Output sign, 1 for strictly negative value, 0 for positive
	Z : out std_logic;								-- 1 if result is zero/null
	C : out std_logic;								-- 1 if there is a carry
	V : out std_logic);
end component;

component MUX generic (N : integer := 32); port(
	A : in std_logic_vector (N-1 downto 0);
	B : in std_logic_vector (N-1 downto 0);
	COM : in std_logic;
	S : out std_logic_vector (N-1 downto 0));
end component;

component EXT generic (N : integer := 8); port(
	E : in std_logic_vector (N-1 downto 0);
	S : out std_logic_vector (31 downto 0));
end component;

component DataMem port(
	clk : in std_logic;
	DataIn : in std_logic_vector (31 downto 0);
	Addr : in std_logic_vector (5 downto 0);
	WE : in std_logic;
	DataOut : out std_logic_vector (31 downto 0));
end component;
  
begin
C0 : REG 	port map(
	rst => rst,
	clk => clk,
	W => MuxOut1,
	RA => RA,
	RB => RB,
	RW => RW,
	WE => WE,
	A => A_sig,
	B => B_sig);
C1 : ALU 	port map(
	OP => OP,
	A => A_sig,
	B => MuxOut0,
	S => ALUout,
	N => N,
	Z => Z,
	C => C,
	V => V);
C2 : MUX generic map(32) port map(
	A => B_sig, 
	B => ImmOut,
	COM => COM0,
	S => MuxOut0);
C3 : MUX generic map(32) port map(
	A => ALUout,
	B => DataOut,
	COM => COM1,
	S => MuxOut1);
C4 : EXT generic map(8) port map(
	E => Imm,
	S => ImmOut);
C5 : DataMem port map(
	clk => clk,
	DataIn => B_sig,
	Addr => ALUout (5 downto 0),
	WE => WrEn,
	DataOut => DataOut);
end behav;
