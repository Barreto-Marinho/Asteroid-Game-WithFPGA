LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Control_nave IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 signal_16_m :  IN    STD_LOGIC;
				 x_actual    :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_actual    :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 x_nave      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_nave      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 sen_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 cos_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 nave        :  OUT   STD_LOGIC;
				 color_nave  :  IN	 STD_LOGIC_VECTOR(11 DOWNTO 0);
				 color_pix   :  OUT   STD_LOGIC_VECTOR(11 DOWNTO 0)
				);
END ENTITY Control_nave;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Control_nave IS	
	SIGNAL  ena_count, syn_clr, max_tick, ena_Reg 	: STD_LOGIC;
	SIGNAL  ena_write, enable_x, enable_y           : STD_LOGIC;
	SIGNAL  write_s, read_ram                       : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL  addr_vec            			 				: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL  resta_y_ac, suma_y_ac,seleccion_y	 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  resta_x_ac, suma_x_ac,seleccion_x       : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  r_data_x, r_data_y, mul_5,addres_write  : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL  sen_angulo_reg,cos_angulo_reg           : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL  multi_y_actual, address_read			   : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL  mul_1, mul_2, mul_3, mul_4, resta_1     : STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  resta_2									      : STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL  despla_1, despla_2, sum_1, sum_2        : STD_LOGIC_VECTOR(12 DOWNTO 0);
	SIGNAL  data_b_aux_1	,data_b_aux_2				   : STD_LOGIC_VECTOR(11 DOWNTO 0);

	
BEGIN

------------------------------------------------------------------------------
	cont:ENTITY work.contador_uni
	GENERIC MAP(N => 8)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr,
				  ini      => "00000000",
				  ena      => ena_count,
				  max      => "11000111",
				  counter  => addr_vec,
				  max_tick => max_tick);
-------------------------------------------------------------------------------			
	r_data_x(11 DOWNTO 6)<= "000000" WHEN r_data_x(5)='0' ELSE
									"111111";
		  
	memo_vecx:ENTITY work.Vec_x
	GENERIC MAP(DATA_WIDTH => 6,
					ADDR_WIDTH => 8)
	PORT MAP ( clk      => clk,
				  addr     =>addr_vec,
				  r_data   =>r_data_x(5 DOWNTO 0));
	
-------------------------------------------------------------------------------
	r_data_y(11 DOWNTO 6)<= "000000" WHEN r_data_y(5)='0' ELSE
									"111111";
	
	memo_vecy:ENTITY work.Vec_y
	GENERIC MAP(DATA_WIDTH => 6,
					ADDR_WIDTH => 8)
	PORT MAP ( clk      => clk,
				  addr     =>addr_vec,
				  r_data   =>r_data_y(5 DOWNTO 0));
				  
-------------------------------------------------------------------------------
				  
	ff_sen:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 12)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_Reg,
				  sign  =>sen_angulo,
				  reg   =>sen_angulo_reg);		
				  
-------------------------------------------------------------------------------
	
	ff_cos:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 12)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_Reg,
				  sign  =>cos_angulo,
				  reg   =>cos_angulo_reg);		
				  
-------------------------------------------------------------------------------

	mu_1:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo_reg,
				  data_b  => r_data_x,
				  multi   => mul_1);	
				  
-------------------------------------------------------------------------------

	mu_2:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo_reg,
				  data_b  => r_data_y,
				  multi   => mul_2);	
				  
-------------------------------------------------------------------------------

	mu_3:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo_reg,
				  data_b  => r_data_x,
				  multi   => mul_3);	
				  
				  
-----------------------------------------------------------------------------

	mu_4:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo_reg,
				  data_b  => r_data_y,
				  multi   => mul_4);	

-----------------------------------------------------------------------------

	rest_1:ENTITY work.sub_add
	GENERIC MAP(N => 23)
	PORT MAP ( data_a    => mul_1,
				  data_b    => mul_2,
				  ena_sum   => '1',
				  ope       => resta_1);	  
			
-----------------------------------------------------------------------------
	despla_1<= resta_1(22 DOWNTO 10);
	despla_2<= resta_2(22 DOWNTO 10);

	rest_2:ENTITY work.sub_add
	GENERIC MAP(N => 23)
	PORT MAP ( data_a    => mul_3,
				  data_b    => mul_4,
				  ena_sum   => '0',
				  ope       => resta_2);	
-----------------------------------------------------------------------------	

	sum:ENTITY work.sub_add
	GENERIC MAP(N => 13)
	PORT MAP ( data_a    => despla_1,
				  data_b    => "0000000011110",
				  ena_sum   => '1',
				  ope       => sum_1);				
			
-----------------------------------------------------------------------------	

	sum_11:ENTITY work.sub_add
	GENERIC MAP(N => 13)
	PORT MAP ( data_a    => despla_2,
				  data_b    => "0000000011110",
				  ena_sum   => '1',
				  ope       => sum_2);
				  
-----------------------------------------------------------------------------	
	mu_5:ENTITY work.Multiplicador
	GENERIC MAP(N => 6)
	PORT MAP ( dataa  => sum_2(5 DOWNTO 0),
				  datab  => "111101",
				  result   => mul_5);	
-----------------------------------------------------------------------------
	data_b_aux_2<= "000000" & sum_1(5 DOWNTO 0);
	sum_12:ENTITY work.sub_add
	GENERIC MAP(N => 12)
	PORT MAP ( data_a    => mul_5,
				  data_b    => data_b_aux_2,
				  ena_sum   => '1',
				  ope       => addres_write);			  
-----------------------------------------------------------------------------
	rest_x:ENTITY work.sub_add
	GENERIC MAP(N => 11)
	PORT MAP ( data_a    =>'0' & x_actual,
				  data_b    =>'0' & x_nave,
				  ena_sum   => '0',
				  ope       => resta_x_ac);	  			  
-----------------------------------------------------------------------------

	rest_y:ENTITY work.sub_add
	GENERIC MAP(N => 10)
	PORT MAP ( data_a    =>'0' & y_actual,
				  data_b    =>'0' & y_nave,
				  ena_sum   => '0',
				  ope       => resta_y_ac);	
			
-----------------------------------------------------------------------------
	sum_13:ENTITY work.sub_add
	GENERIC MAP(N => 11)
	PORT MAP ( data_a    => resta_x_ac,
				  data_b    => "01010000000",
				  ena_sum   => '1',
				  ope       => suma_x_ac);
-----------------------------------------------------------------------------
	sum_14:ENTITY work.sub_add
	GENERIC MAP(N => 10)
	PORT MAP ( data_a    => resta_y_ac,
				  data_b    => "0111100000",
				  ena_sum   => '1',
				  ope       => suma_y_ac);
-----------------------------------------------------------------------------	
	mu_6:ENTITY work.Multiplicador
	GENERIC MAP(N => 6)
	PORT MAP ( dataa  => seleccion_y(5 DOWNTO 0),
				  datab  => "111101",
				  result   => multi_y_actual);	
-----------------------------------------------------------------------------
	data_b_aux_1<= "0"&seleccion_x;
	sum_15:ENTITY work.sub_add
	GENERIC MAP(N => 12)
	PORT MAP ( data_a    => multi_y_actual,
				  data_b    => data_b_aux_1,
				  ena_sum   => '1',
				  ope       => address_read);
-----------------------------------------------------------------------------
	memo_ram:ENTITY work.memoria_RAM
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 12)
	PORT MAP ( clock      		=> clk,
				  data     			=>write_s,
				  q     				=>read_ram,
				  rdaddress     	=>address_read,
				  wraddress     	=>addres_write,
				  wren     			=> ena_write);			
-----------------------------------------------------------------------------
	fsm:ENTITY work.fsm_control_nave
	PORT MAP (  clk  				 => clk,
					rst 				 => rst,
					signal_16_m 	 => signal_16_m,
					max_tick  		 => max_tick,
					ena_write 		 => ena_write,
					ena_count 		 => ena_count,
					write_s 			 => write_s(0),
					syn_clr 			 => syn_clr,
					ena_Reg 			 => ena_Reg);	
-----------------------------------------------------------------------------
	
   seleccion_x<= resta_x_ac WHEN (resta_x_ac(10)='0') ELSE
					  suma_x_ac;
					  
	seleccion_y<= resta_y_ac WHEN (resta_y_ac(9)='0') ELSE
					  suma_y_ac;
					  
	color_pix<= color_nave WHEN (enable_x='1' AND enable_y='1' AND read_ram="1") ELSE
					"000000000000";
	
	nave     <= '1' WHEN (enable_x='1' AND enable_y='1' AND read_ram="1") ELSE '0';
	
	enable_x<= '1' WHEN  ((x_actual>=x_nave) AND x_nave>="1001000100") 
                          OR(x_actual>=x_nave AND x_nave<"1001000100" AND x_actual< STD_LOGIC_VECTOR("0000111101"+ UNSIGNED(x_nave))) 
                          OR(x_actual<x_nave AND (x_nave>= "1001000100") AND (STD_LOGIC_VECTOR("01001000011"+UNSIGNED('0' & x_actual))<'0' & x_nave)) ELSE 
				  '0';
								  
	enable_y<= '1' WHEN        ((y_Actual>=y_nave) AND y_nave>="110100100") 
                            OR(y_actual>=y_nave AND y_nave<"110100100" AND y_actual< STD_LOGIC_VECTOR("000111101"+ UNSIGNED(y_nave))) 
                            OR(y_actual<y_nave AND (y_nave>= "110100100") AND (STD_LOGIC_VECTOR("0110100011"+UNSIGNED('0' & y_actual))< '0'& y_nave)) ELSE
					'0';
	
END ARCHITECTURE rtl;