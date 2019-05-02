architecture rtl of movement_full is

  component direction
    port (clock, change, enable, reset : in  std_logic;
          dir                          : out std_logic);
  end component direction;

  component movement
    port(dir, enable, reset, clock : in  std_logic;
         pos                       : out std_logic_vector);
  end component movement;

  signal s_and1   : std_logic;
  signal s_and2   : std_logic;
  signal s_xor    : std_logic;
  signal s_dirOut : std_logic;
  signal s_posOut : std_logic_vector (WIDTH-1 downto 0);

begin
  -- GATES

  s_and1 <= s_posOut(7) and s_dirOut;
  s_and2 <= s_pos(1) and not(s_dirOut);
  s_xor  <= ext_change or s_and1 or s_and2;


-- soldering work
  dir : direction
    -- generic map (INIT => "000010000", WIDTH := 9); -- can i do : (5 => '1', others =>'0')?
    port map (change => s_xor,
              enable => enable,
              reset  => reset,
              clock  => clock
              dir    => s_dirOut);

  mov : movement
    port map (dir    => s_dirOut,
              enable => enable,
              reset  => reset,
              clock  => clock,
              pos    => s_posOut);

-- Linking to outputs

  pos   <= s_posOut;
  dir_o <= s_dirOut;

end architecture rtl;
