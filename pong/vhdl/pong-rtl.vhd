architecture rtl of pong is
  component movement_full
    port (ext_change, enable, reset, clock : in  std_logic;
          pos                              : out std_logic_vector(width-1 downto 0);
          dir_o                            : out std_logic);
  end component;

  component clock_divider
    port (clock  : in  std_logic;
          reset  : in  std_logic;
          enable : out std_logic);
  end component;

  component score
    port(x_pos  : in  std_logic_vector(11 downto 0);
         enable : in  std_logic;
         reset  : in  std_logic;
         clock  : in  std_logic;
         user   : out std_logic_vector(7 downto 0);  --player score
         sys    : out std_logic_vector(7 downto 0);  --system score
         over   : out std_logic);
  end component;

  component bat
    port(button_up   : in  std_logic;
         button_down : in  std_logic;
         enable      : in  std_logic;
         reset       : in  std_logic;
         clock       : in  std_logic;
         bat_o       : out std_logic_vector(8 downto 0));
  end component;



  signal s_enable        : std_logic;
  signal Y_pos           : std_logic_vector (8 downto 0);
  signal X_pos           : std_logic_vector (11 downto 0);
  signal s_over          : std_logic;
  signal s_button_up     : std_logic;
  signal s_button_down   : std_logic;
  signal s_button_up_o   : std_logic;
  signal s_button_down_o : std_logic;
  signal s_reset         : std_logic;
  signal s_bat_o         : std_logic_vector(8 downto 0));



begin
  s_reset       <= not(n_reset);
  s_button_up   <= not(n_button_up);
  s_button_down <= not(n_button_down);

  clock_div : clock_divider
    port map (clock  => clock,
              reset  => s_reset,
              enable => s_enable);

  movement_y : movement_full
    generic map (INIT = "000010000");
  port map (enable => s_enable,
            reset  => s_reset,
            clock  => clock
            pos    => Y_pos);


  movement_x : movement_full
    generic map (width := 12, INIT := "0000000100000")
    port map (enable => s_enable,
              reset  => s_reset,
              clock  => clock
              pos    => X_pos);

  bat : bat
    port map (s_button_up_o, s_button_down_o, s_enable, reset, clock, s_bat_o);

  score : score
    port map(X_pos, s_enable, reset, clock, user, sys, s_open);

  debouncer_up : debouncer
    port map (s_button_up, s_enable, s_reset, clock, s_button_up_o);

  debouncer_down : debouncer
    port map (s_button_down, s_enable, s_reset, clock, s_button_down_o);

  display : for y in 8 downto 0 generate
    oneline for x in 11 downto 0 generate
              playfield(y*12+x) <= Y_pos(y) and X_pos(x);
            end generate oneline;
  end generate display;



end architecture rtl;
