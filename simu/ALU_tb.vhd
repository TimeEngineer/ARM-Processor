library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
end entity ALU_tb;

architecture bench of ALU_tb is
  
  signal OP_tb : std_logic_vector (1 downto 0);
  signal A_tb : std_logic_vector (31 downto 0);
  signal B_tb : std_logic_vector (31 downto 0);
  signal S_tb : std_logic_vector (31 downto 0);
  signal N_tb : std_logic;
  
  begin
  
  UUT1 : entity work.alu(behav) port map(
    OP => OP_tb,
    A => A_tb,
    B => B_tb,
    S => S_tb,
    N => N_tb);
       
    
    stimulus : process begin
    
      OP_tb <= "00"; A_tb <= X"00000002"; B_tb <= X"00000001";         -- variable initialization with A greater than B
      wait for 10 ns;
      
      OP_tb <= "01";
      wait for 10 ns;
      
      OP_tb <= "10";
      wait for 10 ns;
      
      OP_tb <= "11";
      wait for 20 ns;
      
      OP_tb <= "10"; A_tb <= X"00000001"; B_tb <= X"00000002";         -- variable initialization with B greater than A
      wait for 10 ns;

    end process stimulus;
    
    
    
  
end bench;