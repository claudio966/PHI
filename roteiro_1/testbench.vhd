library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
--use IEEE.numeric_std.all;


ENTITY testbench is
END testbench;

ARCHITECTURE behavioral OF testbench IS
	COMPONENT contador99 
		PORT 
		(
			ck : IN STD_LOGIC;
			hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

-- input
SIGNAL ck : STD_LOGIC := '0';
CONSTANT clk_period : TIME := 1 ms;
-- output
SIGNAL hex0 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex1 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex2 :  STD_LOGIC_VECTOR(6 DOWNTO 0);

FUNCTION decoder(i : IN STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000")
	return string is
	VARIABLE output : string(1 to 4);
BEGIN
	CASE i IS
		WHEN "1000000" => output := "0x40";
		WHEN "1111001" => output := "0x79";
		WHEN "0100100" => output := "0x24";
		WHEN others => output := "0xXX";
		return output;
	END CASE;
	return output;
END FUNCTION;

BEGIN

inst : contador99 PORT MAP (
	ck => ck,
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2
);


salva_dados : PROCESS(ck)
	file arquivo : text open write_mode is "/home/demo/saida.dat";
	variable linha : line;
	variable dado : string(1 to 4);
	BEGIN
		IF RISING_EDGE(ck) THEN
			dado := decoder(hex2);
			write(linha, dado);
			--hwrite(linha, hex2); -- Use for debug
			writeline(arquivo, linha);
		END IF;
	END PROCESS;
ck <= NOT ck after clk_period/2;	

END behavioral;
