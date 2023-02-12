library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY display IS 
   PORT (number : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);       -- 4 digits in input (numbers from 0 to 9)
         led    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));      -- 7 digits in output (one for every led that can be activated)
END display;

-- should indicate which LEDs to turn on for the number to display properly
--         -0-       --- 
--         | |       | | 
--         3 4       | | 
--         -1-       ---        
--         | |       | |    
--         5 6       | |  
--         -2-       ---

ARCHITECTURE behavior OF display IS 

   SIGNAL on_led : STD_LOGIC_VECTOR(6 DOWNTO 0) := (OTHERS => '0');

BEGIN

   led <= on_led;

   PROCESS(number)
   BEGIN
      CASE number IS
         WHEN "0000" => on_led <= "1111101"; -- 0
         WHEN "0001" => on_led <= "1010000"; -- 1
         WHEN "0010" => on_led <= "0110111"; -- 2
         WHEN "0011" => on_led <= "1010111"; -- 3
         WHEN "0100" => on_led <= "1011010"; -- 4
         WHEN "0101" => on_led <= "1001111"; -- 5
         WHEN "0110" => on_led <= "1101111"; -- 6
         WHEN "0111" => on_led <= "1010001"; -- 7
         WHEN "1000" => on_led <= "1111111"; -- 8
         WHEN "1001" => on_led <= "1011111"; -- 9
         WHEN OTHERS => on_led <= "1001011"; -- should be F as in failure, normally it should never be used
      END CASE;
   END PROCESS;

END behavior;