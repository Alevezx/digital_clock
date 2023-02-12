library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;                                   

ENTITY digital_clock IS                                     
   PORT (clk         : IN  STD_LOGIC;
         rst         : IN  STD_LOGIC;
         usr_hour1   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);     -- user can set the desired hour and minute
         usr_hour0   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- one value for each 7-segment LED display, four digits in total
         usr_minute1 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
         usr_minute0 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
         hour1       : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);     -- hours and minutes displayed
         hour0       : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);     -- see LED_display.vhd for conventions
         minute1     : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
         minute0     : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END digital_clock;

ARCHITECTURE structural OF digital_clock IS

   COMPONENT display IS 
      PORT (number : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);       -- 4 digits in input (numbers from 0 to 9)
            led    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));      -- 7 digits in output (one for every led that can be activated)
   END COMPONENT;

   COMPONENT counter IS
   PORT (clk         : IN  STD_LOGIC;
         rst         : IN  STD_LOGIC;
         set_hour1   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);     -- user can set the desired hour and minute
         set_hour0   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);     -- one value for each 7-segment LED display, four digits in total
         set_minute1 : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
         set_minute0 : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
         hour1       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);     -- clock digits as one exadecimal value each
         hour0       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);     
         minute1     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         minute0     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
   END COMPONENT;

   SIGNAL hour1X, hour0X, minute1X, minute0X : STD_LOGIC_VECTOR(3 DOWNTO 0);  -- clock digits as one exadecimal value

BEGIN

   LED_hour1   :  display PORT MAP (number => hour1X,
                                    led    => hour1);

   LED_hour0   :  display PORT MAP (number => hour0X,
                                    led    => hour0);

   LED_minute1 :  display PORT MAP (number => minute1X,
                                    led    => minute1);
                                    
   LED_minute9 :  display PORT MAP (number => minute0X,
                                    led    => minute0);

   clock       :  counter PORT MAP (clk         => clk,
                                    rst         => rst,
                                    set_hour1   => usr_hour1,
                                    set_hour0   => usr_hour0,
                                    set_minute1 => usr_minute1,
                                    set_minute0 => usr_minute0,
                                    hour1       => hour1X,
                                    hour0       => hour0X,
                                    minute1     => minute1X,
                                    minute0     => minute0X);

END structural;