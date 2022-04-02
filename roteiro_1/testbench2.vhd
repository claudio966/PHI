LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench2 IS 
END testbench2;

ARCHITECTURE behavior OF testbench2 IS
	SIGNAL ck : STD_LOGIC := '0';
	CONSTANT clk_period : TIME := 1 ns;

	COMPONENT contador99
		PORT(ck : IN STD_LOGIC);
	END COMPONENT;

BEGIN

   uut: contador99 PORT MAP (ck => ck);       
--   clk_process : process
   BEGIN
        ck <= '0';
        WAIT FOR clk_period/2;  --for 0.5 ns signal is '0'.
        ck <= '1';
        WAIT FOR clk_period/2;  --for next 0.5 ns signal is '1'.
   END PROCESS;

END behavior;