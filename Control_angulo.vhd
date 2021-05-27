LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Control_angulo IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 sel_angulo  :  IN    STD_LOGIC;
				 signal_16_m :  IN    STD_LOGIC;
				 derecha_b   :  IN    STD_LOGIC;
				 izquierda_b :  IN    STD_LOGIC;
				 sen_angulo  :  OUT    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 cos_angulo  :  OUT    STD_LOGIC_VECTOR(11 DOWNTO 0)
				);
END ENTITY Control_angulo;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Control_angulo IS	
	SIGNAL up, ena, signal_XOR  : STD_LOGIC;
	SIGNAL ena_ang 				: STD_LOGIC;
	SIGNAL counter					: STD_LOGIC_VECTOR (5 DOWNTO 0);
BEGIN
	
	
				  
	up			 <= izquierda_b;
	signal_XOR <= izquierda_b XOR derecha_b;
	ena       <= (signal_XOR AND ena_ang) OR sel_angulo;
				  
	cont_memo:ENTITY work.contador_updown
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => up,
				  syn_clr  => sel_angulo,
				  ini      => "000000",--001111
				  ena      => ena,
				  max      => "111011",
				  counter  => counter);			  

	fsm:ENTITY work.fsm_angulo
	PORT MAP ( clk     		 => clk,
				  rst      		 => rst,
				  signal_16_m   => signal_16_m,
				  signal_XOR  	 => signal_XOR,
				  ena_ang  	    => ena_ang);		
	
	memo_sen:ENTITY work.Memoria_seno
	GENERIC MAP(DATA_WIDTH => 12,
					ADDR_WIDTH => 6)
	PORT MAP ( clk      => clk,
				  addr     =>counter,
				  r_data   =>sen_angulo);
	
	memo_cos:ENTITY work.Memoria_coseno
	GENERIC MAP(DATA_WIDTH => 12,
					ADDR_WIDTH => 6)
	PORT MAP ( clk      => clk,
				  addr     =>counter,
				  r_data   =>cos_angulo);
				  

		

END ARCHITECTURE rtl;