LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_vsyn IS
	GENERIC ( N			          :	INTEGER	:=10);
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
				strobe             :	 IN    STD_LOGIC; 
			   MaxTick_h          :  IN    STD_LOGIC;
				ena_cont_h         :  OUT   STD_LOGIC;
				syn_h              :  OUT   STD_LOGIC;
				vsyn               :  OUT   STD_LOGIC;  
				Max_h              :  OUT   STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY fsm_vsyn;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_vsyn IS
	TYPE state IS (state_IDL, state_1,state_es,state_syn);
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
	PROCESS (pr_state,MaxTick_h,rst,strobe)
		BEGIN
			CASE pr_state IS
				WHEN state_IDL =>
				   ena_cont_h <= '0';
					syn_h      <= '1';
					vsyn       <= '0'; 
					Max_h      <= "1000001011";
				   IF(strobe='1') THEN
						nx_state <= state_1;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_1 =>
				   ena_cont_h <= '1';
					syn_h      <= '0';
					vsyn       <= '1'; 
					Max_h      <= "1000001011";
				   IF(MaxTick_h='1') THEN
						nx_state <= state_syn;
					ELSIF(rst='1') THEN 
						nx_state <= state_IDL;					
					ELSE 
						nx_state <= state_1;
					END IF;
		--------------------------------		
				WHEN state_es =>
				   ena_cont_h <= '1';
					syn_h      <= '0';
					vsyn       <= '0'; 
					Max_h      <= "0000000010";
				   IF(MaxTick_h='1') THEN
						nx_state <= state_1;
					ELSIF(rst='1') THEN 
						nx_state <= state_IDL;					
					ELSE 
						nx_state <= state_es;
					END IF;		
		--------------------------------		
				WHEN state_syn =>
				   ena_cont_h <= '1';
					syn_h      <= '1';
					vsyn       <= '0'; 
					Max_h      <= "0000000010";
					IF(rst='1') THEN 
						nx_state <= state_IDL;					
					ELSE 
						nx_state <= state_es;
					END IF;		
		--------------------------------			
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;