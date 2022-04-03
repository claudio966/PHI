library ieee;

use ieee.std_logic_1164.all;

entity top_level is

	generic(
		nbits : integer := 4 --numero de bits configuravel
	);
	port(
			clk: in std_logic;
			sel: in std_logic_vector (2 downto 0);
			a : in std_logic_vector (nbits - 1 downto 0);
			b : in std_logic_vector (nbits - 1 downto 0);
			saida : out std_logic_vector (nbits - 1 downto 0)
	);
end top_level;

architecture comportamento of top_level is
	
	component somador
	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_somador: out std_logic_vector (nbits - 1 downto 0)
	);
	end component;
	component subtrator
	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_subtrator: out std_logic_vector (nbits - 1 downto 0)
	);
	end component;
	component ecircuito
	generic(
		nbits: integer := 4
	);
	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_and: out std_logic_vector (nbits - 1 downto 0)
	);
	end component;
	component oucircuito
	generic(
		nbits: integer := 4
	);

	port(
		a : in std_logic_vector (nbits - 1 downto 0);
		b : in std_logic_vector (nbits - 1 downto 0);
		resultado_or: out std_logic_vector (nbits - 1 downto 0)
	);
	end component;
	component mux
	generic(
		nbits: integer := 4
	);
	port(
		sel: in std_logic_vector (2 downto 0);
		resultado_final: out std_logic_vector (nbits - 1 downto 0);
		resultado_somador: in std_logic_vector (nbits - 1 downto 0);
		resultado_subtrator: in std_logic_vector (nbits - 1 downto 0);
		resultado_and: in std_logic_vector (nbits - 1 downto 0);
		resultado_or: in std_logic_vector (nbits - 1 downto 0);
		resultado_shift: in std_logic_vector (nbits - 1 downto 0)
	);
	end component;
	component registrador
	generic(
		nbits: integer := 4
	);
	port(
		clk: in std_logic;
		resultado_final: in std_logic_vector (nbits - 1 downto 0);
		saida: out std_logic_vector (nbits -1 downto 0)
	);
	end component;
	
	signal resultado_somador, resultado_subtrator : std_logic_vector (nbits -1 downto 0);
	signal resultado_or, resultado_and : std_logic_vector (nbits -1 downto 0);
	signal resultado_shift : std_logic_vector (nbits -1 downto 0);
	signal resultado_final : std_logic_vector (nbits -1 downto 0);
	
	begin
	
		somador_ula: somador
		generic map(
			nbits => nbits
		)
		port map(
			a => a,
			b => b,
			resultado_somador => resultado_somador
		);
		subtrator_ula: subtrator
		generic map(
			nbits => nbits
		)
		port map(
			a => a,
			b => b,
			resultado_subtrator => resultado_subtrator
		);
		and_ula: ecircuito
		generic map(
			nbits => nbits
		)
		port map(
			a => a,
			b => b,
			resultado_and => resultado_and
		);
		or_ula: oucircuito
		generic map(
			nbits => nbits
		)
		port map(
			a => a,
			b => b,
			resultado_or => resultado_or
		);
		mux_ula: mux
		generic map(
			nbits => nbits
		)
		port map(
			sel => sel,
			resultado_somador => resultado_somador,
			resultado_subtrator => resultado_subtrator,
			resultado_or => resultado_or,
			resultado_and => resultado_and,
			resultado_shift => resultado_shift,
			resultado_final => resultado_final
		);
		registrador_ula: registrador
		generic map(
			nbits => nbits
		)
		port map(
			clk => clk,
			resultado_final => resultado_final,
			saida => saida
		);		
end comportamento;