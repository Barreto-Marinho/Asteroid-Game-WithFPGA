LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Bloque_bola_individual IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 signal_16_m :  IN    STD_LOGIC;
				 syn_clr     :  IN    STD_LOGIC;
				 ena_vel     :  IN    STD_LOGIC;
				 ena_count   :  IN    STD_LOGIC;
				 ena_pos     :  IN    STD_LOGIC;
				 ena_creacion:  IN    STD_LOGIC;
				 ena         :  IN    STD_LOGIC;
				 x_lect      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_lect      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 x_nave      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_nave      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 sen_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 cos_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 pix         :  OUT   STD_LOGIC;
				 max_tick    :  OUT   STD_LOGIC);
END ENTITY Bloque_bola_individual;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Bloque_bola_individual IS	
	SIGNAL  pos_sign_y, pos_reg_y		: STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL  pos_sign_x, pos_reg_x		: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  pos_sign_x_2        		: STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  pos_sign_y_2        		: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  vel_sign_x, vel_reg_x		: STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL  vel_sign_y ,vel_reg_y		: STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL  mul_cos ,mul_sen    		: STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  mul_cos_1 ,mul_sen_1    	: STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  sum_y_pos, pos_ini_y		: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  res_y_pos						: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  sum_x_pos, pos_ini_x		: STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  res_x_pos						: STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  vel_ini_x 					: STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL  vel_ini_y 					: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  resta_x_ac, suma_x_ac		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  seleccion_x					: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  resta_y_ac, suma_y_ac		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  seleccion_y					: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  addres_read					: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL  r_data							: STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL  enable_x,enable_y			: STD_LOGIC;
BEGIN


------------------------------------------------------------------------------
	cont:ENTITY work.contador_uni
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr,
				  ini      => "000000",
				  ena      => ena_count,
				  max      => "111100",
				  max_tick => max_tick);
-------------------------------------------------------------------------------	
	ff_posx:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos,
				  sign  =>pos_sign_x,
				  reg   =>pos_reg_x);					  
-------------------------------------------------------------------------------	
	ff_posy:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_pos,
				  sign  =>pos_sign_y,
				  reg   =>pos_reg_y);
-------------------------------------------------------------------------------	
	ff_vely:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 14)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_creacion,
				  sign  =>vel_sign_y,
				  reg   =>vel_reg_y);				  
-------------------------------------------------------------------------------	
	ff_velx:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 14)
	PORT MAP ( clk   =>clk,
				  rst   =>rst,
				  ena   =>ena_creacion,
				  sign  =>vel_sign_x,
				  reg   =>vel_reg_x);				  
-------------------------------------------------------------------------------
	sum_y_pos <= STD_LOGIC_VECTOR(UNSIGNED('0' & y_nave & "0000000000") +("00000111100000000000")+ UNSIGNED(mul_cos(22)& mul_cos(19 DOWNTO 1)));
	res_y_pos<=  STD_LOGIC_VECTOR(UNSIGNED(sum_y_pos)-("00000000000111100000"));
	
	pos_ini_y<= sum_y_pos WHEN  res_y_pos(19)='1' ELSE
					res_y_pos;
	
	mu_1:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo,
				  data_b  => "000000010100",
				  multi   => mul_cos);					  
-------------------------------------------------------------------------------
	sum_x_pos <= STD_LOGIC_VECTOR(UNSIGNED('0' & x_nave & "0000000000") +("000000111100000000000")+ UNSIGNED(mul_sen(22)& mul_sen(20 DOWNTO 1)));
	res_x_pos<=  STD_LOGIC_VECTOR(UNSIGNED(sum_x_pos)-("000000000001010000000"));
	
	pos_ini_x<= sum_x_pos WHEN  res_x_pos(20)='1' ELSE
					res_x_pos;
	
	mu_2:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo,
				  data_b  => "111111110101",
				  multi   => mul_sen);				  
-------------------------------------------------------------------------------	
	pos_sign_x<= pos_sign_x_2(19 DOWNTO 0);
	pos_sign_x_2<= pos_ini_x					 											      WHEN  ena_creacion='1'											            ELSE
					 STD_LOGIC_VECTOR(UNSIGNED(vel_ini_x)-"010011111110000000000") WHEN (vel_ini_x(20)='0') AND (vel_ini_x >"010011111110000000000") ELSE
					 STD_LOGIC_VECTOR("010011111110000000000"+UNSIGNED(vel_ini_x)) WHEN (vel_ini_x(20)='1') AND (vel_ini_x >"010011111110000000000") ELSE
					 vel_ini_x; 

	vel_sign_x<= mul_sen_1(22) & mul_sen_1(12 DOWNTO 0);
	
	vel_ini_x<= STD_LOGIC_VECTOR(UNSIGNED(vel_reg_x(13)&vel_reg_x(13)&vel_reg_x(13)&
					vel_reg_x(13)&vel_reg_x(13)&vel_reg_x(13)&
					vel_reg_x(13)&vel_reg_x(13)& vel_reg_x(12 DOWNTO 0)) + UNSIGNED('0'& pos_reg_x));

	mu_3:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo,
				  data_b  => "000000000110",
				  multi   => mul_sen_1);		
-------------------------------------------------------------------------------	
	pos_sign_y<= pos_sign_y_2(18 DOWNTO 0);

	pos_sign_y_2<= pos_ini_y														        WHEN ena_creacion='1' 							  						  ELSE
					 STD_LOGIC_VECTOR(UNSIGNED(vel_ini_y)-"01110111110000000000") WHEN (vel_ini_y(19)='0') AND vel_ini_y >"01110111110000000000" ELSE
					 STD_LOGIC_VECTOR("01110111110000000000"+UNSIGNED(vel_ini_y)) WHEN (vel_ini_y(19)='1') AND vel_ini_y >"01110111110000000000" ELSE
					 vel_ini_y; 

	vel_sign_y<= mul_cos_1(22) & mul_cos_1(12 DOWNTO 0);
	
	vel_ini_y<= STD_LOGIC_VECTOR(UNSIGNED(vel_reg_y(13)&vel_reg_y(13)&
					vel_reg_y(13)&vel_reg_y(13)&vel_reg_y(13)&
					vel_reg_y(13)&vel_reg_y(13)& vel_reg_y(12 DOWNTO 0)) + UNSIGNED('0'& pos_reg_y));

	mu_4:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo,
				  data_b  => "111111111010" ,
				  multi   => mul_cos_1);	
-------------------------------------------------------------------------------		
	matriz:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>pos_reg_x(19 DOWNTO 10),
				  pos_y=>pos_reg_y(18 DOWNTO 10),
				  addres_read=>addres_read,
				  ancho_mem=>"1011",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x,
				  enable_y=>enable_y,
				  cuat0_ancho=>"111010101");	
				  
	pix<= '1' WHEN (enable_x='1' AND enable_y='1' AND r_data="1" AND ena='1') ELSE
			'0';
		
	memo_bala:ENTITY work.Memoria_bala
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 7)
	PORT MAP ( clk      => clk,
				  addr     =>addres_read(6 DOWNTO 0),
				  r_data   => r_data);
		

	
END ARCHITECTURE rtl;