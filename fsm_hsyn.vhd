LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_hsyn IS
	GENERIC ( N			          :	INTEGER	:=11);
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
				strobe             :	 IN    STD_LOGIC; 
			   MaxTick_px         :  IN    STD_LOGIC;
				ena_cont           :  OUT   STD_LOGIC;
				syn                :  OUT   STD_LOGIC;
				hsyn               :  OUT   STD_LOGIC;  
				Max                :  OUT   STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY fsm_hsyn;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_hsyn IS
	TYPE state IS (state_IDL, state_1,state_es);
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
	PROCESS (pr_state,MaxTick_px,rst,strobe)
		BEGIN
			CASE pr_state IS
				WHEN state_IDL =>
				   ena_cont <= '0';
					syn      <= '1';
					hsyn     <= '0'; 
					Max      <= "10101111111";
				   IF(strobe='1') THEN
						nx_state <= state_1;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_1 =>
				   ena_cont <= '1';
					syn      <= '0';
					hsyn     <= '1'; 
					Max      <= "10101111111";
				   IF(MaxTick_px='1') THEN
						nx_state <= state_es;
					ELSIF(rst='1') THEN 
						nx_state <= state_IDL;					
					ELSE 
						nx_state <= state_1;
					END IF;
		--------------------------------		
				WHEN state_es =>
				   ena_cont <= '1';
					syn      <= '0';
					hsyn     <= '0'; 
					Max      <= "00011000000";
				   IF(MaxTick_px='1') THEN
						nx_state <= state_1;
					ELSIF(rst='1') THEN 
						nx_state <= state_IDL;					
					ELSE 
						nx_state <= state_es;
					END IF;				
		--------------------------------			
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;