-- implementacao do circuito multiplexador para 
-- selecao do circuito combinacional

library ieee;

use ieee.std_logic_1164.all;

entity mux is 

	generic(
		nbits: integer := 4
	);
	port(
		sel: in std_logic_vector (2 downto 0);
		resultado_final: out std_logic_vector (nbits - 1 downto 0);
		resultado_somador: in std_logic_vector (nbits - 1 downto 0);
		resultado_subtrator: in std_logic_vector (nbits - 1 downto 0);
		resultado_and: in std_logic_vector (nbits - 1 downto 0);
		resultado_or: in std_logic_vector (nbits - 1 downto 0);
		resultado_shift: in std_logic_vector (nbits - 1 downto 0)
	);

end mux;

architecture comportamento of mux is
begin
	resultado_final <= resultado_somador when (sel = "000") else
							 resultado_subtrator when (sel = "001") else
							 resultado_and when (sel = "010") else
	                   resultado_or when (sel = "011") else
	                   resultado_shift when (sel = "100");
				--			 null;
end comportamento;
