library IEEE;
use IEEE.std_logic_1164.all;

entity registrador is 
	generic (
		nbits : integer := 8;
	);
	port (
		reg_load : in std_logic;
		reg_clear : in std_logic;
		output : out std_logic_vector(nbits - 1 downto 0);
	);
end registrador

architeture comportamento of registrador is
begin
	process(clk)
		if rising_edge(clk) then
			if reg_clear = '1' then
				reg_output <= (others => '0');
			elseif reg_load = '1' then
				reg_output <= alu_output;
			endif
		endif
end comportamento
