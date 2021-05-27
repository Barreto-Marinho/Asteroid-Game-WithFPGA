LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------------
ENTITY control_chopper IS
	PORT (  clk               :  IN    STD_LOGIC;
			  rst               :  IN    STD_LOGIC;
			  signal_16_m       :  IN    STD_LOGIC;
			  nave    			  :  IN    STD_LOGIC;
			  invencible        :  IN    STD_LOGIC;
			  bola       		  :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
			  asteroide   		  :  IN    STD_LOGIC_VECTOR(23 DOWNTO 0);
			  perder            :  OUT   STD_LOGIC;
			  choque_bola       :  OUT   STD_LOGIC_VECTOR(2 DOWNTO 0);
			  chopper           :  OUT   STD_LOGIC_VECTOR(23 DOWNTO 0)
		);
END ENTITY control_chopper;
-------------------------------------------------------------------------------------
ARCHITECTURE rtl OF control_chopper IS
SIGNAL perder_sign, chopper_sign,ena_perder,ena_chopper, ena_bola,ena_chopper_2   :STD_LOGIC;
SIGNAL asteroide_reg :STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL bola_reg 		:STD_LOGIC_VECTOR(2 DOWNTO 0);

-------------------------------------------------------------------------------------
BEGIN
	ena_chopper_2<= '1' WHEN asteroide/= "000000000000000000000000" ELSE
					   '0';

	ena_bola<= 		'1' WHEN bola/= "000000000000000000000000" ELSE
					   '0';	
						
	chopa:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 24)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_chopper_2,  
				  sign  => asteroide,
				  reg   => asteroide_reg);
				  
	bals:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_bola,  
				  sign  => bola,
				  reg   => bola_reg);			  
				  
perder_sign <= '1' WHEN (nave = '1' AND invencible='0') AND  asteroide/= "000000000000000000000000" ELSE
               '0';

chopper_sign<= '1' WHEN bola/="000" AND  asteroide/= "000000000000000000000000" ELSE
               '0';

chopper<= asteroide_reg WHEN  ena_chopper='1' ELSE
			"000000000000000000000000";

perder<= ena_perder;

choque_bola<= bola WHEN ena_chopper='1' ELSE
              "000";
				  
-------------------------------------------------------------------------------------				  
	fsm:ENTITY work.fsm_chopper
	PORT MAP (  clk  				 => clk,
					rst 				 => rst,
					signal_16_m 	 => signal_16_m,
					chopper_sign  	 => chopper_sign,
					perder_sign 	 => perder_sign,
					ena_perder 		 => ena_perder,
					ena_chopper 	 => ena_chopper);
-------------------------------------------------------------------------------------						
END ARCHITECTURE rtl;