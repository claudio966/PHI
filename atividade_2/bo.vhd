library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bo is 
	generic (
		nbits : integer := 8
	);

	port (
		clk : in std_logic;
		c : in std_logic; -- Entrada da moeda detectada
		reg_clear : in std_logic;
		a : in std_logic_vector(nbits - 1 downto 0); -- Saida do registrado de BC
		alu : in std_logic_vector(1 downto 0);
		liberado : out std_logic; -- o valor de d
		ie : in std_logic
	);
end bo;

architecture comportamento of bo is
	signal reg_output : std_logic_vector(nbits - 1 downto 0) := "00000000";
	signal alu_output : std_logic_vector(nbits - 1 downto 0);
	signal item_preco : std_logic_vector(nbits - 1 downto 0) := "01100100"; -- 100 centavos
	signal mux_output : std_logic_vector(nbits - 1 downto 0);
begin
	--multiplexador
	mux_output <= a when ie = '1' else "00000000";

	--ALU
	process(mux_output, reg_output, alu)
	begin
		case alu is
			when "00" =>
				alu_output <= mux_output;
			when "01" =>
				alu_output <= std_logic_vector(signed(mux_output) + signed(reg_output));
			when "10" =>
				alu_output <= std_logic_vector(signed(mux_output) - signed(reg_output));
			when "11" =>
				if signed(a) >= signed(item_preco) then
					alu_output <= "00000001";
				else
					alu_output <= "00000000";
				end if;
			when others =>
				alu_output <= (others => '0');
		end case;
	end process;	
	
	--Logica para liberar o item
	liberar_item: process(clk)
	begin
		if rising_edge(clk) then
			if alu_output = "00000001" then
				liberado <= '1';
			else 
				liberado <= '0';
			end if;
		end if;
	end process;
	
	--registrador
	registrador_op: process(clk)
	begin
		if rising_edge(clk) then
			if reg_clear = '1' then
				reg_output <= (others => '0');
			elsif c = '1' then
				reg_output <= alu_output;
			end if;
		end if;
	end process;
end comportamento;

