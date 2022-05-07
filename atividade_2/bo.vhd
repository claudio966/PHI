library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bo is
	port(
		clk : in std_logic;
		set, dec : in std_logic;
		cac, rac : in std_logic;
		zero, overflow : out std_logic;
		valor : in std_logic_vector(7 downto 0);
		soma : out std_logic_vector(7 downto 0)
	);
end bo;

architecture comportamento of bo is
	signal acum_out, soma_out : std_logic_vector(7 downto 0);
	signal cont_out : std_logic_vector(7 downto 0);
begin
	acum : process(clk)
	begin
		if rising_edge(clk) then
			if rac = '1' then
				acum_out <= (others => '0');
			elsif cac = '1' then
				acum_out <= soma_out;
			end if;
		end if;
	end process;
	
	cont : process(clk)
	begin
		if rising_edge(clk) then
			if set = '1' then
				cont_out <= std_logic_vector(to_unsigned(4, cont_out'length));
			elsif dec = '1' then
				cont_out <= std_logic_vector(unsigned(cont_out) - 1);
			end if;
		end if;
	end process;
	
	zero <= '1' when unsigned(cont_out)=0 else '0';
	
	soma_out <= std_logic_vector(unsigned(acum_out) + unsigned(valor));
	
	soma <= acum_out;
	overflow <= '0';
	
end architecture;