library ieee;

use ieee.std_logic_1164.all;

entity bc is

	port(
		reset_state: in std_logic := '1';
		reset: in std_logic := '0'; -- entrada de reset
		clk: in std_logic; -- entrada de clk
		moeda: in std_logic_vector(7 downto 0); -- entrada correspondente ao valor monetário
		c: out std_logic; -- saída do detector de moedas
		a: out std_logic_vector(7 downto 0) -- saida do registrador
	);

end bc;

architecture comportamento of bc is

	type estados is (S0, S1); -- define os estados existentes no proximo

	signal estado_atual, proximo_estado: estados := S0; -- cria um sinal para cada estado
	signal com_moeda: std_logic := '0'; -- verifica se uma moeda foi inserida
	
	begin

	-- altera para o próximo estado quando o valor de c for modificado
	logica_proximo_estado: process(estado_atual, com_moeda, reset_state)
	begin
		case estado_atual is
			when S0 =>
				if com_moeda = '1' then
					proximo_estado <= S1; 
				else
					proximo_estado <= S0;
				end if;
			when S1 =>
				if reset_state = '0' then
					proximo_estado <= S0;
				elsif com_moeda = '0' then
					proximo_estado <= S0;
				else
					proximo_estado <= S1;	
				end if;
		end case;
	end process;
	-- processo responsável por modificar o valor do sinal 
	detector_moeda: process(clk, moeda)
	begin
		if rising_edge(clk) then
			com_moeda <= '1';	
		end if;
	end process;
	-- processo responsavel pela mudança de estado
	registrador_estado: process(clk, reset)
	begin 
		if reset = '1' then
			estado_atual <= S0;
		elsif rising_edge(clk) then
			estado_atual <= proximo_estado;
		end if;
	end process;
	-- passa o valor numerico para a saida 
	registrador_saida: process(clk, estado_atual)
	begin
		case estado_atual is
			when S0 =>
				a <= "00000000";
				c <= '0';
			when S1 => 
				if rising_edge(clk) then
					a <= moeda;
					c <= com_moeda;
				end if;
		end case;
	end process;
end comportamento;
