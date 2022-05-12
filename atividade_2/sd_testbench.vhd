library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sd_testbench is
end sd_testbench;

architecture testbench of sd_testbench is
	component sd
		port(
			reset: in std_logic;
			clk : in std_logic;
			reg_clear : in std_logic;
			moeda : in std_logic_vector(7 downto 0);	
			ie : in std_logic;
			liberado : out std_logic
		);
	end component;
	
	type array_declaration is array (0 to 3) of std_logic_vector(7 downto 0);
	
	signal moeda_array: array_declaration := ("00001010", "00010100", "00011110", "00101000");
	
	signal i: integer := 0;
	signal clk : std_logic := '1';
	signal reg_clear : std_logic := '0';
	signal moeda : std_logic_vector(7 downto 0) := "00000000";
	signal ie: std_logic := '1';
	signal liberado: std_logic := '0';
	signal reset: std_logic := '0';
	
begin

	clk <= '1' after 0.5 ns when clk = '0' else
		'0' after 0.5 ns when clk ='1';
		
	reset <= '1' after 2 ns when reset = '0' else
		'0' after 2 ns when reset ='1';
	
	sd_test: sd
	port map(
		reset => reset,
		clk => clk,
		reg_clear => reg_clear,
		moeda => moeda,
		ie => ie,
		liberado => liberado
	);
	inserir_moeda: process(clk)
	begin
		if falling_edge(clk) then
			if i > 3 then
				i <= 0;
			else
				moeda <= moeda_array(i);
				i <= i + 1;
			end if;
		end if;
	end process;	
end architecture;
