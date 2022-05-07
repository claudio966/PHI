library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bc is
	port(
		clk, reset, inicio	: in  std_logic;
		pronto, overflow : out std_logic;
		set, dec : out std_logic;
		cac, rac : out std_logic;
		zero, overflow_flag : in std_logic;
		proximo : out std_logic
	);
end bc;

architecture comportamento of bc is
	type tipo_estado is (S0, S1, S2, S3);
	signal prox_estado, estado : tipo_estado := S0;
begin
	-- Circuito combinacional -> não depende de clock
	logica_proximo_estado : process(estado, inicio, zero)
	begin
		case estado is
			when S0 =>
				if inicio = '0' then
					prox_estado <= S0;
				else
					prox_estado <= S1;
				end if;
			when S1 => 
				if zero = '0' then
					prox_estado <= S2;
				else
					prox_estado <= S3;
				end if;
			when S2 =>
				prox_estado <= S1;
			when S3 =>
				prox_estado <= S0;
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
	logica_saida : process(estado, overflow_flag)
	begin
		case estado is
			when S0 =>
				pronto <= '1';
				cac <= '0';
				rac <= '1';
				set <= '1';
				dec <= '0';
				overflow <= overflow_flag;
				proximo <= '0';
			when S1 =>
				pronto <= '0';
				cac <= '0';
				rac <= '0';
				set <= '0';
				dec <= '0';
				overflow <= overflow_flag;
				proximo <= '0';
			when S2 =>
				pronto <= '0';
				cac <= '1';
				rac <= '0';
				set <= '0';
				dec <= '1';
				overflow <= overflow_flag;
				proximo <= '1';
			when S3 =>
				pronto <= '1';
				cac <= '0';
				rac <= '0';
				set <= '0';
				dec <= '0';
				overflow <= overflow_flag;
				proximo <= '0';
		end case;
	end process;
	
end architecture;