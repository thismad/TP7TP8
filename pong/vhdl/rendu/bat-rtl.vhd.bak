architecture rtl of bat is
  signal   s_current_state : std_logic_vector(8 downto 0);
  signal   s_next_state : std_logic_vector(8 downto 0);
  constant c_INIT : std_logic_vector := "000111000";
  constant c_down : std_logic_vector := "000000111";
  constant c_up : std_logic_vector   := "111000000";

begin

  --LogicUpdate

  LogicUpdate : process (clock, reset, s_next_state, s_current_state, button_up, button_down)
  begin
    if(button_up = '1' and s_current_state /= c_up) then
      s_next_state <= s_current_state(7 downto 0) & '0';
    elsif (button_down = '1' and s_current_state /= c_down) then
      s_next_state <= '0' & s_current_state(8 downto 1);
else s_next_state <= s_current_state;
end if;
end process;

  FlipFlop : process(clock, reset, s_next_state, s_current_state)
  begin
    if(rising_edge(clock)) then
      if(reset = '1')then 
       s_current_state <= c_INIT;
      elsif (enable = '1') then s_current_state <= s_next_state;
      end if;
    end if;
  end process;

  bat_o <= s_current_state;

end architecture rtl;
