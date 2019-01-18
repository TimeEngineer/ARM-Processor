library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IU is port (
  rst : in std_logic;
  clk : in std_logic;
  Offset : in std_logic_vector (23 downto 0);
  nPCsel : in std_logic;
  Instruction : out std_logic_vector (31 downto 0));
end entity IU;

architecture behav of IU is
  
  signal ExtOut : std_logic_vector (31 downto 0);
  signal PCout : std_logic_vector (31 downto 0);
  signal MuxOut : std_logic_vector (31 downto 0);
  signal sig0 : signed (31 downto 0) := (others => '0');
  signal sig1 : signed (31 downto 0) := (others => '0');
  signal one : signed (31 downto 0) := X"00000001";
  
component InstrMem port(
  rst : in std_logic;
  clk : in std_logic;
	input : in std_logic_vector (31 downto 0);
	Instruction : out std_logic_vector (31 downto 0));
end component;

component EXT generic(N : integer := 8); port(
  E : in std_logic_vector (N-1 downto 0);
	S : out std_logic_vector (31 downto 0));
end component;

component MUX generic (N : integer := 32); port(
  A : in std_logic_vector (N-1 downto 0);
  B : in std_logic_vector (N-1 downto 0);
  COM : in std_logic;
  S : out std_logic_vector (N-1 downto 0));
end component;

component PC port(
  clk : in std_logic;
  rst : in std_logic;
  input : in std_logic_vector (31 downto 0);
  output : out std_logic_vector (31 downto 0));
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