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
		--alu : in std_logic_vector(1 downto 0);
		liberado : out std_logic := '0'; -- o valor de d
		ie : in std_logic
	);
end bo;

architecture comportamento of bo is
	signal item : std_logic := '0';
	signal reg_output : std_logic_vector(nbits - 1 downto 0) := "00000000";
	signal alu_output : std_logic_vector(nbits - 1 downto 0) := "11111111";
	signal item_preco : std_logic_vector(nbits - 1 downto 0) := "01100100"; -- 100 centavos
	signal mux_output : std_logic_vector(nbits - 1 downto 0);
begin
	--multiplexador
	mux_output <= a when ie = '1' else "00000000";

	--ALU
	process(mux_output, reg_output)
	begin
		if c = '1' then
			alu_output <= std_logic_vector(signed(mux_output) + signed(reg_output));
		end if;
		
		if reg_output >= item_preco then
			alu_output <= std_logic_vector(unsigned(reg_output) - unsigned(item_preco));
			item <= '1';
		end if;
	end process;	
	
	--Logica para liberar o item
	liberar_item: process(clk)
	begin
		if falling_edge(clk) then
			if item = '1' then
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

