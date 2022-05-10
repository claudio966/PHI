library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sd_testbench is
end sd_testbench;

architecture testbench of sd_testbench is
	component sd
		port(
			clk : in std_logic;
			reg_clear : in std_logic;
			moeda : in std_logic_vector(7 downto 0);	
			ie : in std_logic;
			liberado : out std_logic
		);
	end component;

	signal clk : std_logic := '1';
	signal reg_clear : std_logic := '0';
	signal moeda : std_logic_vector(7 downto 0) := "00011001";
	signal ie: std_logic := '1';
	signal liberado: std_logic := '0';
	
begin
	clk <= '1' after 0.5 ns when clk = '0' else
		'0' after 0.5 ns when clk ='1';
	
	sd_test: sd
	port map(
		clk => clk,
		reg_clear => reg_clear,
		moeda => moeda,
		ie => ie,
		liberado => liberado
	);
end architecture;
