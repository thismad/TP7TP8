library ieee;
use ieee.std_logic_1164.all;

entity movement is
generic(WIDTH : natural := 9;
        INIT  : std_logic_vector := "000010000"); --middle of the card
port(dir    : in std_logic;
	  ext_change : in std_logic;
     enable : in std_logic;
     reset  : in std_logic;
     clock  : in std_logic;
     pos    : out std_logic_vector(WIDTH - 1 downto 0));
end entity movement;
