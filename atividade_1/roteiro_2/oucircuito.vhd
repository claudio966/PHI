-- arquivo para a implementaçao da logica or

library ieee;

use ieee.std_logic_1164.all;

entity oucircuito is

	generic(
		nbits: integer := 4
	);

	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_or: out std_logic_vector (nbits - 1 downto 0)
	);

end oucircuito;

architecture comportamento of oucircuito is
begin
process(a,b)
begin
	resultado_or <= a or b;
end process;

end comportamento;
