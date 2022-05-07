library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador is 
	generic (
		nbits : integer := 8;
	);
	port (
		clk : in std_logic;
		reg_load : in std_logic;
		reg_clear : in std_logic;
		output : out std_logic_vector(nbits - 1 downto 0);
		input : in std_logic_vector(nbits - 1 downto 0);
		output : in std_logic_vector(nbits - 1 downto 0);
		alu : in std_logic_vector(1 downto 0);
		ie : in st_logic;
	);
end registrador;

architeture comportamento of registrador is
	signal item_preco : std_logic_vector(nbits - 1 downto 0) := "00000000";
begin
	--multiplexador
	mux_output <= input when ie = '1' else 1;

	--ALU
	process(mux_output, reg_output, alu)
	begin
		case alu is
			when "00" =>
				alu_output <= mux_output;
			when "01" =>
				alu_output <= std_logic_vector(signed(mux_output) + signed(reg_output));
			when "10"
				alu_output <= std_logic_vector(signed(mux_output) - signed(reg_output));
			-- TODO implementar o comparador
			-- when "11"
			-- alu_output <= resultado_comparador	
		end case;
	end process;	

	--registrador
	process(clk)
	begin
		if rising_edge(clk) then
			if reg_clear = '1' then
				reg_output <= (others => '0');
			elseif reg_load = '1' then
				reg_output <= alu_output;
			endif;
		endif;
	end process;
end comportamento;
