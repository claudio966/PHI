-- circuito para a implementacao da operacao de shift

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_bit.all;
use IEEE.std_logic_unsigned.all;

entity shift is 
	generic(
		nbits: integer := 4 -- valor default
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0); -- entrada do circuito
		b : in std_logic_vector (nbits - 1 downto 0); -- entrada do circuito
		resultado_shift: out std_logic_vector (nbits - 1 downto 0) -- saida do circuito
	);
end shift;

architecture comportamento of shift is
	begin
	process(a,b) -- declaracao do processo. O gatilho é a inserção dos operandos
	begin
		resultado_shift <= std_logic_vector(ROTATE_LEFT(unsigned(a), unsigned(b) )); -- realiza a operacao de rotacao
	end process;
end comportamento;
