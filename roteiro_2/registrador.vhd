-- implementacao do circuito registrador

library ieee;

use ieee.std_logic_1164.all;

entity registrador is 

	generic(
		nbits: integer := 4
	);
	port(
		clk: in std_logic;
		resultado_final: in std_logic_vector (nbits - 1 downto 0);
		saida: out std_logic_vector (nbits -1 downto 0)
	);

end registrador;

architecture comportamento of registrador is	
begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			saida <= resultado_final;
		end if;
	end process;

end comportamento;