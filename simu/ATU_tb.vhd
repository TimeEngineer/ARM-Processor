library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ATU_tb is
end entity;

architecture bench of ATU_tb is

	signal rst_tb:std_logic := '0';
	signal clk_tb: std_logic := '0';
	signal RA_tb: std_logic_vector(3 downto 0) := X"0";
	signal RB_tb: std_logic_vector(3 downto 0) := X"1";
	signal RW_tb: std_logic_vector(3 downto 0) := X"0";
	signal WE_tb: std_logic := '0';
	signal OP_tb: std_logic_vector(1 downto 0) := "00";
	signal Imm_tb: std_logic_vector(7 downto 0) := X"00";
	signal WrEn_tb: std_logic := '0';
	signal COM0_tb: std_logic := '0';
	signal COM1_tb: std_logic := '0';
	signal N_tb: std_logic;
	signal Z_tb: std_logic;
	signal C_tb: std_logic;
	signal V_tb: std_logic;
	signal Done 	: boolean := False;

begin

UUT1: entity work.atu(behav) port map(
	rst => rst_tb,
	clk => clk_tb,
	RA => RA_tb,
	RB => RB_tb,
	RW => RW_tb,
	WE => WE_tb,
	OP => OP_tb,
	Imm => Imm_tb,
	WrEn => WrEn_tb,
	COM0 => COM0_tb,
	COM1 => COM1_tb,
	N => N_tb,
	Z => Z_tb,
	C => C_tb,
	V => V_tb);

-- Generate a clock
clk_tb <= '0' when Done else not clk_tb after 20 ns;

stimulus: process begin

	wait for 1 us;
	rst_tb <= '1';
	wait for 1 us;
	rst_tb <= '0';
	wait for 1 us;

----------- Initialisation du registre 0 à la valeur 1 ----------
	Imm_tb <= X"01";
	COM0_tb <= '1';
	OP_tb <= "01";
	COM1_tb <= '0';
	wait for 100 ns;

	RW_tb <= X"0";
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';

----------- Initialisation du registre 1 à la valeur 3 ----------

	Imm_tb <= X"03";
	wait for 100 ns;

	RW_tb <= X"1";
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';
	Imm_tb <= X"00";

----------- Addition de 2 registres ------------

	RA_tb <= X"0"; RB_tb <= X"1"; OP_tb <= "00"; -- addition de reg(0)=1 et reg(1)=3 => 4
	COM0_tb <= '0'; COM1_tb <= '0';
	wait for 100 ns;

	RW_tb <= X"2";				-- resultat dans reg(2)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';

----------- Addition d'un registre avec une valeur immediate ------------
	
	Imm_tb <= X"01"; RA_tb <= X"2"; OP_tb <= "00"; -- addition de reg(2)=4 et de 1 => 5
	COM0_tb <= '1';
	wait for 100 ns;

	RW_tb <= X"2"; 				-- resultat dans reg(2)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';
	imm_tb <= X"00";

----------- Soustraction de 2 registres ------------

	RA_tb <= X"2"; RB_tb <= X"0"; OP_tb <= "10"; -- soustraction de reg(0)=1 à reg(2)=5 => 4
	COM0_tb <= '0';
	wait for 100 ns;

	RW_tb <= X"2"; 				-- resultat dans reg(2)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';

----------- Soustraction d'une valeur immediate a un registre ------------
	Imm_tb <= X"02"; RA_tb <= X"0";			-- soustraction de 2 a reg(0)=1 => -1
	COM0_tb <= '1';
	wait for 100 ns;

	RW_tb <= X"3"; 				-- resultat dans reg(3)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';
	Imm_tb <= X"00";

----------- Copie de la valeur d'un registre dans un autre registre ------------

	RA_tb <= X"3"; OP_tb <= "11";		-- copie de reg(3)=-1 dans reg(4)
	wait for 100 ns;

	RW_tb <= X"4"; 				-- resultat dans reg(4)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';

----------- Ecriture d'un registre dans un mot de la mémoire ------------

	RA_tb <= X"5"; RB_tb <= X"1"; OP_tb <= "11";	-- ecriture de reg(1)=3 dans dataMem(0)
	wait for 100 ns;

	WrEn_tb <= '1';
	wait for 50 ns;
	WrEn_tb <= '0';

----------- Lecture d'un mot de la memoire dans un registre ------------

	COM1_tb <= '1';				-- lecture du du mot dataMem(0)=3

	RW_tb <= X"3"; 				-- resultat dans reg(3)
	WE_tb <= '1';
	wait for 50 ns;
	WE_tb <= '0';


	end process stimulus;
end bench;