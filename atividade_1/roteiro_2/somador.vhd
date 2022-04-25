-- codigo para o somador
library ieee;

use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity somador is
	
	generic(
		nbits: integer := 4 -- valor default
	);
	
	port(
		a : in std_logic_vector (nbits - 1 downto 0); -- operando de entrada
		b : in std_logic_vector (nbits - 1 downto 0); -- operando de entrada
		resultado_somador: out std_logic_vector (nbits - 1 downto 0) -- valor a ser exibido na saida do somador
	);
end somador;

architecture comportamento of somador is
begin
	process(a, b) -- inicializa o processo para a operação de soma, o gatilho é a inserção dos valores 
	begin
		resultado_somador <= a + b; -- atribui a soma A + B a saida do somador
	end process;
end comportamento;
