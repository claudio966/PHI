-- implementacao do circuito multiplexador para 
-- selecao do circuito combinacional

library ieee;

use ieee.std_logic_1164.all;

entity mux is 

	generic(
		nbits: integer := 4 -- valor default
	);
	port(
		sel: in std_logic_vector (2 downto 0); -- adiciona o seletor como porta de entrada
		resultado_final: out std_logic_vector (nbits - 1 downto 0); -- resultado final a ser passado para o registrador
		resultado_somador: in std_logic_vector (nbits - 1 downto 0); -- resultado final do somador
		resultado_subtrator: in std_logic_vector (nbits - 1 downto 0); -- resultado final do subtrator
		resultado_and: in std_logic_vector (nbits - 1 downto 0); -- resultado final do circuito and
		resultado_or: in std_logic_vector (nbits - 1 downto 0); -- resultado final do circuito or
		resultado_shift: in std_logic_vector (nbits - 1 downto 0) -- resultado final do circuito de rotacao
	);

end mux;

architecture comportamento of mux is
begin
	resultado_final <= resultado_somador when (sel = "000") else -- seleciona o circuito de soma
			   resultado_subtrator when (sel = "001") else -- seleciona o circuito de subtrator 
		   	   resultado_and when (sel = "010") else -- seleciona o circuito and
	                   resultado_or when (sel = "011") else -- seleciona o circuito or 
	                   resultado_shift when (sel = "100"); -- seleciona o circuito de rotacao
				--			 null;
end comportamento;
