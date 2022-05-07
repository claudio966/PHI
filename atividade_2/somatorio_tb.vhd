library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somatorio_tb is
end somatorio_tb;

architecture testbench of somatorio_tb is
	component somatorio
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
	end component;
	
	signal clk : std_logic := '0';
	signal reset : std_logic := '1';
	signal inicio : std_logic := '0';
	signal valor : std_logic_vector(7 downto 0);
	signal proximo : std_logic;
	signal pronto : std_logic;
	signal overflow : std_logic;
	signal soma: std_logic_vector(7 downto 0);
	
	type tipo_valores is array (0 to 3) of integer;
	constant valores : tipo_valores := (2, 3, 5, 7);
begin
	clk <= not clk after 5 ns;
	reset <= '0' after 1 us;
	--inicio <= '1' after 2 us;
	
--	process
--	begin
--		
--		inicio <= '1';
--				inicio <= not inicio;
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		wait until rising_edge(clk);
--		inicio <= not inicio;
--		wait;
--	end process;
	
	process(clk)
		variable i : integer := 0;
	begin
		if rising_edge(clk) then
			valor <= 
			std_logic_vector(to_unsigned(valores(i), valor'length));
			if proximo = '1' then
				i := i + 1;
				if i = 4 then
					i := 0;
				end if;
			end if;
		end if;
	end process; 
	
	instancia : somatorio
	port map(
		clk => clk,
		reset => reset,
		inicio => inicio,
		valor => valor,
		proximo => proximo,
		pronto => pronto,
		overflow => overflow,
		soma => soma
	);
end architecture;