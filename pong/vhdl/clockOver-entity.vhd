LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY clockOver IS
   PORT ( clock   : IN  std_logic;
          reset   : IN  std_logic;
          enable  : OUT std_logic );
END entity;
