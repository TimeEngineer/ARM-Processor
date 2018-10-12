library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is port(
    OP : in std_logic_vector (1 downto 0);    -- Command signal
    A :  in std_logic_vector (31 downto 0);   -- 32 bits input
    B : in std_logic_vector (31 downto 0);    -- 32 bits input
    S : out std_logic_vector (31 downto 0);   -- 32 bits output
    N : out std_logic;                        -- Output sign, 1 for strictly negative value, 0 for positive
    Z : out std_logic;                        -- 1 if result is zero/null
    C : out std_logic;                        -- 1 if there is a carry
    V : out std_logic);                       -- 
end ALU;

architecture behav of ALU is

  signal S_sig : std_logic_vector (31 downto 0);
  
begin
  
 process (OP, A, B) begin 
  case OP is
    when "00" => S_sig <= std_logic_vector(signed(A)+signed(B));
    when "01" => S_sig <= B;
    when "10" => S_sig <= std_logic_vector(signed(A)-signed(B));
    when others => S_sig <= A;
  end case;
end process;
  S <= S_sig;
  N <= S_sig(31);                             -- bit 31 determines the sign
  
end behav;