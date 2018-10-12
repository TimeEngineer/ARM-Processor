library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXT_tb is
end entity EXT_tb;

architecture bench of EXT_tb is
  
  signal E_tb : std_logic_vector (7 downto 0) := (others => '0');
  signal S_tb : std_logic_vector (31 downto 0);
  
  begin
  
  UUT1 : entity work.ext(behav) generic map (8) port map(
    E => E_tb,
    S => S_tb);
       
    
    stimulus : process begin
    
      E_tb <= X"05";
      wait for 100 ns;
      E_tb <= X"F0";
      wait for 100 ns;
      
    end process stimulus;
end bench;