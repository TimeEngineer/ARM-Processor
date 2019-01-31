library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstrMem is port (
	rst			: in std_logic;							-- Reset
	clk			: in std_logic;							-- Clock
	input		: in std_logic_vector (31 downto 0);	-- 32 bits input
	Instruction	: out std_logic_vector (31 downto 0));	-- 32 bits instruction
end entity;

architecture behav of InstrMem is

	-- Declaration type
	type table is array (63 downto 0) of std_logic_vector (31 downto 0);
	
	-- Function init
	function init_mem return table is variable result : table;
	begin
		for i in 63 downto 0 loop 
			result(i) := (others => '0');
		end loop;
		result (0):=x"E3A01020";-- 0x0 _main -- MOV R1,#0x20 -- R1 = 0x20
		result (1):=x"E3A02000";-- 0x1		 -- MOV R2,#0x00 -- R2 = 0
		result (2):=x"E6110000";-- 0x2 _loop -- LDR R0,0(R1) -- R0 = DATAMEM[R1] 
		result (3):=x"E0822000";-- 0x3		 -- ADD R2,R2,R0 -- R2 = R2 + R0
		result (4):=x"E2811001";-- 0x4		 -- ADD R1,R1,#1 -- R1 = R1 + 1
		result (5):=x"E351002A";-- 0x5		 -- CMP R1,0x2A  -- si R1 >= 0x2A 
		result (6):=x"BAFFFFFB";-- 0x6		 -- BLT loop 	 -- PC = PC + (-5) si N = 1
		result (7):=x"E6012000";-- 0x7		 -- STR R2,0(R1) -- DATAMEM[R1] = R2
		result (8):=x"EAFFFFF7";-- 0x8		 -- BAL main	 -- PC = PC + (-7)
		return result;
	end init_mem;
	
	-- Initialize tab_mem
	signal tab_mem : table := init_mem;

begin
process(clk, input, rst) begin
	if rst = '1' then
		tab_mem <= init_mem;
	elsif rising_edge(clk) then
		Instruction <= tab_mem(to_integer(unsigned(input(5 downto 0))));	
	end if;
	
end process;
end behav;
