architecture rtl of direction is
  signal s_current_state : std_logic;
  signal s_next_state    : std_logic;

begin

  s_next_state <= '1' when (change = '1' and s_current_state = '0')  else
                  '0' when (change = '1' and s_current_state = '1');
		   

dir <= s_current_state;
  FlipFlop : process (clock)
begin 
if(reset = '1') then s_current_state <= '1';
end if;
    if(rising_edge(clock)) then
      if (enable = '1') then 
       s_current_state <= s_next_state;
		end if;
    end if;
  end process FlipFlop;
end architecture rtl;
