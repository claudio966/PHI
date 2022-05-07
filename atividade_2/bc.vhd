library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bc is
	port(
		clk, reset, com_moeda : in  std_logic;
		moeda : out std_logic_vector (7 downto 0);
		pronto : out std_logic
	);
end bc;

architecture comportamento of bc is
	type tipo_estado is (S0, S1);
	signal prox_estado, estado : tipo_estado := S0;
begin
	-- Circuito combinacional -> não depende de clock
	logica_proximo_estado : process(estado, com_moeda)
	begin
		case estado is
			when S0 =>
				if com_moeda = '1' then
					prox_estado <= S1;
				else
					prox_estado <= S0;
				end if;
			when S1 => 
				if com_moeda = '0' then
					prox_estado <= S0;
				else
					prox_estado <= S1;
				end if;
		end case;
	end process;
	
	registrador_estado : process(clk, reset)
	begin
		if reset = '1' then
			estado <= S0;
		elsif rising_edge(clk) then
			estado <= prox_estado;
		end if;
	end process;
	
	-- Circuito combinacional -> não depende de clock
	logica_saida : process(estado)
	begin
		case estado is
			when S0 =>
				pronto <= '0';
			when S1 =>
				pronto <= '1';
		end case;
	end process;
	
end architecture;
