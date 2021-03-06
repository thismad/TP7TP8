architecture rtl of debouncer is
  signal s_or       : std_logic;
  signal s_one      : std_logic;
  signal s_two      : std_logic;
  signal s_three    : std_logic;
  signal s_four     : std_logic;
  signal s_button_o : std_logic;
  signal s_or2 : std_logic;

begin
  s_or <= enable or reset;

  FlipFlop1 : process (clock)
  begin
    if rising_edge(clock) then
      s_one <= button;
    end if;
  end process;

  FlipFlop2 : process(clock)
  begin
    if rising_edge(clock) then
      s_two <= s_one;
    end if;
  end process;

  FlipFlop3 : process (clock)
  begin
    if rising_edge(clock) then
      s_three <= s_two;
    end if;
  end process;

  FlipFlop4 : process (clock)
  begin
    if rising_edge(clock) then
      s_button_o <= s_four;
    end if;
  end process;

s_or2 <= (not(s_three) and s_two) or s_button_o;
  s_four   <= s_or2 and not(s_or);
  button_o <= s_button_o;


end architecture rtl;
