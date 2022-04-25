-- arquivo para a implementaçao do subtrator

library ieee;

use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity subtrator is

	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_subtrator: out std_logic_vector (nbits - 1 downto 0)
	);

end subtrator;

architecture comportamento of subtrator is
begin
	process(a,b)
	begin
		resultado_subtrator <= a - b;
	end process;
end comportamento;