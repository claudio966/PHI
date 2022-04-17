-- testbench para o roteiro 2
library ieee;

use std.textio.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture comportamento of testbench is 

	signal nbits: integer := 4;

	file resultado_ula : text open write_mode is "/home/demo/resultado_ula.txt";
	
	type t_Memory is array (0 to 3) of std_logic_vector(nbits - 1 downto 0);

	signal clk: std_logic := '0';
	
	signal a_array : t_Memory;
	signal b_array : t_Memory;
	
	signal resultado_operacao: std_logic_vector(3 downto 0) := "0000";
	signal operacao: std_logic_vector (2 downto 0) := "100";
	signal a: std_logic_vector (nbits - 1 downto 0) := "0000";
	signal b: std_logic_vector (nbits - 1 downto 0) := "0000";
	signal i: integer := 0;

	signal d0 : std_logic_vector(3 downto 0) := "0001";
	signal d1 : std_logic_vector(3 downto 0) := "0010";
	signal d2 : std_logic_vector(3 downto 0) := "0001";
	signal d3 : std_logic_vector(3 downto 0) := "0001";
	signal d4 : std_logic_vector(3 downto 0) := "0000";
	signal d5 : std_logic_vector(3 downto 0) := "0001";
	signal d6 : std_logic_vector(3 downto 0) := "0001";
	signal d7 : std_logic_vector(3 downto 0) := "0001";

	component top_level
	generic(
		nbits : integer := 4 --numero de bits configuravel
	);
	port(
		clk: in std_logic;
		sel: in std_logic_vector (2 downto 0) := "100";
		a : in std_logic_vector (nbits - 1 downto 0) := "0000";
		b : in std_logic_vector (nbits - 1 downto 0) := "0000";
		saida : out std_logic_vector (nbits - 1 downto 0)
	);
	end component;
begin
		
	-- TODO verificar a forma correta de converter um integer
	-- para um std_logic_vector
	clk <=  '1' after 0.5 ns when clk = '0' else
			  '0' after 0.5 ns when clk = '1';
	a_array(0) <= d0;
	a_array(1) <= d1;
	a_array(2) <= d2;
	a_array(3) <= d3;
	
	b_array(0) <= d4;
	b_array(1) <= d5;
	b_array(2) <= d6;
	b_array(3) <= d7;
		
	ula: top_level
	port map(
		clk => clk,
		a => a,
		b => b,
		sel => operacao, -- mapeia o sinal de soma para teste do circuito 
		saida => resultado_operacao -- mapeia a saida para o sinal a ser salvo
	);
	process(clk)
		
		variable linha_arquivo : line;
		begin
		if rising_edge(clk) then
			if i > 1 then
				i <= 0;
			else
				i <= i + 1;
			end if;
				
			a <= a_array(i);
			b <= b_array(i);
			
		write(linha_arquivo, to_integer(unsigned(a))); -- escreve o primeiro operando na linha
		write(linha_arquivo, ' ');
	--	write(linha_arquivo, '+'); -- escreve a operacao realizada
	--	write(linha_arquivo, ' ');
	--	write(linha_arquivo, to_integer(unsigned(b))); -- escreve o segundo operando na linha
		write(linha_arquivo, '='); -- sinal
		write(linha_arquivo, '>');
	--	write(linha_arquivo, ' ');
		write(linha_arquivo, to_integer(unsigned(resultado_operacao))); -- resultado obtido
		writeline(resultado_ula, linha_arquivo); -- escreve a linha no arquivo
	end if;
	end process;
end comportamento;
