library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sd is
	port(
		clk: in std_logic;
		liberado: out std_logic;
		reset, ie : in std_logic;
		moeda : in std_logic_vector(7 downto 0)
	);
end sd;

architecture estrutura of sd is
	component bc
	port(
		reset, clk : in std_logic;
		c : out std_logic; -- saida do detector de moedas
		moeda : in std_logic_vector(7 downto 0);
		a : out std_logic_vector(7 downto 0) -- saida do registrador
		
	);
	end component;
	
	signal c: std_logic;
	signal a : std_logic_vector(7 downto 0);

	component bo
	port(
		clk : in std_logic;
		reset, ie : in std_logic;
		liberado: out std_logic;
		c: in std_logic;
		a : in std_logic_vector(7 downto 0)
	);
	end component;
begin
	fsm : bc
	port map(
		clk => clk,
		reset => reset,
		c => c,
		a => a,
		moeda => moeda
	);
	
	datapath : bo
	port map(
		clk => clk,
		reset => reset,
		c => c,
		a => a,
		liberado => liberado,
		ie => ie
	);
	
end architecture;
