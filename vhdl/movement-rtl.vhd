architecture rtl of movement is
   constant c_final_right : std_logic_vector (WIDTH-1 downto 0) := (width-1 => '1', others => '0');
   constant c_final_left : std_logic_vector (WIDTH-1 downto 0) := (0 => '1', others => '0');
                                                                  signal s_next_state : std_logic_vector (WIDTH-1 downto 0);
  signal s_current_state : std_logic_vector (WIDTH-1 downto 0);


begin


--logic update medevedev FSM
  LogicUpdate : process (enable, dir, s_current_state)
  begin
    case s_current_state is
      when c_final_left => if(dir = '1') then s_next_state <= s_current_state & '0';
                           end if;
      when c_final_right => if(dir = '0') then s_next_state <= '0' & s_current_state;
                            end if;
      when others => if(dir = '1') then
                       s_next_state <= s_current_state & '0';
                       elseif (dir = '1') then
                         s_next_state <= '0' & s_current_state;
                       end if;
    end case;
  end process LogicUpdate;

  FlipFlop : process (clock, s_next_state)
  begin
    if(rising_edge(clock)) then
      if(reset = '1') then s_current_state <= INIT;
    elsif (enable = '1') s_current_state                 <= s_next_state;  --enable = '1' ou risingedge?
      end if;
    end if;
  end process;
end rtl;
