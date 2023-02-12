library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;                                   

ENTITY clock_generator IS                                     
   PORT (clk         : OUT STD_LOGIC;
         rst         : OUT STD_LOGIC;
         usr_hour1   : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);     -- user can set the desired hour and minute
         usr_hour0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);     -- one value for each 7-segment LED display, four digits IN total
         usr_minute1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
         usr_minute0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         hour1       : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);     -- hours and minutes displayed
         hour0       : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);     -- see LED_display.vhd for conventions
         minute1     : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
         minute0     : IN  STD_LOGIC_VECTOR(6 DOWNTO 0));
END clock_generator;

ARCHITECTURE behavioral OF clock_generator IS

   CONSTANT DT  : TIME := 2 ns;
   CONSTANT DTR : TIME := 1 ns;

BEGIN

   usr_hour1   <= "01";
   usr_hour0   <= "0001";
   usr_minute1 <= "010";
   usr_minute0 <= "0001";

   reset:   PROCESS
            BEGIN
               rst <= '1';
               WAIT FOR DTR;
               rst <= '0';
               WAIT;
            END PROCESS;

   clock:   PROCESS
               VARIABLE ck : STD_LOGIC := '0';
            BEGIN
               clk <= ck;
               ck := NOT ck;
               WAIT FOR DT;
            END PROCESS;


END behavioral;