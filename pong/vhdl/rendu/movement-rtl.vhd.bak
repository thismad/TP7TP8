architecture rtl of movement is

  signal s_next_state    : std_logic_vector (WIDTH-1 downto 0);
  signal s_current_state : std_logic_vector (WIDTH-1 downto 0);



begin


  pos <= s_current_state;

--logic update medevedev FSM
  LogicUpdate : process (enable, dir, s_current_state)
  begin
    if (s_current_state(0) = '1') then
      if(dir = '1') then s_next_state <=  s_current_state(width-2 downto 0) & '0';
      end if;
    elsif (s_current_state(width-1) = '1') then
      if(dir = '0') then s_next_state <= '0' & s_current_state(width-1 downto 1);
      end if;
    else
      if(dir = '0') then
        s_next_state <= '0' & s_current_state(width-1 downto 1);
      else
        s_next_state <=  s_current_state(width-2 downto 0) & '0';
      end if;
    end if;
  end process LogicUpdate;

  FlipFlop : process (clock, enable, s_next_state,reset)
  begin
    if(rising_edge(clock)) then
    if(reset = '1') then s_current_state <= INIT;
 
                           elsif(enable = '1') then s_current_state <= s_next_state;
                           end if;
									
    end if;
  end process;
end rtl;
