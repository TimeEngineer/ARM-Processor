library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Unite Arithmetique Logique
entity ALU is port(
	OP	: in std_logic_vector (1 downto 0);		-- Command signal
	A	: in std_logic_vector (31 downto 0);	-- 32 bits input
	B	: in std_logic_vector (31 downto 0);	-- 32 bits input
	S	: out std_logic_vector (31 downto 0);	-- 32 bits output
	N	: out std_logic;						-- Output sign, 1 for strictly negative value, 0 for positive
	Z	: out std_logic;						-- 1 if result is zero/null
	C	: out std_logic;						-- 1 if there is a carry
	V	: out std_logic);						-- 1 if there is an overflow
end ALU;

architecture behav of ALU is

	signal S_sig : std_logic_vector (31 downto 0);

begin
process (OP, A, B) begin
	case OP is

		-------------------- 00 --------------------
		when "00" => S_sig <= std_logic_vector(signed(A)+signed(B));
			if A(31) = '0' then
				if B(31) = '0' then
					if S_sig(31) = '0' then
						C <= '0';
						V <= '0';
					else
						C <= '1';
						V <= '0';
					end if;
				else
					C <= '0';
					V <= '0';
				end if;
			else
				if B(31) = '0' then
					C <= '0';
					V <= '0';
				else
					if S_sig(31) = '0' then
						C <= '1';
						V <= '1';
					else
						C <= '0';
						V <= '0';
					end if;
				end if;
			end if;
		-------------------- 00 --------------------

		-------------------- 01 --------------------
		when "01" => S_sig <= B;
		-------------------- 01 --------------------

		-------------------- 10 --------------------
		when "10" => S_sig <= std_logic_vector(signed(A)-signed(B));
			if A(31) = '0' then
				if B(31) = '0' then
					C <= '0';
					V <= '0';
				else
					if S_sig(31) = '0' then
						C <= '0';
						V <= '0';
					else
						C <= '1';
						V <= '0';
					end if;
				end if;
			else
				if B(31) = '0' then
					if S_sig(31) = '0' then
						C <= '1';
						V <= '1';
					else
						C <= '0';
						V <= '0';
					end if;
				else
					C <= '0';
					V <= '0';
				end if;
			end if;
		-------------------- 10 --------------------

		-------------------- 11 --------------------
		when others => S_sig <= A;
		-------------------- 11 --------------------

	end case;

	if S_sig = X"00000000" then
		Z <= '1';
	else
		Z <= '0';
	end if;

end process;
S <= S_sig;
N <= S_sig(31);							-- bit 31 determines the sign
end behav;
