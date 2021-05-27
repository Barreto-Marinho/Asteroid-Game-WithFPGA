LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_velocidad IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
				signal_16_m        :	 IN    STD_LOGIC; 
				ena_pos            :  OUT   STD_LOGIC;
				ena_vel            :  OUT   STD_LOGIC;
				ready_pos          :  OUT   STD_LOGIC);
END ENTITY fsm_velocidad;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_velocidad IS
	TYPE state IS (state_IDL, state_w1,state_w2,state_vel,state_w3,state_pos);
	SIGNAL pr_state, nx_state: state;
-------------------------------------------------------------------------------------
BEGIN
-----------------------------------------------------------------	
		PROCESS(rst,clk)
			BEGIN
				IF(rst='1') THEN
					   pr_state <= state_IDL;
				ELSIF(rising_edge(clk)) THEN
						pr_state <= nx_state;
				END IF;
			END PROCESS;
-----------------------------------------------------------------------------------
	PROCESS (pr_state,signal_16_m)
		BEGIN
			CASE pr_state IS
				WHEN state_IDL =>
				   ena_pos  <= '0';
					ena_vel  <= '0';
					ready_pos<= '0'; 
				   IF(signal_16_m='1') THEN
						nx_state <= state_w1;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_w1 =>
				   ena_pos  <= '0';
					ena_vel  <= '0';
					ready_pos<= '0'; 
					nx_state <= state_w2;
		--------------------------------		
				WHEN state_w2 =>
				   ena_pos  <= '0';
					ena_vel  <= '0';
					ready_pos<= '0'; 
					nx_state <= state_vel;
		----------------//----------------	
				WHEN state_vel =>
				   ena_pos  <= '0';
					ena_vel  <= '1';
					ready_pos<= '0'; 
					nx_state <= state_w3;
		--------------------------------	
				WHEN state_w3 =>
				   ena_pos  <= '0';
					ena_vel  <= '0';
					ready_pos<= '0'; 
					nx_state <= state_pos;
		--------------------------------		
				WHEN state_pos =>
				   ena_pos  <= '1';
					ena_vel  <= '0';
					ready_pos<= '1'; 
					nx_state <= state_IDL;
		--------------------------------		
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;