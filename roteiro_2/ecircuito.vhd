-- arquivo para implementacao do and

library ieee;

use ieee.std_logic_1164.all;

entity ecircuito is

	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_and: out std_logic_vector (nbits - 1 downto 0)
	);
end ecircuito;

architecture comportamento of ecircuito is
begin
	process(a, b)
	begin
		resultado_and <= a and b;
	end process;
end comportamento;