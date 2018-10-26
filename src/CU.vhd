library ieee;
use ieee.std_logic_1164.all;

entity CU is port (
  dataIn : in std_logic_vector (31 downto 0);
  rst : in std_logic;
  clk : in std_logic;
  WE : in std_logic;
  dataOut : out std_logic_vector (31 downto 0));
end entity;

architecture behav of CU is
  
  signal reg : std_logic_vector (31 downto 0) := (others => '0');
  
begin
  process(rst, clk, dataIn, WE) begin
    
    if rst = '1' then
      reg <= (others => '0');
	  end if;
	  if rising_edge(clk) and WE = '1' then
		  reg <= dataIn;
	  end if;
	  
	end process;
	dataOut <= reg;
end behav;