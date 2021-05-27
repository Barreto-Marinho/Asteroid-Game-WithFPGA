LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_general IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   signal_16_m        :  IN    STD_LOGIC;
				espacio            :  IN    STD_LOGIC;
				perder             :  IN    STD_LOGIC; 
		      ganar         		 :  IN    STD_LOGIC; 
				reiniciar          :  OUT   STD_LOGIC;
				ena_intro          :  OUT   STD_LOGIC;
				new_level          :  OUT   STD_LOGIC; 
				juego              :  OUT   STD_LOGIC; 
				pantalla_ganar     :  OUT   STD_LOGIC; 
				respawn            :  OUT   STD_LOGIC; 
				pantalla_perder    :  OUT   STD_LOGIC;
				counter_cora       :  OUT   STD_LOGIC_VECTOR(1 DOWNTO 0);  
				counter_nivel      :  OUT   STD_LOGIC_VECTOR(1 DOWNTO 0) 
				);
END ENTITY fsm_general;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_general IS
	TYPE state IS (state_intro, state_begin,state_juego,state_corazon,state_respawn,
	               state_perder,state_wait,state_new,state_nivel,state_ganar);
	SIGNAL pr_state, nx_state: state;
	
	SIGNAL max_tick_cor  ,ena_cor  ,syn_clr_cor : STD_LOGIC;
	SIGNAL max_tick_nivel,ena_nivel,syn_clr_niv : STD_LOGIC;
-------------------------------------------------------------------------------------
BEGIN
-----------------------------------------------------------------	
		PROCESS(rst,clk)
			BEGIN
				IF(rst='1') THEN
					   pr_state <= state_intro;
				ELSIF(rising_edge(clk)) THEN
						pr_state <= nx_state;
				END IF;
			END PROCESS;
-----------------------------------------------------------------------------------
	PROCESS (pr_state,signal_16_m,max_tick_cor,max_tick_nivel,espacio,perder,ganar)
		BEGIN
			CASE pr_state IS
				WHEN state_intro =>
					ena_intro      <= '1';
					ena_nivel      <= '1';   
					syn_clr_niv    <= '1';  
					ena_cor        <= '1';     
					syn_clr_cor    <= '1';   
					new_level      <= '0';   
					juego          <= '0';     
					pantalla_ganar <= '0';       
					respawn        <= '0';  
					pantalla_perder<= '0';   
					reiniciar      <= '0';
				   IF(espacio='1') THEN
						nx_state <= state_begin;
					ELSE 
						nx_state <= state_intro;
					END IF;
		--------------------------------		
				WHEN state_begin =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';   
					juego          <= '0';     
					pantalla_ganar <= '0';     
					new_level      <= '1';    
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
					nx_state       <= state_juego;				
		--------------------------------		
				WHEN state_juego =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';      
					juego          <= '1';     
					pantalla_ganar <= '0';     
					new_level      <= '0';    
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
				   IF(perder='1') THEN
						nx_state <= state_corazon;				
					ELSIF(ganar='1') THEN
						nx_state <= state_nivel;
					ELSE
					   nx_state <= state_juego;
					END IF;
		--------------------------------		
				WHEN state_nivel =>
					ena_intro      <= '0';
					ena_nivel      <= '1';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';    
					juego          <= '1';     
					pantalla_ganar <= '0';     
					new_level      <= '0';    
					respawn        <= '0';  
					pantalla_perder<= '0'; 
				   reiniciar      <= '1';	
				   IF(max_tick_nivel='1') THEN
						nx_state <= state_ganar;				
					ELSE
					   nx_state <= state_new;
					END IF;	
		--------------------------------		
				WHEN state_ganar =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';    
					juego          <= '0';     
					pantalla_ganar <= '1';     
					new_level      <= '0';    
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
					IF(espacio='1') THEN
						nx_state <= state_wait;
					ELSE 
						nx_state <= state_ganar;
					END IF;			
		--------------------------------			
				WHEN state_new =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';   
					new_level      <= '1';   
					juego          <= '1';     
					pantalla_ganar <= '0';     
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
					nx_state       <= state_juego;		
		--------------------------------	
				WHEN state_corazon =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '1';     
					syn_clr_cor    <= '0';   
					new_level      <= '0';   
					juego          <= '1';     
					pantalla_ganar <= '0';         
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
				   IF(max_tick_cor='1') THEN
						nx_state <= state_perder;				
					ELSE
					   nx_state <= state_respawn;
					END IF;	
			--------------------------------
				WHEN state_respawn =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';   
					new_level      <= '0';   
					juego          <= '1';     
					pantalla_ganar <= '0';       
					respawn        <= '1';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
					nx_state       <= state_juego;		
		--------------------------------	
				WHEN state_perder =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';   
					new_level      <= '0';   
					juego          <= '0';     
					pantalla_ganar <= '0';      
					respawn        <= '0';  
					pantalla_perder<= '1';  
					reiniciar      <= '1';
					IF(espacio='1') THEN
						nx_state <= state_wait;
					ELSE 
						nx_state <= state_perder;
					END IF;
		--------------------------------	
				WHEN state_wait =>
					ena_intro      <= '0';
					ena_nivel      <= '0';   
					syn_clr_niv    <= '0';  
					ena_cor        <= '0';     
					syn_clr_cor    <= '0';     
					juego          <= '0';     
					pantalla_ganar <= '0';     
					new_level      <= '0';    
					respawn        <= '0';  
					pantalla_perder<= '0';  
					reiniciar      <= '0';
				   IF(signal_16_m='1') THEN
						nx_state <= state_intro;				
					ELSE
					   nx_state <= state_wait;
					END IF;		
		--------------------------------	
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
	cont_cor:ENTITY work.contador_uni
	GENERIC MAP(N => 2)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_cor,
				  ini      => "00",
				  ena      => ena_cor,
				  max      => "10",
				  counter  => counter_cora,
				  max_tick => max_tick_cor);
-----------------------------------------------------------------------------------
	cont_nivel:ENTITY work.contador_uni
	GENERIC MAP(N => 2)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_niv,
				  ini      => "00",
				  ena      => ena_nivel,
				  max      => "10",
				  counter  => counter_nivel,
				  max_tick => max_tick_nivel);
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;