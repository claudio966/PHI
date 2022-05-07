library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somatorio is
	port(
		clk : in std_logic;
		reset : in std_logic;
		inicio : in std_logic;
		valor : in std_logic_vector(7 downto 0);
		proximo : out std_logic;
		pronto : out std_logic;
		overflow : out std_logic;
		soma : out std_logic_vector(7 downto 0)
	);
end somatorio;

architecture estrutura of somatorio is
	component bc
	port(
		clk, reset, inicio	: in  std_logic;
		pronto, overflow : out std_logic;
		set, dec : out std_logic;
		cac, rac : out std_logic;
		zero, overflow_flag : in std_logic;
		proximo : out std_logic
	);
	end component;
	
	component bo
	port(
		clk : in std_logic;
		set, dec : in std_logic;
		cac, rac : in std_logic;
		zero, overflow : out std_logic;
		valor : in std_logic_vector(7 downto 0);
		soma : out std_logic_vector(7 downto 0)
	);
	end component;
	signal set, dec, cac, rac, zero, overflow_interno : std_logic;
begin
	fsm : bc
	port map(
		clk => clk, 
		reset => reset, 
		inicio => inicio,
		pronto => pronto,
		overflow => overflow,
		set => set, 
		dec => dec,
		cac => cac,
		rac => rac,
		zero => zero, 
		overflow_flag => overflow_interno,
		proximo => proximo
	);
	
	datapath : bo
	port map(
		clk => clk,
		set => set,
		dec => dec,
		cac => cac,
		rac => rac,
		zero => zero, 
		overflow => overflow_interno,
		valor => valor,
		soma => soma
	);
	
end architecture;