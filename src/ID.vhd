library ieee;
use ieee.std_logic_1164.all;

-- Decodeur d'instructions
entity ID is port (
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
end entity; 

architecture behav of ID is
  
	type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT);
  
	signal instr_courante : enum_instruction;
  
begin
process(instruction) begin
	case instruction(31 downto 0) is
		when "1110001110100000XXXX000XXXXXXXXX" => instr_courante <= MOV;
		when "111000101000XXXXXXXX0000XXXXXXXX" => instr_courante <= ADDi;
		when "111000001000XXXXXXXX00000000XXXX" => instr_courante <= ADDr;
		when "111000110101XXXX00000000XXXXXXXX" => instr_courante <= CMP;
		when "111001100001XXXXXXXXXXXXXXXXXXXX" => instr_courante <= LDR;
		when "111001100000XXXXXXXXXXXXXXXXXXXX" => instr_courante <= STR;
		when "11101010XXXXXXXXXXXXXXXXXXXXXXXX" => instr_courante <= BAL;
		when "10111010XXXXXXXXXXXXXXXXXXXXXXXX" => instr_courante <= BLT;
		when others => instr_courante <= MOV;
		end case;
end process;
  
process(instruction) begin
    
	case instr_courante is
		when MOV =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "01";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);
        
		when ADDi =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);
      
		when ADDr =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Rm <= instruction(3 downto 0);

		when CMP =>
			nPCSel <= '0';
			RegWr <= '0';
			ALUSrc <= '1';
			ALUCtr <= "10";
			PSREn <= '1';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Imm <= instruction(7 downto 0);
      
		when LDR =>
			nPCSel <= '0';
			RegWr <= '1';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '1';
			RegSel <= '0';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);
        
		when STR =>
			nPCSel <= '0';
			RegWr <= '0';
			ALUSrc <= '1';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '1';
			WrSrc <= 'X';
			RegSel <= '1';
			Rn <= instruction(19 downto 16);
			Rd <= instruction(15 downto 12);
			Imm <= instruction(7 downto 0);

		when BAL =>
			nPCSel <= '1';
			RegWr <= '0';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Offset <= instruction(23 downto 0);

		when BLT =>
			nPCSel <= '1';
			RegWr <= '0';
			ALUSrc <= '0';
			ALUCtr <= "00";
			PSREn <= '0';
			MemWr <= '0';
			WrSrc <= '0';
			RegSel <= '0';
			Offset <= instruction(23 downto 0);
	end case;
end process;
end behav;
