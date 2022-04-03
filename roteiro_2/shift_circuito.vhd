-- circuito para a implementacao da operacao de shift

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_bit.all;
use IEEE.std_logic_unsigned.all;

entity shift is 
	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_shift: out std_logic_vector (nbits - 1 downto 0)
	);
end shift;

architecture comportamento of shift is
	begin
	process(a,b) 
	begin
		resultado_shift <= std_logic_vector(ROTATE_LEFT(unsigned(a), unsigned(b) ));	
	end process;
end comportamento;