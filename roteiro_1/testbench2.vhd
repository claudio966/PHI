library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;


ENTITY testbench2 is
END testbench2;

ARCHITECTURE Behavioral OF testbench2 IS
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
CONSTANT clk_period : TIME := 2 ns;
-- output
SIGNAL hex0 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex1 :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex2 :  STD_LOGIC_VECTOR(6 DOWNTO 0);

FUNCTION decoder(i : IN STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000")
	return string is
	VARIABLE output : string(1 to 4);
BEGIN
		output := string(i);
--		WHEN "1111110" => output := "0x01";
--		WHEN "1001111" => output := "0x4F";
--		WHEN "0100100" => output := "0x12";
--		WHEN others => output := "0xXX";
	return output;
END FUNCTION;

BEGIN

uut : contador99 PORT MAP (
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
			dado := decoder(hex0);
			write(linha, dado);
			writeline(arquivo, linha);
		END IF;
	END PROCESS;
ck <= NOT ck after clk_period/2;	

END;
