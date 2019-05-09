architecture rtl of score is

  constant c0 : std_logic_vector := "11111100";
  constant c1 : std_logic_vector := "01100000";
  constant c2 : std_logic_vector := "11011010";
  constant c3 : std_logic_vector := "11110010";
  constant c4 : std_logic_vector := "01100110";
  constant c5 : std_logic_vector := "10110110";
  constant c6 : std_logic_vector := "10111110";
  constant c7 : std_logic_vector := "11100000";
  constant c8 : std_logic_vector := "11111110";
  constant c9 : std_logic_vector := "11110110";
  constant INVALID : std_logic_vector := "11111111";

  signal s_scoreU, s_next_scoreU, s_scoreS, s_next_scoreS : std_logic_vector (7 downto 0);

begin
  --LogicUpdate

  LogicUpdate : process (enable, clock, X_pos,s_scoreS)
  begin
    if(enable = '1') then
      if X_pos = ("000000000001") then  -- gauche
        case s_scoreU is
          when c0 => s_next_scoreU <= c1;
        when c1 => s_next_scoreU <= c2;
        when c2 => s_next_ScoreU <= c3;
        when c3 => s_next_ScoreU <= c4;
        when c4 => s_next_ScoreU <= c5;
        when c5 => s_next_scoreU <= c6;
        when c6 => s_next_ScoreU <= c7;
        when c7 => s_next_ScoreU <= c8;
        when c8 => s_next_ScoreU <= c9;
        when c9 => s_next_ScoreU <= c9;
	when others => s_next_ScoreU <= INVALID;
      end case;

      elsif X_pos = ("100000000000") then
        case s_scoreS is
          when c0 => s_next_scoreS <= c1;
        when c1 => s_next_scoreS <= c2;
        when c2 => s_next_ScoreS <= c3;
        when c3 => s_next_ScoreS <= c4;
        when c4 => s_next_ScoreS <= c5;
        when c5 => s_next_scoreS <= c6;
        when c6 => s_next_ScoreS <= c7;
        when c7 => s_next_ScoreS <= c8;
        when c8 => s_next_ScoreS <= c9;
        when c9 => s_next_ScoreS <= c9;
	when others => s_next_ScoreS <= INVALID;
      end case;
		else s_next_scoreS <= s_scoreS;
	 s_next_scoreU <= s_scoreU;
      end if;
		
    end if;
  end process;
  --FlipFlop

  FlipFlop_scoreU : process (enable, clock , s_scoreU, s_next_ScoreU)
  begin
    if(rising_edge(clock)) then
      if (reset = '1') then s_scoreU <= c0;
      elsif (enable = '1') then s_scoreU  <= s_next_ScoreU;
    end if;
  end if;
end process;

FlipFlop_scoreS : process (enable, clock , s_next_ScoreS, s_scoreS)
begin
  if(rising_edge(clock)) then
    if (reset = '1') then s_scoreS <= c0;
    elsif (enable = '1') then s_scoreS  <= s_next_ScoreS;
  end if;
end if;
end process;

--assigning values to outputs

over <= '1' when s_scoreS = c9 or s_scoreU = c9 else
        '0';

user <= s_scoreU;
sys  <= s_scoreS;


end architecture rtl;
