LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY fsm_asteroide IS
	PORT (	clk	           	 :	 IN    STD_LOGIC;
				rst		          :	 IN    STD_LOGIC; 
			   signal_16_m        :  IN    STD_LOGIC;
				perder             :  IN    STD_LOGIC;
				new_level          :  IN    STD_LOGIC;
		      max_tick_as        :  IN    STD_LOGIC;
				max_tick_24        :  IN    STD_LOGIC;
				chopper            :  IN    STD_LOGIC_VECTOR(23 DOWNTO 0);
				syn_asteroid       :  OUT   STD_LOGIC;
				ena_asteroid       :  OUT   STD_LOGIC;
				ena_write          :  OUT   STD_LOGIC;
				ena_reg_G          :  OUT   STD_LOGIC;
				ena_24             :  OUT   STD_LOGIC;
				syn_24             :  OUT   STD_LOGIC;
				numero             :  OUT   STD_LOGIC;
				ena_mover          :  OUT   STD_LOGIC;
				ena_mover_2        :  OUT   STD_LOGIC;
				signal_count       :  OUT   STD_LOGIC;
				ena_creacion       :  OUT   STD_LOGIC);
END ENTITY fsm_asteroide;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF fsm_asteroide IS
	TYPE state IS (state_IDL, state_syn,state_write,state_count,state_wait,state_gen,state_ge1,state_ang,state_pos,state_trig);
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
	PROCESS (pr_state,signal_16_m,perder,new_level,max_tick_as,max_tick_24,chopper)
		BEGIN
			CASE pr_state IS
		--------------------------------		
				WHEN state_IDL =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='0';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
				   IF(new_level='1') THEN
						nx_state <= state_syn;
					ELSE 
						nx_state <= state_IDL;
					END IF;
		--------------------------------		
				WHEN state_syn =>
					syn_asteroid       <='1';
					ena_asteroid       <='1';
					ena_write          <='1';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
					nx_state           <= state_write;
		---------------------------------
				WHEN state_write =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='1';
					ena_reg_G          <='1';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
				   IF(max_tick_as='0') THEN
						nx_state <= state_count;
					ELSE 
						nx_state <= state_wait;
					END IF;
		--------------------------------	
				WHEN state_count =>
					syn_asteroid       <='0';
					ena_asteroid       <='1';
					ena_write          <='1';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='1';
				   nx_state           <= state_write;
		--------------------------------	
				WHEN state_wait =>
					syn_asteroid       <='1';
					ena_asteroid       <='1';
					ena_write          <='0';
					ena_reg_G          <='0';
					ena_24             <='1';
					syn_24             <='1';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
				   IF(chopper /= "000000000000000000000000") THEN
						nx_state <= state_gen;
					ELSIF(perder='1') THEN 
						nx_state <= state_IDL;
					ELSE
					   IF(signal_16_m='1') THEN 
						   nx_state <= state_ang;
						ELSE 
						   nx_state <= state_wait;
						END IF;
					END IF;
		--------------------------------		
				WHEN state_gen =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='1';
					ena_reg_G          <='0';
					signal_count       <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='1';
					nx_state           <= state_ge1;
		--------------------------------			
				WHEN state_ge1 =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='1';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='1';
					ena_mover          <='0';
					ena_mover_2        <='0';
					ena_creacion       <='1';
					signal_count       <='0';
               nx_state           <= state_wait;
		--------------------------------		
				WHEN state_ang =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='0';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='1';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
					nx_state           <= state_trig;
		--------------------------------		
				WHEN state_trig =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='0';
					ena_reg_G          <='0';
					ena_24             <='0';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='1';
					ena_mover_2        <='0';
					ena_creacion       <='0';
					signal_count       <='0';
					nx_state           <= state_pos;
        --------------------------------
				WHEN state_pos =>
					syn_asteroid       <='0';
					ena_asteroid       <='0';
					ena_write          <='0';
					ena_reg_G          <='0';
					ena_24             <='1';
					syn_24             <='0';
					numero             <='0';
					ena_mover          <='0';
					ena_mover_2        <='1';
					ena_creacion       <='0';
					signal_count       <='0';
				   IF(max_tick_24='1') THEN
						nx_state <= state_wait;
					ELSE 
						nx_state <= state_ang;
					END IF;
		--------------------------------	
			END CASE;
		END PROCESS;		
-----------------------------------------------------------------------------------
						
END ARCHITECTURE rtl;