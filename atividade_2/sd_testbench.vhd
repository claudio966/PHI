library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sd_testbench is
end sd_testbench;

architecture testbench of sd_testbench is
	component sd
		port(
			clk : in std_logic := '0';
			reg_clear : in std_logic := '0';
			moeda : in std_logic_vector(7 downto 0) := "11000000";	
			alu : in std_logic_vector(1 downto 0) := "11";	
			ie : in std_logic := '1';
			liberado : out std_logic
		);
	end component;

	signal clk : std_logic := '0';
	signal reg_clear : std_logic := '0';
	signal moeda : std_logic_vector(7 downto 0) := "11000000";
	signal alu: std_logic_vector(1 downto 0) := "11";
	signal ie: std_logic := '1';
	signal liberado: std_logic;
	
begin
	clk <= '1' after 0.5 ns when clk = '0' else
		'0' after 0.5 ns when clk ='1';
	
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
--		inicio <= not inicio;
--		wait;
--	end process;
	
	sd_test: sd
	port map(
		clk => clk,
		reg_clear => reg_clear,
		moeda => moeda,
		alu => alu,
		ie => ie,
		liberado => liberado
	);
end architecture;
