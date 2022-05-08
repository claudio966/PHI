library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sd is
	port(
		clk : in std_logic
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
	
	component bo
	port(
		clk : in std_logic;
		reg_clear, ie : in std_logic;
		liberado: out std_logic;
		c: in std_logic;
		a : in std_logic_vector(7 downto 0);
		alu : in std_logic_vector(1 downto 0)
	);
	end component;
	signal c, reg_clear, ie, reset, liberado : std_logic;
	signal a, moeda: std_logic_vector(7 downto 0);
	signal alu: std_logic_vector(1 downto 0);
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
		c => c,
		a => a,
		reg_clear => reg_clear,
		alu => alu,
   	liberado => liberado,
		ie => ie
	);
	
end architecture;
