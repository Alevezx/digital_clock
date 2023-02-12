library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY testBench IS 
END testBench;

ARCHITECTURE structural OF testBench IS 

   COMPONENT digital_clock IS                                     
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
   END COMPONENT;

   COMPONENT clock_generator IS                                     
      PORT (clk         : OUT STD_LOGIC;
            rst         : OUT STD_LOGIC;
            usr_hour1   : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            usr_hour0   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            usr_minute1 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            usr_minute0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hour1       : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
            hour0       : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
            minute1     : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
            minute0     : IN  STD_LOGIC_VECTOR(6 DOWNTO 0));
   END COMPONENT;


   SIGNAL clkTB, rstTB  : STD_LOGIC;
   SIGNAL hour1TB       : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL hour0TB       : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL minute1TB     : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL minute0TB     : STD_LOGIC_VECTOR(6 DOWNTO 0);
   SIGNAL usr_hour1TB   : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL usr_hour0TB   : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL usr_minute1TB : STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL usr_minute0TB : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN 

   dig_clock:  digital_clock PORT MAP    (clk         => clkTB,
                                          rst         => rstTB,
                                          usr_hour1   => usr_hour1TB,
                                          usr_hour0   => usr_hour0TB,
                                          usr_minute1 => usr_minute1TB,
                                          usr_minute0 => usr_minute0TB,
                                          hour1       => hour1TB,
                                          hour0       => hour0TB,
                                          minute1     => minute1TB,
                                          minute0     => minute0TB);

   clock_gen:  clock_generator PORT MAP  (clk         => clkTB,
                                          rst         => rstTB,
                                          usr_hour1   => usr_hour1TB,
                                          usr_hour0   => usr_hour0TB,
                                          usr_minute1 => usr_minute1TB,
                                          usr_minute0 => usr_minute0TB,
                                          hour1       => hour1TB,
                                          hour0       => hour0TB,
                                          minute1     => minute1TB,
                                          minute0     => minute0TB);

END structural;