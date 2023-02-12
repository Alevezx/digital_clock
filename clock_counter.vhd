library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY counter IS
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
END counter;

ARCHITECTURE behavioral OF counter IS 

   SIGNAL hoursINT, minutesINT, secondsINT : INTEGER;
   SIGNAL hour0INT, minute0INT             : INTEGER;
   
BEGIN

   hour0INT   <= hoursINT mod 10;
   minute0INT <= minutesINT mod 10;

   hour1   <= "0010" WHEN hoursINT >= 20 ELSE 
              "0001" WHEN hoursINT >= 10 ELSE 
              "0000";
   
   hour0   <= "1001" WHEN hour0INT >= 9 ELSE 
              "1000" WHEN hour0INT >= 8 ELSE
              "0111" WHEN hour0INT >= 7 ELSE
              "0110" WHEN hour0INT >= 6 ELSE
              "0101" WHEN hour0INT >= 5 ELSE
              "0100" WHEN hour0INT >= 4 ELSE
              "0011" WHEN hour0INT >= 3 ELSE
              "0010" WHEN hour0INT >= 2 ELSE
              "0001" WHEN hour0INT >= 1 ELSE
              "0000";

   minute1 <= "0110" WHEN minutesINT >= 60 ELSE
              "0101" WHEN minutesINT >= 50 ELSE
              "0100" WHEN minutesINT >= 40 ELSE
              "0011" WHEN minutesINT >= 30 ELSE
              "0010" WHEN minutesINT >= 20 ELSE
              "0001" WHEN minutesINT >= 10 ELSE
              "0000";

   minute0 <= "1001" WHEN minute0INT >= 9 ELSE 
              "1000" WHEN minute0INT >= 8 ELSE
              "0111" WHEN minute0INT >= 7 ELSE
              "0110" WHEN minute0INT >= 6 ELSE
              "0101" WHEN minute0INT >= 5 ELSE
              "0100" WHEN minute0INT >= 4 ELSE
              "0011" WHEN minute0INT >= 3 ELSE
              "0010" WHEN minute0INT >= 2 ELSE
              "0001" WHEN minute0INT >= 1 ELSE
              "0000";

   PROCESS (clk, rst)
      BEGIN
         IF (rst = '1') THEN                 -- reset time to user input
            secondsINT <= 0;
            minutesINT <= to_integer(unsigned(set_minute1)) * 10 + to_integer(unsigned(set_minute0));
            hoursINT   <= to_integer(unsigned(set_hour1)) * 10 + to_integer(unsigned(set_hour0));
         ELSE
            IF (clk = '1' AND clk'EVENT AND rst = '0') THEN
               secondsINT <= secondsINT + 1;

               IF (secondsINT >= 60) THEN       -- reset seconds and increase minutes
                  secondsINT <= 0;
                  minutesINT <= minutesINT + 1;
               END IF;
                    
               IF (minutesINT >= 60) THEN       -- reset minutes and increase hours
                  minutesINT <= 0;
                  hoursINT   <= hoursINT + 1;
               END IF;

               IF (hoursINT >= 24) THEN         -- reset hours
                  hoursINT <= 0;
               END IF;
            END IF;
         END IF;
   END PROCESS;

END behavioral;