LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_chopper IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   signal_16_m        :  IN    STD_LOGIC;
				chopper_sign       :  IN    STD_LOGIC;
				perder_sign        :  IN    STD_LOGIC;
				ena_perder         :  OUT   STD_LOGIC;
				ena_chopper        :  OUT   STD_LOGIC);
END ENTITY fsm_chopper;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_chopper IS
	TYPE state IS (state_idl,state_wait, state_chopper,state_perder,state_c2,state_c3);
	SIGNAL pr_state, nx_state: state;
-------------------------------------------------------------------------------------
BEGIN
-----------------------------------------------------------------	
		PROCESS(rst,clk)
			BEGIN
				IF(rst='1') THEN
					   pr_state <= state_idl;
				ELSIF(rising_edge(clk)) THEN
						pr_state <= nx_state;
				END IF;
			END PROCESS;
-----------------------------------------------------------------------------------
	PROCESS (pr_state,signal_16_m,chopper_sign,perder_sign)
		BEGIN
			CASE pr_state IS
		--------------------------------
				WHEN state_idl =>
				   ena_perder <= '0';
					ena_chopper <= '0';
				   IF(signal_16_m='1') THEN
						nx_state <= state_wait;
					ELSE 
						nx_state <= state_idl;
					END IF;
		--------------------------------		
				WHEN state_wait =>
				   ena_perder <= '0';
					ena_chopper <= '0';
				   IF(chopper_sign='1') THEN
						nx_state <= state_chopper;				
					ELSIF(perder_sign='1') THEN
						nx_state <= state_perder;
					ELSE 
					   nx_state <= state_wait;
					END IF;
		--------------------------------		
				WHEN state_chopper =>
				   ena_perder  <= '0';
					ena_chopper <= '1';
					nx_state <= state_c2;
		--------------------------------
				WHEN state_c2 =>
				   ena_perder  <= '0';
					ena_chopper <= '1';
					nx_state <= state_c3;
		--------------------------------
				WHEN state_c3 =>
				   ena_perder  <= '0';
					ena_chopper <= '1';
					nx_state <= state_idl;
		--------------------------------
				WHEN state_perder =>
				   ena_perder  <= '1';
					ena_chopper <= '0';
					nx_state <= state_idl;
		--------------------------------
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;