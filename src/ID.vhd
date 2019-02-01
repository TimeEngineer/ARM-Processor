library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL; 

-- Decodeur d'instructions
entity ID is port (
	instruction				: in std_logic_vector (31 downto 0);		-- 32 bits instruction
	PSR						: in std_logic_vector (31 downto 0);		-- Load command
	nPCSel					: out std_logic;							-- PC select
	RegWr					: out std_logic;							-- Register write enable
	ALUSrc					: out std_logic;							-- ALU source
	ALUCtr					: out std_logic_vector (1 downto 0);		-- ALU control
	PSREn					: out std_logic;							-- PSR enable
	MemWr					: out std_logic;							-- Memory write enable
	WrSrc					: out std_logic;							-- Write source
	RegSel					: out std_logic;							-- Register select
	Rn						: out std_logic_vector (3 downto 0);		-- Bus address N
	Rd						: out std_logic_vector (3 downto 0);		-- Bus address D
	Rm						: out std_logic_vector (3 downto 0);		-- Bus address M
	Imm						: out std_logic_vector (7 downto 0);		-- Immediate
	Offset					: out std_logic_vector (23 downto 0));		-- Offset
end entity; 

architecture behav of ID is

	type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);

	signal instr_courante 	: enum_instruction;

	signal nPCSel_sig		: std_logic;
	signal RegWr_sig		: std_logic;
	signal ALUSrc_sig		: std_logic;
	signal ALUCtr_sig		: std_logic_vector (1 downto 0);
	signal PSREn_sig		: std_logic;
	signal MemWr_sig		: std_logic;
	signal WrSrc_sig		: std_logic;
	signal RegSel_sig		: std_logic;
	signal Rn_sig			: std_logic_vector (3 downto 0);
	signal Rd_sig			: std_logic_vector (3 downto 0);
	signal Rm_sig			: std_logic_vector (3 downto 0);
	signal Imm_sig			: std_logic_vector (7 downto 0);
	signal Offset_sig		: std_logic_vector (23 downto 0);

begin
process(instruction) begin
	if std_match(instruction, "1110001110100000----000---------") then instr_courante <= MOV;
	elsif std_match(instruction, "111000101000--------0000--------") then instr_courante <= ADDi;
	elsif std_match(instruction, "111000001000--------00000000----") then instr_courante <= ADDr;
	elsif std_match(instruction, "111000110101----00000000--------") then instr_courante <= CMP;
	elsif std_match(instruction, "111001100001--------------------") then instr_courante <= LDR;
	elsif std_match(instruction, "111001100000--------------------") then instr_courante <= STR;
	elsif std_match(instruction, "11101010------------------------") then instr_courante <= BAL;
	elsif std_match(instruction, "10111010------------------------") then instr_courante <= BLT;
	end if;
end process;

process(instruction) begin

	case instr_courante is
		when MOV =>
			nPCSel_sig <= '0';
			RegWr_sig <= '1';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "01";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Rd_sig <= instruction(15 downto 12);
			Imm_sig <= instruction(7 downto 0);

		when ADDi =>
			nPCSel_sig <= '0';
			RegWr_sig <= '1';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Rn_sig <= instruction(19 downto 16);
			Rd_sig <= instruction(15 downto 12);
			Imm_sig <= instruction(7 downto 0);

		when ADDr =>
			nPCSel_sig <= '0';
			RegWr_sig <= '1';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Rn_sig <= instruction(19 downto 16);
			Rd_sig <= instruction(15 downto 12);
			Rm_sig <= instruction(3 downto 0);

		when CMP =>
			nPCSel_sig <= '0';
			RegWr_sig <= '0';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "10";
			PSREn_sig <= '1';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Rn_sig <= instruction(19 downto 16);
			Imm_sig <= instruction(7 downto 0);

		when LDR =>
			nPCSel_sig <= '0';
			RegWr_sig <= '1';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '1';
			RegSel_sig <= '0';
			Rn_sig <= instruction(19 downto 16);
			Rd_sig <= instruction(15 downto 12);
			Imm_sig <= instruction(7 downto 0);

		when STR =>
			nPCSel_sig <= '0';
			RegWr_sig <= '0';
			ALUSrc_sig <= '1';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '1';
			WrSrc_sig <= 'X';
			RegSel_sig <= '1';
			Rn_sig <= instruction(19 downto 16);
			Rd_sig <= instruction(15 downto 12);
			Imm_sig <= instruction(7 downto 0);

		when BAL =>
			nPCSel_sig <= '1';
			RegWr_sig <= '0';
			ALUSrc_sig <= '0';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Offset_sig <= instruction(23 downto 0);

		when BLT =>
			if PSR(0) = '1' then nPCSel_sig <= '1';
			else nPCSel_sig <= '0';
			end if;
			RegWr_sig <= '0';
			ALUSrc_sig <= '0';
			ALUCtr_sig <= "00";
			PSREn_sig <= '0';
			MemWr_sig <= '0';
			WrSrc_sig <= '0';
			RegSel_sig <= '0';
			Offset_sig <= instruction(23 downto 0);
	end case;
end process;
nPCSel <= nPCSel_sig;
RegWr <= RegWr_sig;
ALUSrc <= ALUSrc_sig;
ALUCtr <= ALUCtr_sig;
PSREn <= PSREn_sig;
MemWr <= MemWr_sig;
WrSrc <= WrSrc_sig;
RegSel <= RegSel_sig;
Rn <= Rn_sig;
Rd <= Rd_sig;
Rm <= Rm_sig;
Imm	<= Imm_sig;	
Offset <= Offset_sig;
end behav;
