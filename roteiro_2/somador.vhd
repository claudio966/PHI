-- codigo para o somador
library ieee;

use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity somador is
	
	generic(
		nbits: integer := 4
	);
	
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_somador: out std_logic_vector (nbits - 1 downto 0)
	);
end somador;

architecture comportamento of somador is
begin
	process(a, b)
	begin
		resultado_somador <= a + b;
	end process;
end comportamento;