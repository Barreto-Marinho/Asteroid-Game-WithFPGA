LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Velocidad_nave IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 reset_nave  :  IN    STD_LOGIC;
				 signal_16_m :  IN    STD_LOGIC;
				 arriba      :  IN    STD_LOGIC;
				 sen_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 cos_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 x_nave      :  OUT   STD_LOGIC_VECTOR(9  DOWNTO 0);
				 y_nave      :  OUT   STD_LOGIC_VECTOR(8  DOWNTO 0);
				 ready_pos   :  OUT   STD_LOGIC);
END ENTITY Velocidad_nave;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Velocidad_nave IS	
	SIGNAL  ena_pos, ena_vel, arriba_reg, a, b :STD_LOGIC;
	SIGNAL  ena_pos_2, ena_vel_2					 :STD_LOGIC;
	SIGNAL  velocidad_reg_x, velocidad_sign_x  :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  velocidad_reg_y, velocidad_sign_y  :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  posicion_reg_x, posicion_sign_x    :STD_LOGIC_VECTOR(17 DOWNTO 0);
	SIGNAL  posicion_reg_y, posicion_sign_y    :STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL  mul_fa_x, mul_fa_y                 :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  velocidad_x_square, vel_mag        :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  velocidad_y_square                 :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  sum_x_1,sum_y_1, sum_fx, sum_fy    :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  mux_sum_x_1,mux_sum_y_1			    :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  vel_x_next, vel_y_next			    :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  mul_cos, mul_sen                   :STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  sum_x ,pos_x_sign                  :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL  sum_y	,pos_y_sign	                :STD_LOGIC_VECTOR(17 DOWNTO 0);	

BEGIN
      ena_vel_2<= ena_vel OR reset_nave;
		ena_pos_2<= ena_pos OR reset_nave;
-------------------------------------------------------------------------------
	flip_flop_vel_1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 11)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_vel_2,
				  sign  =>velocidad_sign_x,
				  reg   =>velocidad_reg_x);	
-------------------------------------------------------------------------------
	flip_flop_vel_2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 11)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_vel_2,
				  sign  =>velocidad_sign_y,
				  reg   =>velocidad_reg_y);	
-------------------------------------------------------------------------------
	flip_flop_pos_1:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 18)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos_2,
				  ini   =>"000110010000000000",
				  sign  =>posicion_sign_x,
				  reg   =>posicion_reg_x);	
-------------------------------------------------------------------------------
	flip_flop_pos_2:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 17)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos_2,
				  ini   => "00110010000000000",
				  sign  =>posicion_sign_y,
				  reg   =>posicion_reg_y);	
-------------------------------------------------------------------------------
	flip_flop_arriba:ENTITY work.my_dff
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  en    =>signal_16_m,
				  d     =>arriba,
				  q     =>arriba_reg);	
-------------------------------------------------------------------------------
	mu_1:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => velocidad_reg_x,
				  data_b  => "11111111110",-- factor amortiguamiento
				  multi   => mul_fa_x);	
-------------------------------------------------------------------------------
	mu_2:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => velocidad_reg_y,
				  data_b  => "11111111110",-- factor amortiguamiento
				  multi   => mul_fa_y);	
-------------------------------------------------------------------------------
--	mux_sum_x_1<= "00000000001"  WHEN  (velocidad_reg_x(10)='1' AND  velocidad_reg_x>"11110000000") ELSE
--					 mul_fa_x(20) & mul_fa_x(17 DOWNTO 8);
--	
--	mux_sum_y_1<=  "00000000001" WHEN  (velocidad_reg_y(10)='1' AND  velocidad_reg_y>"11110000000") ELSE
--					  mul_fa_y(20) & mul_fa_y(17 DOWNTO 8);
					  
   mux_sum_x_1<= STD_LOGIC_VECTOR(UNSIGNED(mul_fa_x(20) & mul_fa_x(17 DOWNTO 8))+"00000000001")  WHEN  (velocidad_reg_x(10)='1' ) ELSE
					 mul_fa_x(20) & mul_fa_x(17 DOWNTO 8);
	
	mux_sum_y_1<= STD_LOGIC_VECTOR(UNSIGNED((mul_fa_y(20) & mul_fa_y(17 DOWNTO 8)))+"00000000001") WHEN  (velocidad_reg_y(10)='1' ) ELSE
					  mul_fa_y(20) & mul_fa_y(17 DOWNTO 8);		  
					  
	sum_x_1<= STD_LOGIC_VECTOR(UNSIGNED(mux_sum_x_1)+UNSIGNED(velocidad_reg_x));
	sum_y_1<= STD_LOGIC_VECTOR(UNSIGNED(mux_sum_y_1)+UNSIGNED(velocidad_reg_y));
-------------------------------------------------------------------------------
	sum_fy<= "00000000000" WHEN arriba_reg='0' ELSE 
				mul_cos(22)& mul_cos(19 DOWNTO 10);

	mu_3:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo,
				  data_b  => "000000010000",
				  multi   => mul_cos);	
-------------------------------------------------------------------------------
	sum_fx<= "00000000000" WHEN arriba_reg='0' ELSE 
				mul_sen(22) & mul_sen(19 DOWNTO 10);
				
	mu_4:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo,
				  data_b  => "000000010000",
				  multi   => mul_sen);	
-------------------------------------------------------------------------------
	vel_x_next<= STD_LOGIC_VECTOR(UNSIGNED(sum_fx)+UNSIGNED(sum_x_1));
	vel_y_next<= STD_LOGIC_VECTOR(UNSIGNED(sum_y_1)-UNSIGNED(sum_fy));
	
--	velocidad_sign_x<= vel_x_next  WHEN vel_mag<("011101011111011011111")ELSE
--							 velocidad_reg_x;
--							 
--	velocidad_sign_y<= vel_y_next  WHEN vel_mag<("011101011111011011111")ELSE
--							 velocidad_reg_y;

  velocidad_sign_x<=  "00000000000" WHEN reset_nave='1'  ELSE 
                      vel_x_next    WHEN vel_mag<("011101011111011011111")ELSE
							 velocidad_reg_x;
	

	
	velocidad_sign_y<= "00000000000" WHEN reset_nave='1'                   ELSE 
	                   vel_y_next    WHEN vel_mag<("011101011111011011111")ELSE
							 velocidad_reg_y;
	
-------------------------------------------------------------------------------
	mu_5:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => vel_x_next,
				  data_b  => vel_x_next,
				  multi   => velocidad_x_square);
-------------------------------------------------------------------------------
	mu_6:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => vel_y_next,
				  data_b  => vel_y_next,
				  multi   => velocidad_y_square);
-------------------------------------------------------------------------------
	vel_mag<= STD_LOGIC_VECTOR(UNSIGNED(velocidad_y_square)+UNSIGNED(velocidad_x_square));
			
	a <= velocidad_reg_x(10);
	b <= velocidad_reg_y(10);
	
	sum_x	<= STD_LOGIC_VECTOR(UNSIGNED('0' & posicion_reg_x)+UNSIGNED(a & a & a & a & a & a & a & a & velocidad_reg_x));
	sum_y	<= STD_LOGIC_VECTOR(UNSIGNED('0' & posicion_reg_y)+UNSIGNED(b & b & b & b & b & b & b & velocidad_reg_y));
-------------------------------------------------------------------------------	
	posicion_sign_x<= pos_x_sign(17 DOWNTO 0);
	
	pos_x_sign<= "0000110010000000000" WHEN reset_nave='1' ELSE 
	             STD_LOGIC_VECTOR(UNSIGNED(sum_x)-"0100111111100000000") WHEN (sum_x(18)='0') AND (sum_x >"0100111111100000000") ELSE
					 STD_LOGIC_VECTOR("0100111111100000000"+UNSIGNED(sum_x)) WHEN (sum_x(18)='1') AND (sum_x >"0100111111100000000") ELSE
					 sum_x;
	
	posicion_sign_y<= pos_y_sign(16 DOWNTO 0);	
	
	pos_y_sign<= "000110010000000000" WHEN reset_nave='1' ELSE 
	             STD_LOGIC_VECTOR(UNSIGNED(sum_y)-"011101111100000000") WHEN (sum_y(17)='0') AND sum_y >"011101111100000000" ELSE
					 STD_LOGIC_VECTOR("011101111100000000"+UNSIGNED(sum_y)) WHEN (sum_y(17)='1') AND sum_y >"011101111100000000" ELSE
					 sum_y;
-------------------------------------------------------------------------------	
	x_nave<= posicion_reg_x(17 DOWNTO 8);
	y_nave<= posicion_reg_y(16 DOWNTO 8);
-------------------------------------------------------------------------------	
	fsm:ENTITY work.fsm_velocidad
	PORT MAP (  clk   			=> clk,
					rst            => rst,
					signal_16_m    => signal_16_m,
					ena_pos   		=> ena_pos,
					ena_vel   		=> ena_vel,--derecha,
					ready_pos   	=> ready_pos);

END ARCHITECTURE rtl;