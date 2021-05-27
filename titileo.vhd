LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY titileo IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 perder      :  IN    STD_LOGIC;
				 invi        :  IN    STD_LOGIC;
				 invencible  :  OUT   STD_LOGIC;
				 titi        :  OUT   STD_LOGIC
				);
END ENTITY titileo;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF titileo IS	
	TYPE state IS (state_idl, state_inv);
	SIGNAL pr_state, nx_state: state;
	SIGNAL max_tick, q , q_neg,max_tick_2 ,ena ,syn_clr, invencible_aux			: STD_LOGIC;

BEGIN
	
	invencible<= invencible_aux OR invi;
	
-----------------------------------------------------------------	
		PROCESS(rst,clk)
			BEGIN
				IF(rst='1') THEN
					   pr_state <= state_idl;
				ELSIF(rising_edge(clk)) THEN
						pr_state <= nx_state;
				END IF;
			END PROCESS;
-----------------------------------------------------------------
	PROCESS (pr_state,perder,max_tick_2)
		BEGIN
			CASE pr_state IS
		--------------------------------
				WHEN state_idl =>
				   invencible_aux <= '0';
					syn_clr    <= '1';
				   IF(perder='1') THEN
						nx_state <= state_inv;
					ELSE 
						nx_state <= state_idl;
					END IF;
		--------------------------------		
				WHEN state_inv =>
				   invencible_aux <= '1';
					syn_clr    <= '0';
				   IF(max_tick_2='1') THEN
						nx_state <= state_idl;
					ELSE 
						nx_state <= state_inv;
					END IF;
		--------------------------------
			END CASE;
		END PROCESS;		
----------------------------------------------------------------------------------

	cont:ENTITY work.contador_uni
	GENERIC MAP(N => 25)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => '0',
				  ini      => "0000000000000000000000000",
				  ena      => '1',
				  max      => "1011111010111100001000000",
				  max_tick => max_tick);
				  	
-----------------------------------------------------------------------------------
	ena<= max_tick OR syn_clr;

	cont_2:ENTITY work.contador_uni
	GENERIC MAP(N => 4)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr,
				  ini      => "0000",
				  ena      => ena,
				  max      => "1010",
				  max_tick => max_tick_2);
				  				  
-------------------------------------------------------------------------------
	q_neg<= NOT q;

	titi<= q;
	
	osc:ENTITY work.my_dff
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  en    => max_tick,
				  d     => q_neg,
				  q     => q);	
		

END ARCHITECTURE rtl;