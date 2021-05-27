LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_control_nave IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   signal_16_m        :  IN    STD_LOGIC;
				max_tick           :  IN    STD_LOGIC;
				ena_write          :  OUT   STD_LOGIC;
				ena_count          :  OUT   STD_LOGIC;
				write_s            :  OUT   STD_LOGIC;
				syn_clr            :  OUT   STD_LOGIC;
				ena_Reg            :  OUT   STD_LOGIC);
END ENTITY fsm_control_nave;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_control_nave IS
	TYPE state IS (state_IDL, state_erase,state_wait,state_ang,state_wf,state_fill);
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
	PROCESS (pr_state,signal_16_m,max_tick)
		BEGIN
			CASE pr_state IS
				WHEN state_IDL =>
					ena_write<='0';
					ena_count<='0';
					write_s  <='0';
					syn_clr  <='0';
					ena_Reg  <='0';
				   IF(signal_16_m='1') THEN
						nx_state <= state_erase;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_erase =>
					ena_write<='1';
					ena_count<='1';
					write_s  <='0';
					syn_clr  <='0';
					ena_Reg  <='0';
					nx_state <= state_wait;				
		--------------------------------		
				WHEN state_wait =>
					ena_write<='1';
					ena_count<='0';
					write_s  <='0';
					syn_clr  <='0';
					ena_Reg  <='0';
				   IF(max_tick='1') THEN
						nx_state <= state_ang;				
					ELSE 
						nx_state <= state_erase;
					END IF;
		--------------------------------		
				WHEN state_ang =>
					ena_write<='0';
					ena_count<='1';
					write_s  <='0';
					syn_clr  <='1';
					ena_Reg  <='1';
					nx_state <= state_wf;		
		--------------------------------		
				WHEN state_wf =>
					ena_write<='1';
					ena_count<='0';
					write_s  <='1';
					syn_clr  <='0';
					ena_Reg  <='0';
				   IF(max_tick='1') THEN
						nx_state <= state_IDL;				
					ELSE 
						nx_state <= state_fill;
					END IF;
		--------------------------------			
				WHEN state_fill =>
					ena_write<='1';
					ena_count<='1';
					write_s  <='1';
					syn_clr  <='0';
					ena_Reg  <='0';
					nx_state <= state_wf;	
		--------------------------------	
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;