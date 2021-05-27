LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_disparos IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   espacio            :  IN    STD_LOGIC;
				max_tick           :  IN    STD_LOGIC;
				ena_creacion       :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				ena_bola           :  OUT   STD_LOGIC;
				ena_count          :  OUT   STD_LOGIC;
				syn_clr            :  OUT   STD_LOGIC);
END ENTITY fsm_disparos;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_disparos IS
	TYPE state IS (state_IDL, state_bola,state_count);
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
	PROCESS (pr_state,espacio,ena_creacion,max_tick)
		BEGIN
			CASE pr_state IS
				WHEN state_IDL =>
					ena_bola <='0';
					ena_count<='1';
					syn_clr  <='1';
				   IF(espacio='1') THEN
						nx_state <= state_bola;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_bola =>
					ena_bola <='1';
					ena_count<='1';
					syn_clr  <='1';
				   IF(ena_creacion(0)='1' OR ena_creacion(1)='1' OR ena_creacion(2)='1') THEN
						nx_state <= state_count;
					ELSE 
						nx_state <= state_IDL;
					END IF;			
		--------------------------------		
				WHEN state_count =>
					ena_bola <='0';
					ena_count<='1';
					syn_clr  <='0';
				   IF(max_tick='1') THEN
						nx_state <= state_IDL;				
					ELSE 
						nx_state <= state_count;
					END IF;
		--------------------------------		
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;