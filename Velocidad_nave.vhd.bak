LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Velocidad_nave IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
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
	SIGNAL  velocidad_reg_x, velocidad_sign_x  :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  velocidad_reg_y, velocidad_sign_y  :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  posicion_reg_x, posicion_sign_x    :STD_LOGIC_VECTOR(17 DOWNTO 0);
	SIGNAL  posicion_reg_y, posicion_sign_y    :STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL  mul_fa_x, mul_fa_y                 :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  velocidad_x_square, vel_mag        :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  velocidad_y_square                 :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  sum_x_1,sum_y_1, sum_fx, sum_fy    :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  vel_x_next, vel_y_next			    :STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  mul_cos, mul_sen                   :STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  sum_x ,pos_x_sign                  :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL  sum_y	,pos_y_sign	                :STD_LOGIC_VECTOR(17 DOWNTO 0);	

BEGIN

-------------------------------------------------------------------------------
	flip_flop_vel_1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 11)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_vel,
				  sign  =>velocidad_sign_x,
				  reg   =>velocidad_reg_x);	
-------------------------------------------------------------------------------
	flip_flop_vel_2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 11)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_vel,
				  sign  =>velocidad_sign_y,
				  reg   =>velocidad_reg_y);	
-------------------------------------------------------------------------------
	flip_flop_pos_1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 18)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos,
				  sign  =>posicion_sign_x,
				  reg   =>posicion_reg_x);	
-------------------------------------------------------------------------------
	flip_flop_pos_2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 17)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos,
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
				  data_b  => "00000000100",-- factor amortiguamiento
				  multi   => mul_fa_x);	
-------------------------------------------------------------------------------
	mu_2:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => velocidad_reg_y,
				  data_b  => "00000000100",-- factor amortiguamiento
				  multi   => mul_fa_y);	
-------------------------------------------------------------------------------
	sum_x_1<= STD_LOGIC_VECTOR(UNSIGNED(mul_fa_x(20 DOWNTO 10))+UNSIGNED(velocidad_reg_x));
	sum_y_1<= STD_LOGIC_VECTOR(UNSIGNED(mul_fa_y(20 DOWNTO 10))+UNSIGNED(velocidad_reg_y));
-------------------------------------------------------------------------------
	sum_fx<= "00000000000" WHEN arriba_reg='0' ELSE 
				mul_cos(22 DOWNTO 12);

	mu_3:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo,
				  data_b  => "000000010000",-- factor amortiguamiento
				  multi   => mul_cos);	
-------------------------------------------------------------------------------
	sum_fy<= "00000000000" WHEN arriba_reg='0' ELSE 
				mul_sen(22 DOWNTO 12);
				
	mu_4:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo,
				  data_b  => "000000010000",-- factor amortiguamiento
				  multi   => mul_sen);	
-------------------------------------------------------------------------------
	vel_x_next<= STD_LOGIC_VECTOR(UNSIGNED(sum_fx)+UNSIGNED(sum_x_1));
	vel_y_next<= STD_LOGIC_VECTOR(UNSIGNED(sum_fy)+UNSIGNED(sum_y_1));
	
	velocidad_sign_x<= vel_x_next  WHEN vel_mag<("011101011111011011111")ELSE
							 velocidad_reg_x;
	
-------------------------------------------------------------------------------
	mu_5:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => velocidad_reg_x,
				  data_b  => velocidad_reg_x,-- factor amortiguamiento
				  multi   => velocidad_x_square);
-------------------------------------------------------------------------------
	mu_6:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 11)
	PORT MAP ( data_a  => velocidad_reg_y,
				  data_b  => velocidad_reg_y,-- factor amortiguamiento
				  multi   => velocidad_y_square);
-------------------------------------------------------------------------------
	vel_mag<= STD_LOGIC_VECTOR(UNSIGNED(velocidad_y_square)+UNSIGNED(velocidad_x_square));
			
	a <= velocidad_reg_x(10);
	b <= velocidad_reg_x(10);
	
	sum_x	<= STD_LOGIC_VECTOR(UNSIGNED('0' & posicion_reg_x)+UNSIGNED(a & a & a & a & a & a & a & a & velocidad_reg_x));
	sum_y	<= STD_LOGIC_VECTOR(UNSIGNED('0' & posicion_reg_y)+UNSIGNED(b & b & b & b & b & b & b & velocidad_reg_x));
-------------------------------------------------------------------------------	
	posicion_sign_x<= pos_x_sign(17 DOWNTO 0);
	
	pos_x_sign<= STD_LOGIC_VECTOR(UNSIGNED(sum_x)-"0100111111100000000") WHEN (sum_x(18)='0') AND (sum_x >"0100111111100000000") ELSE
					 STD_LOGIC_VECTOR("0100111111100000000"+UNSIGNED(sum_x)) WHEN (sum_x(18)='1') AND (sum_x >"0100111111100000000") ELSE
					 sum_x;
	
	posicion_sign_y<= pos_y_sign(16 DOWNTO 0);	
	pos_y_sign<= STD_LOGIC_VECTOR(UNSIGNED(sum_y)-"011101111100000000") WHEN (sum_y(17)='0') AND sum_y >"011101111100000000" ELSE
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