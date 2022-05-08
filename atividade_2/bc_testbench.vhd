library ieee;

use ieee.std_logic_1164.all;

entity bc_testbench is 
end bc_testbench;

architecture comportamento of bc_testbench is
	
	signal moeda: std_logic_vector(7 downto 0) := "00000100";
	signal reset: std_logic := '0';
	signal clock: std_logic := '0';
	signal a: std_logic_vector(7 downto 0);
	signal c: std_logic := '0';
	
	component bc
		port(
			reset: in std_logic; -- entrada de reset
			clock: in std_logic; -- entrada de clock
			moeda: in std_logic_vector(7 downto 0); -- entrada correspondente ao valor monetário
			c: out std_logic; -- saída do detector de moedas
			a: out std_logic_vector(7 downto 0) -- saida do registrador
		);
	end component;
	
	begin
	
		clock <= '1' after 0.5 ns when clock = '0' else
			'0' after 0.5 ns when clock ='1';
		
		bc_test: bc
		port map(
			reset => reset,
			clock => clock,
			moeda => moeda,
			a => a,
			c => c
		);
end comportamento;