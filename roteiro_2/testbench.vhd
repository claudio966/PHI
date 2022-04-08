-- testbench para o roteiro 2
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture comportamento of testbench is 

	file resultado_ula : text open write_mode is "resultado_ula.txt";
	
	type t_Memory is array (0 to 3) of std_logic_vector(nbits - 1 downto 0);

	signal nbits: integer := 4;
	signal clk: std_logic := '0';
	
	constant a_array : t_Memory;
	constant b_array : t_Memory;
	
	signal operacao: std_logic_vector := "000";
	signal a_cv: std_logic_vector;
	signal b_cv : std_logic_vector;
	signal i: integer := 0;

	component top_level
	generic(
		nbits : integer := 4 --numero de bits configuravel
	);
	port(
		clk: in std_logic;
		sel: in std_logic_vector (2 downto 0);
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		saida : out std_logic_vector (nbits - 1 downto 0)
	);
	end component;

	begin
	
		clk <=  '1' after 0.5 ns when clk = '0' else
				  '0' after 0.5 ns when clk = '1';
				  
		a_array(0) <= "1100";
		a_array(1) <= "1101";
		a_array(2) <= "1111";
		a_array(3) <= "1000";
		
		b_array(0) <= "1000";
		b_array(1) <= "1001";
		b_array(2) <= "1100";
		b_array(3) <= "1010";
		
		ula: top_level
		port map(
			clk => clk,
			a_cv => a,
			b_cv => b,
			operacao => sel, -- mapeia o sinal de soma para teste do circuito 
			saida => resultado_operacao -- mapeia a saida para o sinal a ser salvo
		);
		process(clk)
		variable linha_arquivo : line;
		begin
		if rising_edge(clk) then
			if i > 3 then
				i <= 0;
			end if;
			
			a_cv <= a_array(i);
			b_cv <= b_array(i);
			
			write(linha_arquivo, a_cv); -- escreve o primeiro operando na linha
			write(linha_arquivo, '+'); -- escreve a operacao realizada
			write(linha_arquivo, b_cv); -- escreve o segundo operando na linha
			write(linha_arquivo, '='); -- sinal
			write(linha_arquivo, resultado_operacao); -- resultado obtido
			writeline(resultado_ula, linha_arquivo); -- escreve a linha no arquivo
			i <= i + 1;
		end if;
		end process;
end comportamento;
