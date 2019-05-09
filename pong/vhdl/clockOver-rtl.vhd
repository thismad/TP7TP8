ARCHITECTURE no_target_specific OF clockOver IS

   CONSTANT c_reload_value : unsigned( 18 DOWNTO 0 ) :=
               to_unsigned(300000,19);
   -- The above constant represents (25000000 - 1) which corresponds to
   -- the divider value required for a 50 MHz clock to generate an enable pulse
   -- at a frequency of 2 Hz. We have to deduct 1 above, as "0" is also a valid
   -- value, and the interpretation used for this constant is binairy.
   SIGNAL s_current_state  : unsigned( 18 DOWNTO 0 ) := c_reload_value;
   SIGNAL s_next_state     : unsigned( 18 DOWNTO 0 );

BEGIN

   -----------------------------------------------------------------------------
   --- Here the update logic of the FSM of type Moore is described:          ---
   -----------------------------------------------------------------------------
   s_next_state <= c_reload_value WHEN s_current_state = to_unsigned(0,18) ELSE
                   s_current_state - 1;
   -- Question: What is the hardware that is described in the above implicit
   --           process?
   -- **** The described hardware is a substracter
   -----------------------------------------------------------------------------
   --- Here the state logic of the FSM of type Moore is described:           ---
   -----------------------------------------------------------------------------
   make_state : PROCESS( clock , reset , s_next_state )
   BEGIN
      IF (rising_edge(clock)) THEN
         IF (reset = '1') THEN s_current_state <= (OTHERS => '0');
                          ELSE s_current_state <= s_next_state;
         END IF;
      END IF;
   END PROCESS make_state;
   -- Question: What is the hardware that is described in the above explicit
   --           process, and is the reset synchronous or asynchronous?
   -- **** it is synchronous and its a D flip flop
   -----------------------------------------------------------------------------
   --- Here the output logic of the FSM of type Moore is described:          ---
   -----------------------------------------------------------------------------
   enable <= '1' WHEN s_current_state = to_unsigned(1,20) ELSE '0';
   -- Question: What is the hardware that is described in the above implicit
   --           process?
   -- **** La retenue dans le calcul
END no_target_specific;
