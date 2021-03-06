architecture rtl of collision is

 
  constant x_bat_right : std_logic_vector := "100000000000";  -- pos x of the bat with a -1
  constant x_bat_left  : std_logic_vector := "001000000000"; 
  constant c_compared : std_logic_vector(8 downto 0) := (others => '0');
  signal   s_next_y    : std_logic_vector (8 downto 0);
  signal s_next_x : std_logic_vector (11 downto 0);

begin

  compare : process (x_pos, y_pos, s_next_y,x_dir,y_dir)
begin
    if (x_pos = x_bat_right) then
      if (x_dir = '0' and y_dir = '0') then    --bas a gauche
        s_next_y <= '0' & y_pos(8 downto 1);
      elsif(x_dir = '0' and y_dir = '1') then  -- haut gauche
        s_next_y <= y_pos(7 downto 0) & '0';
		  else
		  s_next_y <= "000000000" ;
      end if;
    elsif (x_pos = x_bat_left) then
      if (x_dir = '1' and y_dir = '0') then     --droite haut
        s_next_y <='0' & y_pos(8 downto 1);
      elsif (x_dir = '1' and y_dir = '1') then  --droite bas
        s_next_y <= y_pos(7 downto 0) & '0';
		  else s_next_y <= "000000000" ;
      end if;
		else s_next_y <= "000000000" ;--pour pas que la condition soit vraie et ca change alors qu'on est en etat 2
    end if;
  end process;


  tryout : process (x_pos, y_pos)
  begin
    if((s_next_y and bat_pos) /= c_compared and (x_bat_left = x_pos or x_bat_right = x_pos)) then
      change <= '1';
    else
      change <= '0';
    end if;
  end process;

end architecture rtl;
