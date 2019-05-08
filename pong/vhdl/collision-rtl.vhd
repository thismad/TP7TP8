architecture rtl of collision is

  signal   s_change    : std_logic;
  constant x_bat_right : std_logic_vector := "000000000100";  -- pos x of the bat with a -1
  constant x_bat_left  : std_logic_vector := "000000000001";
  signal   s_next_x    : std_logic_vector (11 downto 0);
  signal   s_next_y    : std_logic_vector (8 downto 0);

begin

  compare : process ()

    if (x_pos = x_bat_right) then

      if (x_dir = '0' and y_dir = '0') then    --bas a gauche
        s_next_y <= y_pos(8 downto 1) & '0';
      elsif(x_dir = '0' and y_dir = '1') then  -- haut gauche
        s_next_y <= '0' & y_pos(7 downto 0);
      end if;
    elsif (x_pos = x_bat_left) then

      if (x_dir = '1' and y_dir = '0') then     --droite haut
        s_next_y <= y_pos(8 downto 1) & '0';
      elsif (x_dir = '1' and y_dir = '1') then  --droite bas
        s_next_y <= '0' & y_pos(7 downto 0);
      end if;
    end if;
  end process;


  tryout : process (s_next_x, s_next_y)
  begin
    if((s_next_y and bat_pos) /= (others => '0')) then
      change <= '1';
    else
      change <= '0';
    end if;
  end process;

end architecture rtl;
