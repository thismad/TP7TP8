architecture rtl of movement_full is

  component direction
    port (clock, change, enable, reset : in  std_logic;
          dir                          : out std_logic);
  end component direction;

  component movement
	generic (width : natural; INIT : std_logic_vector);
    port(dir,ext_change, enable, reset, clock : in  std_logic;
         pos                       : out std_logic_vector);
  end component movement;

  signal s_and1   : std_logic;
  signal s_and2   : std_logic;
  signal s_xor    : std_logic;
  signal s_dirOut : std_logic;
  signal s_posOut : std_logic_vector (WIDTH-1 downto 0);
  signal s_ext_changed : std_logic;
  

begin
  -- GATES

  s_and1 <= s_posOut(width-2) and s_dirOut;
  s_and2 <= s_posOut(1) and not(s_dirOut);
  s_xor  <= (ext_change and s_posOut(width-3)) or s_and1 or s_and2; -- si on est a gauche de la bat alors la direction change sinon non. La dir est deja loaded en avance dans le movement donc on le fait changer en temps reel car le prochain mov est deja calculé anyway
  s_ext_changed <= not(s_dirOut) when (ext_change = '1' and s_posOut(width-1) ='0') else --permet un changement en bypassant la dir si collision avec bat et qu'on est pas derriere la bat
						s_dirOut;

 
-- soldering work
  dir : direction
    -- generic map (INIT => "000010000", WIDTH := 9); -- can i do : (5 => '1', others =>'0')?
    port map (change => s_xor,
              enable => enable,
              reset  => reset,
              clock  => clock,
              dir    => s_dirOut);

  mov : movement
generic map (width => width, INIT => INIT)
    port map (dir    => s_ext_changed,
	 ext_change => ext_change,
              enable => enable,
              reset  => reset,
              clock  => clock,
              pos    => s_posOut);

-- Linking to outputs

  pos   <= s_posOut;
  dir_o <= s_dirOut;

end architecture rtl;
