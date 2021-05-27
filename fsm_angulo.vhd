LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_angulo IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   signal_16_m        :  IN    STD_LOGIC;
				signal_XOR         :  IN    STD_LOGIC;
				ena_ang            :  OUT   STD_LOGIC);
END ENTITY fsm_angulo;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_angulo IS
	TYPE state IS (state_wait, state_cambio);
	SIGNAL pr_state, nx_state: state;
-------------------------------------------------------------------------------------
BEGIN
-----------------------------------------------------------------	
		PROCESS(rst,clk)
			BEGIN
				IF(rst='1') THEN
					   pr_state <= state_wait;
				ELSIF(rising_edge(clk)) THEN
						pr_state <= nx_state;
				END IF;
			END PROCESS;
-----------------------------------------------------------------------------------
	PROCESS (pr_state,signal_16_m,signal_XOR)
		BEGIN
			CASE pr_state IS
				WHEN state_wait =>
				   ena_ang <= '0';
				   IF(signal_16_m='1') THEN
						nx_state <= state_cambio;
					ELSE 
						nx_state <= state_wait;
					END IF;
		--------------------------------		
				WHEN state_cambio =>
               ena_ang <= '1';
				   IF(signal_XOR='1') THEN
						nx_state <= state_wait;				
					ELSE 
						nx_state <= state_cambio;
					END IF;
		--------------------------------			
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;