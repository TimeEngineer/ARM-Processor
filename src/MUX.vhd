library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX is generic (N : integer := 32); port (
  
  A : in std_logic_vector (N-1 downto 0);
  B : in std_logic_vector (N-1 downto 0);
  COM : in std_logic;
  S : out std_logic_vector (N-1 downto 0));
  
end entity;


architecture behav of MUX is
  
  signal S_sig : std_logic_vector (N-1 downto 0);
  
  begin
    
  process(A, B, COM) begin
    
    case COM is
      
    when '0' => S_sig <= A;
    when others => S_sig <= B;
    end case;
    
    S <= S_sig;
    
  end process;
end behav;