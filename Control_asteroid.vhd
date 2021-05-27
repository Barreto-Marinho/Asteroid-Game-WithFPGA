LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Control_asteroid IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 signal_16_m :  IN    STD_LOGIC;
				 ganar       :  OUT   STD_LOGIC;
				 perder      :  IN    STD_LOGIC;
				 new_level   :  IN    STD_LOGIC;
				 chopper     :  IN    STD_LOGIC_VECTOR(23 DOWNTO 0);
				 x_nave      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_nave      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 x_actual    :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_actual    :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 nivel       :  IN    STD_LOGIC_VECTOR(1 DOWNTO 0);
				 asteroide   :  OUT	 STD_LOGIC_VECTOR(23 DOWNTO 0);
				 habilitar_reg_o :  OUT	 STD_LOGIC_VECTOR(23 DOWNTO 0);
				 color_as_1  :  IN	 STD_LOGIC_VECTOR(11 DOWNTO 0);
				 color_as_2  :  IN	 STD_LOGIC_VECTOR(11 DOWNTO 0);
				 color_as_3  :  IN	 STD_LOGIC_VECTOR(11 DOWNTO 0);
				 pixel_as    :  OUT   STD_LOGIC_VECTOR(11 DOWNTO 0)
				);
END ENTITY Control_asteroid;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Control_asteroid IS	
	SIGNAL ena_reg_G,ena_creacion,numero, ena_mover_2, ena_mover, ena_write, max_tick_as       :STD_LOGIC;
	SIGNAL max_tick_24, syn_asteroid, ena_asteroid, ena_24, syn_24, ena_mover_c, signal_count	 :STD_LOGIC;
	SIGNAL ena_fase_0, ena_fase_1, ena_fase_2, ena_fase_3, ena_fase_4, ena_fase_5					 :STD_LOGIC;
	SIGNAL enable_x_0, enable_y_0, enable_x_6, enable_y_6, enable_x_12, enable_y_12				 :STD_LOGIC;
	SIGNAL enable_x_1, enable_y_1, enable_x_7, enable_y_7, enable_x_13, enable_y_13				 :STD_LOGIC;
	SIGNAL enable_x_2, enable_y_2, enable_x_8, enable_y_8, enable_x_14, enable_y_14			    :STD_LOGIC;
	SIGNAL enable_x_3, enable_y_3, enable_x_9, enable_y_9, enable_x_15, enable_y_15				 :STD_LOGIC;
	SIGNAL enable_x_4, enable_y_4, enable_x_10, enable_y_10, enable_x_16, enable_y_16		    :STD_LOGIC;
	SIGNAL enable_x_5, enable_y_5, enable_x_11, enable_y_11, enable_x_17, enable_y_17			 :STD_LOGIC;
	SIGNAL enable_x_18, enable_y_18, enable_x_19, enable_y_19, enable_x_20, enable_y_20			 :STD_LOGIC;
	SIGNAL enable_x_21, enable_y_21, enable_x_22, enable_y_22, enable_x_23, enable_y_23			 :STD_LOGIC;
	SIGNAL x_lect 																						             :STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_lect 																						             :STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL vel 																						                :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL count_as, fase_1, fase_2,fase_3, fase_4, fase_5, fase_0       							 :STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL fase_sign_0, fase_sign_1, fase_sign_2,fase_sign_3, fase_sign_4, fase_sign_5         :STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL count_24                         																    :STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL addres_write_ang,addres_read_ang, address_trig, data_ang_write, ang_aleatorio       :STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL ang_romper																							       :STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL ena, cond, habilitar_sign, ena_habilitar_sign, habilitar_reg                        :STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL x_actual_anterior, x_reg_0, x_reg_1, x_reg_2, x_reg_3, x_reg_4, x_reg_5, x_reg_6    :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_reg_7, x_reg_8, x_reg_9, x_reg_10, x_reg_11, x_reg_12, x_reg_13    					 :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_reg_14, x_reg_15, x_reg_16, x_reg_17, x_reg_18, x_reg_19, x_reg_20   			    :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_reg_21, x_reg_22, x_reg_23, sum_pos_x												 			 :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_sign_0, x_sign_4, x_sign_8, x_sign_12, x_sign_15, x_sign_18, x_sign_21    			 :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_sign_1, x_sign_5, x_sign_9, x_sign_13, x_sign_16, x_sign_19, x_sign_22    			 :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_sign_2, x_sign_6, x_sign_10, x_sign_14, x_sign_17, x_sign_20, x_sign_23   			 :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL x_sign_3, x_sign_7, x_sign_11, x_pos_aleatorio	, x_pos_romper  						    :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL y_actual_anterior, y_reg_0, y_reg_1, y_reg_2, y_reg_3, y_reg_4, y_reg_5, y_reg_6    :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_reg_7, y_reg_8, y_reg_9, y_reg_10, y_reg_11, y_reg_12, y_reg_13    					 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_reg_14, y_reg_15,y_reg_16, y_reg_17, y_reg_18, y_reg_19, y_reg_20   			    	 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_reg_21, y_reg_22, y_reg_23													 						 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_sign_0, y_sign_4, y_sign_8, y_sign_12, y_sign_15, y_sign_18, y_sign_21 			    :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_sign_1, y_sign_5, y_sign_9, y_sign_13, y_sign_16, y_sign_19, y_sign_22    			 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_sign_2, y_sign_6,y_sign_10, y_sign_14, y_sign_17, y_sign_20, y_sign_23   			 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL y_sign_3, y_sign_7, y_sign_11, sum_pos_y, y_pos_aleatorio	, y_pos_romper				 :STD_LOGIC_VECTOR(18 DOWNTO 0);
	SIGNAL sen_angulo, cos_angulo, velocidad															 		 :STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL address_read_0,address_read_4,address_read_8,address_read_12,address_read_16			 :STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL address_read_20																							 :STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL address_read_2,address_read_6,address_read_10,address_read_14,address_read_18		 :STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL address_read_22																							 :STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL address_read_1,address_read_5,address_read_9,address_read_13,address_read_17			 :STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL address_read_3,address_read_7,address_read_11,address_read_15,address_read_19		 :STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL address_read_21,address_read_23 							 										 :STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL mul_sen, mul_cos								     														 :STD_LOGIC_VECTOR(22 DOWNTO 0);
	SIGNAL vel_ini_x, pos_sign_x      								     									    :STD_LOGIC_VECTOR(20 DOWNTO 0);
	SIGNAL vel_ini_y, pos_sign_y      								     									    :STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL ancho_mem_0, ancho_mem_4, ancho_mem_8, ancho_mem_12, ancho_mem_16,ancho_mem_20		 :STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL ancho_mem_2, ancho_mem_6, ancho_mem_10, ancho_mem_14, ancho_mem_18,ancho_mem_22		 :STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL data_0, data_4,data_8		  ,data_16,data_20,data_24,data_28,data_32,data_36,data_40:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_1, data_5,data_9,data_3,data_17,data_21,data_25,data_29,data_33,data_37,data_41:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_12, data_6,data_10,data_14,data_18,data_22,data_26,data_30,data_34,data_38		 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_13, data_42,data_11,data_43,data_19,data_44,data_27,data_45,data_35,data_46	 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_reg_0, data_reg_7, data_reg_8, data_reg_15, data_reg_16, data_reg_23         	 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_reg_1, data_reg_6, data_reg_9, data_reg_14, data_reg_17, data_reg_22         	 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_reg_2, data_reg_5, data_reg_10, data_reg_13, data_reg_18, data_reg_21        	 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL data_reg_3, data_reg_4, data_reg_11, data_reg_12, data_reg_19, data_reg_20        	 :STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL color 		,data_2																						 :STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN

------------------------------------------------------------------------------------------------------------------------------------------------------------}
	x_lect<= x_actual;
	y_lect<= y_actual;

	pixel_as<=  color_as_1 WHEN color = "01" ELSE
					color_as_2 WHEN color = "10" ELSE
					color_as_3 WHEN color = "11" ELSE
					"000000000000";
					
	ganar<= '1' WHEN habilitar_reg="000000000000000000000000" ELSE
		     '0';
	
	habilitar_reg_o<= habilitar_reg;
	
	asteroide(0)<= '1' WHEN data_reg_0/="00"  AND enable_x_0='1' AND enable_y_0='1' AND habilitar_reg(0)='1' ELSE '0';
	asteroide(1)<= '1' WHEN data_reg_1/="00"  AND enable_x_1='1' AND enable_y_1='1' AND habilitar_reg(1)='1' ELSE '0';
	asteroide(2)<= '1' WHEN data_reg_2/="00"  AND enable_x_2='1' AND enable_y_2='1' AND habilitar_reg(2)='1' ELSE '0';
	asteroide(3)<= '1' WHEN data_reg_3/="00"  AND enable_x_3='1' AND enable_y_3='1' AND habilitar_reg(3)='1' ELSE '0';
	asteroide(4)<=	'1' WHEN data_reg_4/="00"  AND enable_x_4='1' AND enable_y_4='1' AND habilitar_reg(4)='1' ELSE '0';
	asteroide(5)<= '1' WHEN data_reg_5/="00"  AND enable_x_5='1' AND enable_y_5='1' AND habilitar_reg(5)='1' ELSE '0';
	asteroide(6)<=	'1' WHEN data_reg_6/="00"  AND enable_x_6='1' AND enable_y_6='1' AND habilitar_reg(6)='1' ELSE '0';
	asteroide(7)<=	'1' WHEN data_reg_7/="00"  AND enable_x_7='1' AND enable_y_7='1' AND habilitar_reg(7)='1' ELSE '0';
	asteroide(8)<=	'1' WHEN data_reg_8/="00"  AND enable_x_8='1' AND enable_y_8='1' AND habilitar_reg(8)='1' ELSE '0';
	asteroide(9)<=	'1' WHEN data_reg_9/="00"  AND enable_x_9='1' AND enable_y_9='1' AND habilitar_reg(9)='1' ELSE '0';
	asteroide(10)<='1' WHEN data_reg_10/="00" AND enable_x_10='1' AND enable_y_10='1' AND habilitar_reg(10)='1' ELSE '0';
	asteroide(11)<='1' WHEN data_reg_11/="00" AND enable_x_11='1' AND enable_y_11='1' AND habilitar_reg(11)='1' ELSE '0';
	asteroide(12)<='1' WHEN data_reg_12/="00" AND enable_x_12='1' AND enable_y_12='1' AND habilitar_reg(12)='1' ELSE '0';
	asteroide(13)<='1' WHEN data_reg_13/="00" AND enable_x_13='1' AND enable_y_13='1' AND habilitar_reg(13)='1' ELSE '0';
	asteroide(14)<='1' WHEN data_reg_14/="00" AND enable_x_14='1' AND enable_y_14='1' AND habilitar_reg(14)='1' ELSE '0';
	asteroide(15)<='1' WHEN data_reg_15/="00" AND enable_x_15='1' AND enable_y_15='1' AND habilitar_reg(15)='1' ELSE '0';
	asteroide(16)<='1' WHEN data_reg_16/="00" AND enable_x_16='1' AND enable_y_16='1' AND habilitar_reg(16)='1' ELSE '0';
	asteroide(17)<='1' WHEN data_reg_17/="00" AND enable_x_17='1' AND enable_y_17='1' AND habilitar_reg(17)='1' ELSE '0';
	asteroide(18)<='1' WHEN data_reg_18/="00" AND enable_x_18='1' AND enable_y_18='1' AND habilitar_reg(18)='1' ELSE '0';
	asteroide(19)<='1' WHEN data_reg_19/="00" AND enable_x_19='1' AND enable_y_19='1' AND habilitar_reg(19)='1' ELSE '0';
	asteroide(20)<='1' WHEN data_reg_20/="00" AND enable_x_20='1' AND enable_y_20='1' AND habilitar_reg(20)='1' ELSE '0';
	asteroide(21)<='1' WHEN data_reg_21/="00" AND enable_x_21='1' AND enable_y_21='1' AND habilitar_reg(21)='1' ELSE '0';
	asteroide(22)<='1' WHEN data_reg_22/="00" AND enable_x_22='1' AND enable_y_22='1' AND habilitar_reg(22)='1' ELSE '0';
	asteroide(23)<='1' WHEN data_reg_23/="00" AND enable_x_23='1' AND enable_y_23='1' AND habilitar_reg(23)='1' ELSE '0';
	
	
					
	color<= data_reg_0 WHEN data_reg_0/="00"   AND enable_x_0='1' AND enable_y_0='1' AND habilitar_reg(0)='1' ELSE
			  data_reg_1 WHEN data_reg_1/="00"   AND enable_x_1='1' AND enable_y_1='1' AND habilitar_reg(1)='1' ELSE
			  data_reg_2 WHEN data_reg_2/="00"   AND enable_x_2='1' AND enable_y_2='1' AND habilitar_reg(2)='1' ELSE
			  data_reg_3 WHEN data_reg_3/="00"   AND enable_x_3='1' AND enable_y_3='1' AND habilitar_reg(3)='1' ELSE
			  data_reg_4 WHEN data_reg_4/="00"   AND enable_x_4='1' AND enable_y_4='1' AND habilitar_reg(4)='1' ELSE
			  data_reg_5 WHEN data_reg_5/="00"   AND enable_x_5='1' AND enable_y_5='1' AND habilitar_reg(5)='1' ELSE
			  data_reg_6 WHEN data_reg_6/="00"   AND enable_x_6='1' AND enable_y_6='1' AND habilitar_reg(6)='1' ELSE
			  data_reg_7 WHEN data_reg_7/="00"   AND enable_x_7='1' AND enable_y_7='1' AND habilitar_reg(7)='1' ELSE
			  data_reg_8 WHEN data_reg_8/="00"   AND enable_x_8='1' AND enable_y_8='1' AND habilitar_reg(8)='1' ELSE
			  data_reg_9 WHEN data_reg_9/="00"   AND enable_x_9='1' AND enable_y_9='1' AND habilitar_reg(9)='1' ELSE
			  data_reg_10 WHEN data_reg_10/="00" AND enable_x_10='1' AND enable_y_10='1' AND habilitar_reg(10)='1' ELSE
			  data_reg_11 WHEN data_reg_11/="00" AND enable_x_11='1' AND enable_y_11='1' AND habilitar_reg(11)='1' ELSE
			  data_reg_12 WHEN data_reg_12/="00" AND enable_x_12='1' AND enable_y_12='1' AND habilitar_reg(12)='1' ELSE
			  data_reg_13 WHEN data_reg_13/="00" AND enable_x_13='1' AND enable_y_13='1' AND habilitar_reg(13)='1' ELSE
			  data_reg_14 WHEN data_reg_14/="00" AND enable_x_14='1' AND enable_y_14='1' AND habilitar_reg(14)='1' ELSE
			  data_reg_15 WHEN data_reg_15/="00" AND enable_x_15='1' AND enable_y_15='1' AND habilitar_reg(15)='1' ELSE
			  data_reg_16 WHEN data_reg_16/="00" AND enable_x_16='1' AND enable_y_16='1' AND habilitar_reg(16)='1' ELSE
			  data_reg_17 WHEN data_reg_17/="00" AND enable_x_17='1' AND enable_y_17='1' AND habilitar_reg(17)='1' ELSE
			  data_reg_18 WHEN data_reg_18/="00" AND enable_x_18='1' AND enable_y_18='1' AND habilitar_reg(18)='1' ELSE
			  data_reg_19 WHEN data_reg_19/="00" AND enable_x_19='1' AND enable_y_19='1' AND habilitar_reg(19)='1' ELSE
			  data_reg_20 WHEN data_reg_20/="00" AND enable_x_20='1' AND enable_y_20='1' AND habilitar_reg(20)='1' ELSE
			  data_reg_21 WHEN data_reg_21/="00" AND enable_x_21='1' AND enable_y_21='1' AND habilitar_reg(21)='1' ELSE
			  data_reg_22 WHEN data_reg_22/="00" AND enable_x_22='1' AND enable_y_22='1' AND habilitar_reg(22)='1' ELSE
			  data_reg_23 WHEN data_reg_23/="00" AND enable_x_23='1' AND enable_y_23='1' AND habilitar_reg(23)='1' ELSE
			  "00";
			  
	

------------------------------------------------------------------------------------------------------------------------------------------------------------
	ancho_mem_0<= "110010" WHEN  fase_0= "000" 			 		 ELSE
					  "011001" WHEN  fase_0="001" OR fase_0="011" ELSE
					  "001100";
 
   matriz_0:ENTITY work.Calculo_addres_astero--Grande, mediana, chiquita
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_0(19 DOWNTO 10),
				  pos_y=>y_reg_0(18 DOWNTO 10),
				  addres_read=>address_read_0,
				  ancho_mem=>ancho_mem_0,-------------
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_0,
				  enable_y=>enable_y_0,
				  cuat0_ancho=>"111010101");
				 
	matriz_1:ENTITY work.Calculo_addres_read--memoria pequeña
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_1(19 DOWNTO 10),
				  pos_y=>y_reg_1(18 DOWNTO 10),
				  addres_read=>address_read_1,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_1,
				  enable_y=>enable_y_1,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_2<= "11001" WHEN  fase_0="001" OR fase_0="011" ELSE
					  "01100";	
	
	matriz_2:ENTITY work.Calculo_addres_read---memoria median y pequeña
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_2(19 DOWNTO 10),
				  pos_y=>y_reg_2(18 DOWNTO 10),
				  addres_read=>address_read_2,
				  ancho_mem=>ancho_mem_2,-----------------
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_2,
				  enable_y=>enable_y_2,
				  cuat0_ancho=>"111010101");
	
	matriz_3:ENTITY work.Calculo_addres_read--pequela
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_3(19 DOWNTO 10),
				  pos_y=>y_reg_3(18 DOWNTO 10),
				  addres_read=>address_read_3,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_3,
				  enable_y=>enable_y_3,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_4<= "110010" WHEN  fase_1= "000" 			 		 ELSE
					  "011001" WHEN  fase_1="001" OR fase_1="011" ELSE
					  "001100";
	
	matriz_4:ENTITY work.Calculo_addres_astero--grande
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_4(19 DOWNTO 10),
				  pos_y=>y_reg_4(18 DOWNTO 10),
				  addres_read=>address_read_4,
				  ancho_mem=>ancho_mem_4,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_4,
				  enable_y=>enable_y_4,
				  cuat0_ancho=>"111010101");
				 
	matriz_5:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_5(19 DOWNTO 10),
				  pos_y=>y_reg_5(18 DOWNTO 10),
				  addres_read=>address_read_5,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_5,
				  enable_y=>enable_y_5,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_6<= "11001" WHEN  fase_1="001" OR fase_1="011" ELSE
					  "01100";
	
	matriz_6:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_6(19 DOWNTO 10),
				  pos_y=>y_reg_6(18 DOWNTO 10),
				  addres_read=>address_read_6,
				  ancho_mem=>ancho_mem_6,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_6,
				  enable_y=>enable_y_6,
				  cuat0_ancho=>"111010101");
				 
	matriz_7:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_7(19 DOWNTO 10),
				  pos_y=>y_reg_7(18 DOWNTO 10),
				  addres_read=>address_read_7,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_7,
				  enable_y=>enable_y_7,
				  cuat0_ancho=>"111010101");
		
	ancho_mem_8<= "110010" WHEN  fase_2= "000" 			 		 ELSE
					  "011001" WHEN  fase_2="001" OR fase_2="011" ELSE
					  "001100";	
	
	matriz_8:ENTITY work.Calculo_addres_astero
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_8(19 DOWNTO 10),
				  pos_y=>y_reg_8(18 DOWNTO 10),
				  addres_read=>address_read_8,
				  ancho_mem=>ancho_mem_8,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_8,
				  enable_y=>enable_y_8,
				  cuat0_ancho=>"111010101");
	matriz_9:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_9(19 DOWNTO 10),
				  pos_y=>y_reg_9(18 DOWNTO 10),
				  addres_read=>address_read_9,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_9,
				  enable_y=>enable_y_9,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_10<= "11001" WHEN  fase_2="001" OR fase_2="011" ELSE
					  "01100";
	
	matriz_10:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_10(19 DOWNTO 10),
				  pos_y=>y_reg_10(18 DOWNTO 10),
				  addres_read=>address_read_10,
				  ancho_mem=>ancho_mem_10,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_10,
				  enable_y=>enable_y_10,
				  cuat0_ancho=>"111010101");
				 
	matriz_11:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_11(19 DOWNTO 10),
				  pos_y=>y_reg_11(18 DOWNTO 10),
				  addres_read=>address_read_11,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_11,
				  enable_y=>enable_y_11,
				  cuat0_ancho=>"111010101");
				  
	ancho_mem_12<= "110010" WHEN  fase_3= "000" 			 		 ELSE
					  "011001" WHEN  fase_3="001" OR fase_3="011" ELSE
					  "001100";	
	matriz_12:ENTITY work.Calculo_addres_astero
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_12(19 DOWNTO 10),
				  pos_y=>y_reg_12(18 DOWNTO 10),
				  addres_read=>address_read_12,
				  ancho_mem=>ancho_mem_12,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_12,
				  enable_y=>enable_y_12,
				  cuat0_ancho=>"111010101");
				 
	matriz_13:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_13(19 DOWNTO 10),
				  pos_y=>y_reg_13(18 DOWNTO 10),
				  addres_read=>address_read_13,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_13,
				  enable_y=>enable_y_13,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_14<= "11001" WHEN  fase_3="001" OR fase_3="011" ELSE
					  "01100";
	
	matriz_14:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_14(19 DOWNTO 10),
				  pos_y=>y_reg_14(18 DOWNTO 10),
				  addres_read=>address_read_14,
				  ancho_mem=>ancho_mem_14,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_14,
				  enable_y=>enable_y_14,
				  cuat0_ancho=>"111010101");
	matriz_15:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_15(19 DOWNTO 10),
				  pos_y=>y_reg_15(18 DOWNTO 10),
				  addres_read=>address_read_15,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_15,
				  enable_y=>enable_y_15,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_16<= "110010" WHEN  fase_4= "000" 			 		 ELSE
					  "011001" WHEN  fase_4="001" OR fase_4="011" ELSE
					  "001100";	
	
	matriz_16:ENTITY work.Calculo_addres_astero
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_16(19 DOWNTO 10),
				  pos_y=>y_reg_16(18 DOWNTO 10),
				  addres_read=>address_read_16,
				  ancho_mem=>ancho_mem_16,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_16,
				  enable_y=>enable_y_16,
				  cuat0_ancho=>"111010101");
				 
	matriz_17:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_17(19 DOWNTO 10),
				  pos_y=>y_reg_17(18 DOWNTO 10),
				  addres_read=>address_read_17,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_17,
				  enable_y=>enable_y_17,
				  cuat0_ancho=>"111010101");
				  
	ancho_mem_18<= "11001" WHEN  fase_4="001" OR fase_4="011" ELSE
					  "01100";
	matriz_18:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_18(19 DOWNTO 10),
				  pos_y=>y_reg_18(18 DOWNTO 10),
				  addres_read=>address_read_18,
				  ancho_mem=>ancho_mem_18,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_18,
				  enable_y=>enable_y_18,
				  cuat0_ancho=>"111010101");
				 
	matriz_19:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_19(19 DOWNTO 10),
				  pos_y=>y_reg_19(18 DOWNTO 10),
				  addres_read=>address_read_19,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_19,
				  enable_y=>enable_y_19,
				  cuat0_ancho=>"111010101");
				 
	ancho_mem_20<= "110010" WHEN  fase_5= "000" 			 		 ELSE
					  "011001" WHEN  fase_5="001" OR fase_5="011" ELSE
					  "001100";	
					  
	matriz_20:ENTITY work.Calculo_addres_astero
	GENERIC MAP(BIT_WIDTH => 6)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_20(19 DOWNTO 10),
				  pos_y=>y_reg_20(18 DOWNTO 10),
				  addres_read=>address_read_20,
				  ancho_mem=>ancho_mem_20,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_20,
				  enable_y=>enable_y_20,
				  cuat0_ancho=>"111010101");
	matriz_21:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_21(19 DOWNTO 10),
				  pos_y=>y_reg_21(18 DOWNTO 10),
				  addres_read=>address_read_21,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_21,
				  enable_y=>enable_y_21,
				  cuat0_ancho=>"111010101");
	
	ancho_mem_22<= "11001" WHEN  fase_5="001" OR fase_5="011" ELSE
					  "01100";
	
	matriz_22:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 5)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_22(19 DOWNTO 10),
				  pos_y=>y_reg_22(18 DOWNTO 10),
				  addres_read=>address_read_22,
				  ancho_mem=>ancho_mem_22,
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_22,
				  enable_y=>enable_y_22,
				  cuat0_ancho=>"111010101");
				 
	matriz_23:ENTITY work.Calculo_addres_read
	GENERIC MAP(BIT_WIDTH => 4)
	PORT MAP ( x_lect=>x_lect,
				  y_lect=>y_lect,
				  pos_x=>x_reg_23(19 DOWNTO 10),
				  pos_y=>y_reg_23(18 DOWNTO 10),
				  addres_read=>address_read_23,
				  ancho_mem=>"1100",
				  seis1_ancho=>"1001110110",
				  seis0_ancho=>"1001110101",
				  cuat1_ancho=>"111010110",
				  enable_x=>enable_x_23,
				  enable_y=>enable_y_23,
				  cuat0_ancho=>"111010101");
				 

	 
------------------------------------------------------------------------------------------------------------------------------------------------------------
	break:ENTITY work.Romper
	PORT MAP (y_pos_anterior   => y_actual_anterior(18 DOWNTO 10),
				 x_pos_anterior   => x_actual_anterior(19 DOWNTO 10),
				 x_pos_out  	   => x_pos_romper,
				 y_pos_out   		=> y_pos_romper,
				 fase_0   			=> fase_0,
				 fase_1   			=> fase_1,
				 fase_2   			=> fase_2,
				 fase_3   			=> fase_3,
				 fase_4   			=> fase_4,
				 fase_5   			=> fase_5,
				 count_24   		=> count_24,
				 numero   			=> numero,
				 angulo  			=> address_trig,
				 N   					=> "000100",
				 angulo_new   		=> ang_romper);
------------------------------------------------------------------------------------------------------------------------------------------------------------
	alea:ENTITY work.Aleatorio
	PORT MAP ( clk      			 => clk,
				  rst      			 => rst,
				  N_asteroide      => count_as,
				  chopper_6  		 => chopper,
				  angulo_aleatorio => ang_aleatorio,
				  x_nave      		 => x_nave,
				  y_nave      		 => y_nave,
				  pos_x 				 => x_pos_aleatorio,
				  pos_y  			 => y_pos_aleatorio);


------------------------------------------------------------------------------------------------------------------------------------------------------------
	cont_24:ENTITY work.contador_uni
	GENERIC MAP(N => 5)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_24,
				  ini      => "00000",
				  ena      => ena_24,
				  max      => "10111",
				  max_tick => max_tick_24,
				  counter  => count_24);
------------------------------------------------------------------------------------------------------------------------------------------------------------
	cont_As:ENTITY work.contador_uni
	GENERIC MAP(N => 3)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_asteroid,
				  ini      => "000",
				  max_tick =>max_tick_as,
				  ena      => ena_asteroid,
				  max      => "101",
				  counter  => count_as);
------------------------------------------------------------------------------------------------------------------------------------------------------------
	fsm:ENTITY work.fsm_asteroide
	PORT MAP ( clk   					=> clk,
				  rst   					=> rst,
				  signal_16_m   		=> signal_16_m,  
				  perder   				=> perder,
				  new_level			   => new_level,
				  max_tick_as   		=> max_tick_as,
				  max_tick_24   		=> max_tick_24,
				  chopper   			=> chopper,
				  syn_asteroid   		=> syn_asteroid,
				  ena_asteroid   		=> ena_asteroid,
				  ena_write   			=> ena_write,
				  ena_reg_G   			=> ena_reg_G,
				  ena_24   				=> ena_24,
				  syn_24   				=> syn_24,
				  numero   				=> numero,
				  ena_mover   			=> ena_mover,
				  ena_mover_2   		=> ena_mover_2,
				  signal_count       => signal_count,
				  ena_creacion   		=> ena_creacion);

------------------------------------------------------------------------------------------------------------------------------------------------------------

	vel_ini_x<=  STD_LOGIC_VECTOR(UNSIGNED('0' & sum_pos_x)+UNSIGNED(mul_sen(22)&mul_sen(18 DOWNTO 0) & '0'));

	pos_sign_x<='0' & x_pos_romper					 											WHEN  ena_creacion='1'											            ELSE
					  '0'&x_pos_aleatorio					 										WHEN  ena_reg_G='1'   											            ELSE
						 STD_LOGIC_VECTOR(UNSIGNED(vel_ini_x)-"010011111110000000000") WHEN (vel_ini_x(20)='0') AND (vel_ini_x >"010011111110000000000") ELSE
						 STD_LOGIC_VECTOR("010011111110000000000"+UNSIGNED(vel_ini_x)) WHEN (vel_ini_x(20)='1') AND (vel_ini_x >"010011111110000000000") ELSE
						 vel_ini_x; 
						 
	x_sign_0<= pos_sign_x(19 DOWNTO 0); 
	x_sign_1<= pos_sign_x(19 DOWNTO 0); 
	x_sign_2<= pos_sign_x(19 DOWNTO 0); 
	x_sign_3<= pos_sign_x(19 DOWNTO 0); 
	x_sign_4<= pos_sign_x(19 DOWNTO 0); 
	x_sign_5<= pos_sign_x(19 DOWNTO 0); 
	x_sign_6<= pos_sign_x(19 DOWNTO 0); 
	x_sign_7<= pos_sign_x(19 DOWNTO 0); 
	x_sign_8<= pos_sign_x(19 DOWNTO 0); 
	x_sign_9<= pos_sign_x(19 DOWNTO 0); 
	x_sign_10<= pos_sign_x(19 DOWNTO 0); 
	x_sign_11<= pos_sign_x(19 DOWNTO 0);
	x_sign_12<= pos_sign_x(19 DOWNTO 0);
	x_sign_13<= pos_sign_x(19 DOWNTO 0);
	x_sign_14<= pos_sign_x(19 DOWNTO 0);
	x_sign_15<= pos_sign_x(19 DOWNTO 0);
	x_sign_16<= pos_sign_x(19 DOWNTO 0);
	x_sign_17<= pos_sign_x(19 DOWNTO 0);
	x_sign_18<= pos_sign_x(19 DOWNTO 0);
	x_sign_19<= pos_sign_x(19 DOWNTO 0);
	x_sign_20<= pos_sign_x(19 DOWNTO 0);
	x_sign_21<= pos_sign_x(19 DOWNTO 0);
	x_sign_22<= pos_sign_x(19 DOWNTO 0);
	x_sign_23<= pos_sign_x(19 DOWNTO 0);


	vel_ini_y<=  STD_LOGIC_VECTOR(UNSIGNED('0' & sum_pos_y)+UNSIGNED(mul_cos(22)&mul_cos(17 DOWNTO 0) & '0'));

	pos_sign_y<='0' & y_pos_romper					 										  WHEN  ena_creacion='1'											        ELSE
					  '0'&y_pos_aleatorio					 									  WHEN  ena_reg_G='1'   											        ELSE
						 STD_LOGIC_VECTOR(UNSIGNED(vel_ini_y)-"01110111110000000000") WHEN (vel_ini_y(19)='0') AND vel_ini_y >"01110111110000000000" ELSE
						 STD_LOGIC_VECTOR("01110111110000000000"+UNSIGNED(vel_ini_y)) WHEN (vel_ini_y(19)='1') AND vel_ini_y >"01110111110000000000" ELSE
						 vel_ini_y; 
						 
	y_sign_0<= pos_sign_y(18 DOWNTO 0); 
	y_sign_1<= pos_sign_y(18 DOWNTO 0);  
	y_sign_2<= pos_sign_y(18 DOWNTO 0);  
	y_sign_3<= pos_sign_y(18 DOWNTO 0); 
	y_sign_4<=pos_sign_y(18 DOWNTO 0); 
	y_sign_5<= pos_sign_y(18 DOWNTO 0);  
	y_sign_6<= pos_sign_y(18 DOWNTO 0);  
	y_sign_7<= pos_sign_y(18 DOWNTO 0);  
	y_sign_8<= pos_sign_y(18 DOWNTO 0);  
	y_sign_9<= pos_sign_y(18 DOWNTO 0);  
	y_sign_10<=pos_sign_y(18 DOWNTO 0); 
	y_sign_11<= pos_sign_y(18 DOWNTO 0); 
	y_sign_12<= pos_sign_y(18 DOWNTO 0); 
	y_sign_13<= pos_sign_y(18 DOWNTO 0); 
	y_sign_14<= pos_sign_y(18 DOWNTO 0); 
	y_sign_15<= pos_sign_y(18 DOWNTO 0); 
	y_sign_16<= pos_sign_y(18 DOWNTO 0); 
	y_sign_17<= pos_sign_y(18 DOWNTO 0); 
	y_sign_18<= pos_sign_y(18 DOWNTO 0); 
	y_sign_19<= pos_sign_y(18 DOWNTO 0); 
	y_sign_20<= pos_sign_y(18 DOWNTO 0); 
	y_sign_21<= pos_sign_y(18 DOWNTO 0); 
	y_sign_22<= pos_sign_y(18 DOWNTO 0); 
	y_sign_23<= pos_sign_y(18 DOWNTO 0);   

	sum_pos_x<= x_reg_0 WHEN count_24="00000" ELSE
					x_reg_1 WHEN count_24="00001" ELSE
					x_reg_2 WHEN count_24="00010" ELSE
					x_reg_3 WHEN count_24="00011" ELSE
					x_reg_4 WHEN count_24="00100" ELSE
					x_reg_5 WHEN count_24="00101" ELSE
					x_reg_6 WHEN count_24="00110" ELSE
					x_reg_7 WHEN count_24="00111" ELSE
					x_reg_8 WHEN count_24="01000" ELSE
					x_reg_9 WHEN count_24="01001" ELSE
					x_reg_10 WHEN count_24="01010" ELSE
					x_reg_11 WHEN count_24="01011" ELSE
					x_reg_12 WHEN count_24="01100" ELSE
					x_reg_13 WHEN count_24="01101" ELSE
					x_reg_14 WHEN count_24="01110" ELSE
					x_reg_15 WHEN count_24="01111" ELSE
					x_reg_16 WHEN count_24="10000" ELSE
					x_reg_17 WHEN count_24="10001" ELSE
					x_reg_18 WHEN count_24="10010" ELSE
					x_reg_19 WHEN count_24="10011" ELSE
					x_reg_20 WHEN count_24="10100" ELSE
					x_reg_21 WHEN count_24="10101" ELSE
					x_reg_22 WHEN count_24="10110" ELSE
					x_reg_23;

	sum_pos_y<= y_reg_0 WHEN count_24="00000" ELSE
					y_reg_1 WHEN count_24="00001" ELSE
					y_reg_2 WHEN count_24="00010" ELSE
					y_reg_3 WHEN count_24="00011" ELSE
					y_reg_4 WHEN count_24="00100" ELSE
					y_reg_5 WHEN count_24="00101" ELSE
					y_reg_6 WHEN count_24="00110" ELSE
					y_reg_7 WHEN count_24="00111" ELSE
					y_reg_8 WHEN count_24="01000" ELSE
					y_reg_9 WHEN count_24="01001" ELSE
					y_reg_10 WHEN count_24="01010" ELSE
					y_reg_11 WHEN count_24="01011" ELSE
					y_reg_12 WHEN count_24="01100" ELSE
					y_reg_13 WHEN count_24="01101" ELSE
					y_reg_14 WHEN count_24="01110" ELSE
					y_reg_15 WHEN count_24="01111" ELSE
					y_reg_16 WHEN count_24="10000" ELSE
					y_reg_17 WHEN count_24="10001" ELSE
					y_reg_18 WHEN count_24="10010" ELSE
					y_reg_19 WHEN count_24="10011" ELSE
					y_reg_20 WHEN count_24="10100" ELSE
					y_reg_21 WHEN count_24="10101" ELSE
					y_reg_22 WHEN count_24="10110" ELSE
					y_reg_23;
------------------------------------------------------------------------------------------------------------------------------------------------------------
	x_pos0:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(0),  
				  sign  => x_sign_0,
				  reg   => x_reg_0);
				  
	x_pos1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(1),  
				  sign  => x_sign_1,
				  reg   => x_reg_1);
	x_pos2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(2),  
				  sign  => x_sign_2,
				  reg   => x_reg_2);
	x_pos3:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(3),  
				  sign  => x_sign_3,
				  reg   => x_reg_3);
	x_pos4:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(4),  
				  sign  => x_sign_4,
				  reg   => x_reg_4);
	x_pos5:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(5),  
				  sign  => x_sign_5,
				  reg   => x_reg_5);
	x_pos6:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(6),  
				  sign  => x_sign_6,
				  reg   => x_reg_6);
	x_pos7:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(7),  
				  sign  => x_sign_7,
				  reg   => x_reg_7);
	x_pos8:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(8),  
				  sign  => x_sign_8,
				  reg   => x_reg_8);
	x_pos9:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(9),  
				  sign  => x_sign_9,
				  reg   => x_reg_9);
	x_pos10:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(10),  
				  sign  => x_sign_10,
				  reg   => x_reg_10);
	x_pos11:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(11),  
				  sign  => x_sign_11,
				  reg   => x_reg_11);
	x_pos12:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(12),  
				  sign  => x_sign_12,
				  reg   => x_reg_12);
	x_pos13:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(13),  
				  sign  => x_sign_13,
				  reg   => x_reg_13);
	x_pos14:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(14),  
				  sign  => x_sign_14,
				  reg   => x_reg_14);
	x_pos15:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(15),  
				  sign  => x_sign_15,
				  reg   => x_reg_15);
	x_pos16:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(16),  
				  sign  => x_sign_16,
				  reg   => x_reg_16);
	x_pos17:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(17),  
				  sign  => x_sign_17,
				  reg   => x_reg_17);
	x_pos18:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(18),  
				  sign  => x_sign_18,
				  reg   => x_reg_18);
	x_pos19:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(19),  
				  sign  => x_sign_19,
				  reg   => x_reg_19);
	x_pos20:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(20),  
				  sign  => x_sign_20,
				  reg   => x_reg_20);
	x_pos21:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(21),  
				  sign  => x_sign_21,
				  reg   => x_reg_21);
	x_pos22:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(22),  
				  sign  => x_sign_22,
				  reg   => x_reg_22);
	x_pos23:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 20)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(23),  
				  sign  => x_sign_23,
				  reg   => x_reg_23);
------------------------------------------------------------------------------------------------------------------------------------------------------------
	y_pos0:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(0),  
				  sign  => y_sign_0,
				  reg   => y_reg_0);
				  
	y_pos1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(1),  
				  sign  => y_sign_1,
				  reg   => y_reg_1);
	y_pos2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(2),  
				  sign  => y_sign_2,
				  reg   => y_reg_2);
	y_pos3:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(3),  
				  sign  => y_sign_3,
				  reg   => y_reg_3);
	y_pos4:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(4),  
				  sign  => y_sign_4,
				  reg   => y_reg_4);
	y_pos5:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(5),  
				  sign  => y_sign_5,
				  reg   => y_reg_5);
	y_pos6:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(6),  
				  sign  => y_sign_6,
				  reg   => y_reg_6);
	y_pos7:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(7),  
				  sign  => y_sign_7,
				  reg   => y_reg_7);
	y_pos8:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(8),  
				  sign  => y_sign_8,
				  reg   => y_reg_8);
	y_pos9:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(9),  
				  sign  => y_sign_9,
				  reg   => y_reg_9);
	y_pos10:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(10),  
				  sign  => y_sign_10,
				  reg   => y_reg_10);
	y_pos11:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(11),  
				  sign  => y_sign_11,
				  reg   => y_reg_11);
	y_pos12:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(12),  
				  sign  => y_sign_12,
				  reg   => y_reg_12);
	y_pos13:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(13),  
				  sign  => y_sign_13,
				  reg   => y_reg_13);
	y_pos14:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(14),  
				  sign  => y_sign_14,
				  reg   => y_reg_14);
	y_pos15:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(15),  
				  sign  => y_sign_15,
				  reg   => y_reg_15);
	y_pos16:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(16),  
				  sign  => y_sign_16,
				  reg   => y_reg_16);
	y_pos17:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(17),  
				  sign  => y_sign_17,
				  reg   => y_reg_17);
	y_pos18:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(18),  
				  sign  => y_sign_18,
				  reg   => y_reg_18);
	y_pos19:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(19),  
				  sign  => y_sign_19,
				  reg   => y_reg_19);
	y_pos20:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(20),  
				  sign  => y_sign_20,
				  reg   => y_reg_20);
	y_pos21:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(21),  
				  sign  => y_sign_21,
				  reg   => y_reg_21);
	y_pos22:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(22),  
				  sign  => y_sign_22,
				  reg   => y_reg_22);
	y_pos23:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 19)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena(23),  
				  sign  => y_sign_23,
				  reg   => y_reg_23);

------------------------------------------------------------------------------------------------------------------------------------------------------------
	vel <=   "01" WHEN nivel ="00" ELSE 
				"10" WHEN nivel ="01" ELSE 
				"11"; 
	
	mu_cos:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => cos_angulo,
				  data_b  => velocidad,
				  multi   => mul_cos);	
------------------------------------------------------------------------------------------------------------------------------------------------------------
	velocidad <= "0000000000"&vel;
	
	mu_sen:ENTITY work.Miltiplicador_a2
	GENERIC MAP(N => 12)
	PORT MAP ( data_a  => sen_angulo,
				  data_b  => velocidad,
				  multi   => mul_sen);	
------------------------------------------------------------------------------------------------------------------------------------------------------------
	data_ang_write<= ang_aleatorio WHEN (ena_reg_G='1' OR signal_count='1') ELSE
						  ang_romper;
	
	memo_ram:ENTITY work.SPRAM
	GENERIC MAP(DATA_WIDTH => 6,
					ADDR_WIDTH => 6)
	PORT MAP ( clk      		=> clk,
				  W_data       =>data_ang_write,
				  r_data       =>address_trig,
				  addr_read    =>addres_read_ang,
				  addr     	   =>addres_write_ang,
				  Wr_rdn     	=> ena_write);	

------------------------------------------------------------------------------------------------------------------------------------------------------------
	memo_sen:ENTITY work.Memoria_seno
	GENERIC MAP(DATA_WIDTH => 12,
					ADDR_WIDTH => 6)
	PORT MAP ( clk      => clk,
				  addr     =>address_trig,
				  r_data   =>sen_angulo);
	
	memo_cos:ENTITY work.Memoria_coseno
	GENERIC MAP(DATA_WIDTH => 12,
					ADDR_WIDTH => 6)
	PORT MAP ( clk      => clk,
				  addr     =>address_trig,
				  r_data   =>cos_angulo);

------------------------------------------------------------------------------------------------------------------------------------------------------------
	fase0:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_0,  
				  sign  => fase_sign_0,
				  reg   => fase_0);
	
	fase1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_1, 
				  sign  => fase_sign_1,
				  reg   => fase_1);	
	
	fase2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_2, 
				  sign  => fase_sign_2,
				  reg   => fase_2);
	
	fase3:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_3,  
				  sign  => fase_sign_3,
				  reg   => fase_3);	
	fase4:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_4,
				  sign  => fase_sign_4,
				  reg   => fase_4);	
	fase5:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 3)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => ena_fase_5, 
				  sign  => fase_sign_5,
				  reg   => fase_5);	

------------------------------------------------------------------------------------------------------------------------------------------------------------
	def_mux_1: FOR i IN 0 To 23 GENERATE
				cont:ENTITY work.my_dff
				PORT MAP ( clk      => clk,
							  rst      => rst,
							  en       => ena_habilitar_sign(i),
							  d        => habilitar_sign(i),
							  q        => habilitar_reg(i));
		  
		  END GENERATE;
------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	ena(0)<= '1'   WHEN ena_reg_G='1' AND count_as="000" 			ELSE
				'1'   WHEN cond(0)='1' 										ELSE
				'1'   WHEN ena_mover_2='1' AND count_24 = "00000" 	ELSE
				'0';
				
	ena(1)<=  '1'   WHEN cond(1)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00001" ELSE
				 '0';
	ena(2)<=  '1'   WHEN cond(2)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00010"	ELSE
				 '0';
	ena(3)<=  '1'   WHEN cond(3)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00011"	ELSE
				 '0';
						
						
						
	ena(4)<= '1' 	 WHEN ena_reg_G='1'   AND  count_as="001" 	ELSE
				'1'    WHEN cond(4)='1' 									ELSE
				'1'    WHEN ena_mover_2='1' AND  count_24 = "00100"ELSE
				'0';
	ena(5)<=  '1'   WHEN cond(5)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00101" ELSE
				 '0';
	ena(6)<=  '1'   WHEN cond(6)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00110"	ELSE
				 '0';
	ena(7)<=  '1'   WHEN cond(7)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "00111"	ELSE
				 '0';
						
						
						
	ena(8)<= '1'    WHEN ena_reg_G='1' AND  count_as="010" 		ELSE
				'1'    WHEN cond(8)='1' 									ELSE
				'1'    WHEN ena_mover_2='1' AND count_24 = "01000"	ELSE
				'0';
	ena(9)<=  '1'   WHEN cond(9)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01001" ELSE
				 '0';
	ena(10)<=  '1'   WHEN cond(10)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01010"	ELSE
				 '0';
	ena(11)<=  '1'   WHEN cond(11)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01011"	ELSE
				 '0';					
						
						
	ena(12)<= '1'   WHEN ena_reg_G='1'  AND  count_as="011" 		ELSE
				 '1'    WHEN cond(12)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01100" ELSE
				 '0';
	ena(13)<=  '1'   WHEN cond(13)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01101" ELSE
				 '0';
	ena(14)<=  '1'   WHEN cond(14)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01110"	ELSE
				 '0';
	ena(15)<=  '1'   WHEN cond(15)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "01111"	ELSE
				 '0';	
						
						
						
	ena(16)<= '1'    WHEN ena_reg_G='1' AND  count_as="100"      ELSE
				 '1'    WHEN cond(16)='1' 									 ELSE
				 '1'    WHEN ena_mover_2='1' AND count_24 = "10000" ELSE
				 '0';
	ena(17)<=  '1'   WHEN cond(17)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10001" ELSE
				 '0';
	ena(18)<=  '1'   WHEN cond(18)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10010"	ELSE
				 '0';
	ena(19)<=  '1'   WHEN cond(19)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10011"	ELSE
				 '0';	
						
						
						
	ena(20)<= '1'    WHEN ena_reg_G='1' AND  count_as="101"      ELSE
				 '1'    WHEN ena_mover_2='1' AND count_24 = "10100" ELSE
				 '1'    WHEN cond(20)='1' 									 ELSE
				 '0';
	ena(21)<= '1'   WHEN cond(21)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10101" ELSE
				 '0';
	ena(22)<=  '1'  WHEN cond(22)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10110"	ELSE
				 '0';
	ena(23)<=  '1'  WHEN cond(23)='1' 									ELSE
				 '1'   WHEN ena_mover_2='1' AND count_24 = "10111"	ELSE
				 '0';			
------------------------------------------------------------------------------------------------------------------------------------------------------------

	cond(0)<= '1' WHEN ena_creacion='1' AND chopper(0)='1' AND numero = '0' ELSE
             '0';
	cond(1)<= '1' WHEN  ena_creacion='1' AND chopper(0)='1' AND(fase_0="001" OR fase_0="011") AND numero ='1' ELSE
			    '0';
	cond(2)<= '1' WHEN  ena_creacion='1' AND ((chopper(0)='1' AND(fase_0="000") AND numero ='1') AND (chopper(2)='1' AND(fase_0="010" OR fase_0="001") AND numero ='0')) ELSE 
				 '0';
	cond(3)<= '1' WHEN  ena_creacion='1' AND chopper(2)='1' AND(fase_0="001" OR fase_0="010") AND numero ='1' ELSE
				 '0';
				 
	cond(4)<= '1' WHEN  ena_creacion='1' AND chopper(4)='1' AND numero = '0' ELSE
             '0';
	cond(5)<= '1' WHEN  ena_creacion='1' AND chopper(4)='1' AND(fase_1="001" OR fase_1="011") AND numero ='1' ELSE
			    '0';
	cond(6)<= '1' WHEN  ena_creacion='1' AND ((chopper(4)='1' AND(fase_1="000") AND numero ='1') AND (chopper(6)='1' AND(fase_1="010" OR fase_1="001") AND numero ='0')) ELSE 
				 '0';
	cond(7)<= '1' WHEN  ena_creacion='1' AND chopper(6)='1' AND(fase_1="001" OR fase_1="010") AND numero ='1' ELSE
				 '0';
				 
	cond(8)<= '1' WHEN  ena_creacion='1' AND chopper(8)='1' AND numero = '0' ELSE
             '0';
	cond(9)<= '1' WHEN  ena_creacion='1' AND chopper(8)='1' AND(fase_2="001" OR fase_2="011") AND numero ='1' ELSE
			    '0';
	cond(10)<='1' WHEN  ena_creacion='1' AND ((chopper(8)='1' AND(fase_2="000") AND numero ='1') AND (chopper(10)='1' AND(fase_2="010" OR fase_2="001") AND numero ='0')) ELSE 
				 '0';
	cond(11)<='1' WHEN  ena_creacion='1' AND chopper(10)='1' AND(fase_2="001" OR fase_2="010") AND numero ='1' ELSE
				 '0';
				 
	cond(12)<= '1' WHEN ena_creacion='1' AND chopper(12)='1' AND numero = '0' ELSE
             '0';
	cond(13)<= '1' WHEN  ena_creacion='1' AND chopper(12)='1' AND(fase_3="001" OR fase_3="011") AND numero ='1' ELSE
			    '0';
	cond(14)<= '1' WHEN  ena_creacion='1' AND ((chopper(12)='1' AND(fase_3="000") AND numero ='1') AND (chopper(14)='1' AND(fase_3="010" OR fase_3="001") AND numero ='0')) ELSE 
				 '0';
	cond(15)<= '1' WHEN  ena_creacion='1' AND chopper(14)='1' AND(fase_3="001" OR fase_3="010") AND numero ='1' ELSE
				 '0';
	
	cond(16)<= '1' WHEN ena_creacion='1' AND chopper(16)='1' AND numero = '0' ELSE
             '0';
	cond(17)<= '1' WHEN  ena_creacion='1' AND chopper(16)='1' AND(fase_4="001" OR fase_4="011") AND numero ='1' ELSE
			    '0';
	cond(18)<= '1' WHEN  ena_creacion='1' AND ((chopper(16)='1' AND(fase_4="000") AND numero ='1') AND (chopper(18)='1' AND(fase_4="010" OR fase_4="001") AND numero ='0')) ELSE 
				 '0';
	cond(19)<= '1' WHEN  ena_creacion='1' AND chopper(18)='1' AND(fase_4="001" OR fase_4="010") AND numero ='1' ELSE
				 '0';
				 
	cond(20)<= '1' WHEN ena_creacion='1' AND chopper(20)='1' AND numero = '0' ELSE
             '0';
	cond(21)<= '1' WHEN  ena_creacion='1' AND chopper(20)='1' AND(fase_5="001" OR fase_5="011") AND numero ='1' ELSE
			    '0';
	cond(22)<= '1' WHEN  ena_creacion='1' AND ((chopper(20)='1' AND(fase_5="000") AND numero ='1') AND (chopper(22)='1' AND(fase_5="010" OR fase_5="001") AND numero ='0')) ELSE 
				 '0';
	cond(23)<= '1' WHEN  ena_creacion='1' AND chopper(22)='1' AND(fase_5="001" OR fase_5="010") AND numero ='1' ELSE
				 '0';
				 
------------------------------------------------------------------------------------------------------------------------------------------------------------
	ena_mover_c<= ena_mover OR ena_mover_2;
	
	addres_read_ang<= "000000"   WHEN (Fase_0="000" AND (cond(0)='1' OR cond(2)='1')) OR  (ena_mover_c='1' AND count_24="00000" AND fase_0="000")													ELSE
							"000001"   WHEN ((Fase_0="001" OR Fase_0="011") AND (cond(0)='1' OR cond(1)='1')) OR  (ena_mover_c='1' AND count_24="00000" AND (fase_0="001" OR fase_0="011")) ELSE
							"000010"	  WHEN (ena_mover_c='1' AND count_24="00000" AND (fase_0="010" OR fase_0="100"))																					ELSE
							"000011"	  WHEN (ena_mover_c='1' AND count_24="00001")																																	ELSE
							"000100"   WHEN ((Fase_0="001" OR Fase_0="010") AND (cond(2)='1' OR cond(3)='1')) OR (ena_mover_c='1' AND count_24="00010" AND (fase_0="001" OR fase_0="010"))  ELSE
							"000101"	  WHEN (ena_mover_c='1' AND count_24="00010" AND (fase_0="011" OR fase_0="100"))																					ELSE
							"000110"	  WHEN (ena_mover_c='1' AND count_24="00011")																																	ELSE
							"001000"   WHEN (Fase_1="000" AND (cond(4)='1' OR cond(6)='1')) OR  (ena_mover_c='1' AND count_24="00100" AND fase_1="000")													ELSE
							"001001"   WHEN ((Fase_1="001" OR Fase_1="011") AND (cond(4)='1' OR cond(5)='1')) OR  (ena_mover_c='1' AND count_24="00100" AND (fase_1="001" OR fase_1="011")) ELSE
							"001010"	  WHEN (ena_mover_c='1' AND count_24="00100" AND (fase_1="010" OR fase_1="100"))																					ELSE
							"001011"	  WHEN (ena_mover_c='1' AND count_24="00101")																																	ELSE
							"001100"   WHEN ((Fase_1="001" OR  Fase_1="010") AND (cond(6)='1' OR cond(7)='1')) OR (ena_mover_c='1' AND count_24="00110" AND (fase_1="001" OR fase_1="010")) ELSE
							"001101"	  WHEN (ena_mover_c='1' AND count_24="00110" AND (fase_1="011" OR fase_1="100"))																					ELSE
							"001110"	  WHEN (ena_mover_c='1' AND count_24="00111")																																	ELSE	
							"010000"   WHEN (Fase_2="000" AND (cond(8)='1' OR cond(10)='1')) OR  (ena_mover_c='1' AND count_24="01000" AND fase_2="000")												ELSE
							"010001"   WHEN ((Fase_2="001" OR Fase_2="011") AND (cond(8)='1' OR cond(9)='1')) OR  (ena_mover_c='1' AND count_24="01000" AND (fase_2="001" OR fase_2="011")) ELSE
							"010010"	  WHEN (ena_mover_c='1' AND count_24="01000" AND (fase_2="010" OR fase_2="100"))																					ELSE
							"010011"	  WHEN (ena_mover_c='1' AND count_24="01001")																																	ELSE
							"010100"   WHEN ((Fase_2="001" OR  Fase_2="010") AND (cond(10)='1' OR cond(11)='1')) OR (ena_mover_c='1' AND count_24="01010" AND (fase_2="001" OR fase_2="010"))ELSE
							"010101"	  WHEN (ena_mover_c='1' AND count_24="01010" AND (fase_2="011" OR fase_2="100"))																					ELSE
							"010110"	  WHEN (ena_mover_c='1' AND count_24="01011")																																	ELSE	
							"011000"   WHEN (Fase_3="000" AND (cond(12)='1' OR cond(14)='1')) OR  (ena_mover_c='1' AND count_24="01100" AND fase_3="000")												ELSE
							"011001"   WHEN ((Fase_3="001" OR Fase_3="011") AND (cond(12)='1' OR cond(13)='1')) OR  (ena_mover_c='1' AND count_24="01100" AND (fase_3="001" OR fase_3="011")) ELSE
							"011010"	  WHEN (ena_mover_c='1' AND count_24="01100" AND (fase_3="010" OR fase_3="100"))																					ELSE
							"011011"	  WHEN (ena_mover_c='1' AND count_24="01101")																																	ELSE
							"011100"   WHEN ((Fase_3="001" OR  Fase_3="010") AND (cond(14)='1' OR cond(15)='1')) OR (ena_mover_c='1' AND count_24="01110" AND (fase_3="001" OR fase_3="010"))ELSE
							"011101"	  WHEN (ena_mover_c='1' AND count_24="01110" AND (fase_3="011" OR fase_3="100"))																					ELSE
							"011110"	  WHEN (ena_mover_c='1' AND count_24="01111")																																	ELSE
							"100000"   WHEN (Fase_4="000" AND (cond(16)='1' OR cond(18)='1')) OR  (ena_mover_c='1' AND count_24="10000" AND fase_4="000")												ELSE
							"100001"   WHEN ((Fase_4="001" OR Fase_4="011") AND (cond(16)='1' OR cond(17)='1')) OR  (ena_mover_c='1' AND count_24="10000" AND (fase_4="001" OR fase_4="011")) ELSE
							"100010"	  WHEN (ena_mover_c='1' AND count_24="10000" AND (fase_4="010" OR fase_4="100"))																					ELSE
							"100011"	  WHEN (ena_mover_c='1' AND count_24="10001")																																	ELSE
							"100100"   WHEN ((Fase_4="001" OR  Fase_4="010") AND (cond(18)='1' OR cond(19)='1')) OR (ena_mover_c='1' AND count_24="10010" AND (fase_4="001" OR fase_4="010"))ELSE
							"100101"	  WHEN (ena_mover_c='1' AND count_24="10010" AND (fase_4="011" OR fase_4="100"))																					ELSE
							"100110"	  WHEN (ena_mover_c='1' AND count_24="10011")																																	ELSE
							"101000"   WHEN (Fase_5="000" AND (cond(16)='1' OR cond(18)='1')) OR  (ena_mover_c='1' AND count_24="10100" AND fase_5="000")												ELSE
							"101001"   WHEN ((Fase_5="001" OR Fase_5="011") AND (cond(16)='1' OR cond(17)='1')) OR  (ena_mover_c='1' AND count_24="10100" AND (fase_5="001" OR fase_5="011")) ELSE
							"101010"	  WHEN (ena_mover_c='1' AND count_24="10100" AND (fase_5="010" OR fase_5="100"))																					ELSE
							"101011"	  WHEN (ena_mover_c='1' AND count_24="10101")																																	ELSE
							"101100"   WHEN ((Fase_5="001" OR  Fase_5="010") AND (cond(18)='1' OR cond(19)='1')) OR (ena_mover_c='1' AND count_24="10110" AND (fase_5="001" OR fase_5="010"))ELSE
							"101101"	  WHEN (ena_mover_c='1' AND count_24="10110" AND (fase_5="011" OR fase_5="100"))																					ELSE
							"101110"	  WHEN (ena_mover_c='1' AND count_24="10111")																																	ELSE
							"000000";
------------------------------------------------------------------------------------------------------------------------------------------------------------

	addres_write_ang<=   count_as & "000" 		WHEN   ena_reg_G='1'	OR signal_count='1'							 ELSE
                        "000001"             WHEN   (cond(0)='1') AND Fase_0="000"   							 ELSE
                        "000010"             WHEN   (cond(0)='1') AND (Fase_0="001" OR Fase_1="011")      ELSE
                        "000011"             WHEN   (cond(1)='1') AND (Fase_0="001" OR Fase_1="011")      ELSE
                        "000100"             WHEN   (cond(2)='1') AND  Fase_0="000"                       ELSE
                        "000101"             WHEN   (cond(2)='1') AND (Fase_0="001" OR Fase_1="010")      ELSE
                        "000110"             WHEN   (cond(3)='1') AND (Fase_0="001" OR Fase_1="010")      ELSE	
								"001001"             WHEN   (cond(4)='1') AND Fase_1="000"   							 ELSE
                        "001010"             WHEN   (cond(4)='1') AND (Fase_1="001" OR Fase_1="011")      ELSE
                        "001011"             WHEN   (cond(5)='1') AND (Fase_1="001" OR Fase_1="011")      ELSE
                        "001100"             WHEN   (cond(6)='1') AND  Fase_1="000"                       ELSE
                        "001101"             WHEN   (cond(6)='1') AND (Fase_1="001" OR Fase_1="010")      ELSE
                        "001110"             WHEN   (cond(7)='1') AND (Fase_1="001" OR Fase_1="010")      ELSE			
								"010001"             WHEN   (cond(8)='1') AND Fase_2="000"   							 ELSE
                        "010010"             WHEN   (cond(8)='1') AND (Fase_2="001" OR Fase_2="011")      ELSE
                        "010011"             WHEN   (cond(9)='1') AND (Fase_2="001" OR Fase_2="011")      ELSE
                        "010100"             WHEN   (cond(10)='1') AND  Fase_2="000"                      ELSE
                        "010101"             WHEN   (cond(10)='1') AND (Fase_2="001" OR Fase_2="010")     ELSE
                        "010110"             WHEN   (cond(11)='1') AND (Fase_2="001" OR Fase_2="010")     ELSE
							   "011001"             WHEN   (cond(12)='1') AND Fase_3="000"   							 ELSE
                        "011010"             WHEN   (cond(12)='1') AND (Fase_3="001" OR Fase_3="011")     ELSE
                        "011011"             WHEN   (cond(13)='1') AND (Fase_3="001" OR Fase_3="011")     ELSE
                        "011100"             WHEN   (cond(14)='1') AND  Fase_3="000"                      ELSE
                        "011101"             WHEN   (cond(14)='1') AND (Fase_3="001" OR Fase_3="010")     ELSE
                        "011110"             WHEN   (cond(15)='1') AND (Fase_3="001" OR Fase_3="010")     ELSE
								"100001"             WHEN   (cond(16)='1') AND Fase_4="000"   							 ELSE
                        "100010"             WHEN   (cond(16)='1') AND (Fase_4="001" OR Fase_4="011")     ELSE
                        "100011"             WHEN   (cond(17)='1') AND (Fase_4="001" OR Fase_4="011")     ELSE
                        "100100"             WHEN   (cond(18)='1') AND  Fase_4="000"                      ELSE
                        "100101"             WHEN   (cond(18)='1') AND (Fase_4="001" OR Fase_4="010")     ELSE
                        "100110"             WHEN   (cond(19)='1') AND (Fase_4="001" OR Fase_4="010")     ELSE
								"101001"             WHEN   (cond(20)='1') AND Fase_5="000"   							 ELSE
                        "101010"             WHEN   (cond(20)='1') AND (Fase_5="001" OR Fase_5="011")     ELSE
                        "101011"             WHEN   (cond(21)='1') AND (Fase_5="001" OR Fase_5="011")     ELSE
                        "101100"             WHEN   (cond(22)='1') AND  Fase_5="000"                      ELSE
                        "101101"             WHEN   (cond(22)='1') AND (Fase_5="001" OR Fase_5="010")     ELSE
                        "101110"             WHEN   (cond(23)='1') AND (Fase_5="001" OR Fase_5="010")     ELSE
                        "000000";

------------------------------------------------------------------------------------------------------------------------------------------------------------								
		ena_fase_0<= '1' WHEN fase_sign_0 /="111" ELSE
                   '0';
		ena_fase_1<= '1' WHEN fase_sign_1 /="111" ELSE
                   '0';
		ena_fase_2<= '1' WHEN fase_sign_2 /="111" ELSE
                   '0';
		ena_fase_3<= '1' WHEN fase_sign_3 /="111" ELSE
                   '0';
		ena_fase_4<= '1' WHEN fase_sign_4 /="111" ELSE
                   '0';
		ena_fase_5<= '1' WHEN fase_sign_5 /="111" ELSE
                   '0';
------------------------------------------------------------------------------------------------------------------------------------------------------------
		x_actual_anterior<= x_reg_0 WHEN  ((cond(0)='1' OR cond(2)='1') AND fase_0="000") OR((cond(0)='1' OR cond(1)='1') AND (fase_0="001" OR fase_0="011"))    ELSE   
                          x_reg_2 WHEN  (cond(2)='1' OR cond(3)='1')  AND (fase_0="001" OR fase_0="010")                                                       ELSE				  
								  x_reg_4 WHEN  ((cond(4)='1' OR cond(6)='1') AND fase_1="000") OR((cond(4)='1' OR cond(5)='1') AND (fase_1="001" OR fase_1="011"))    ELSE   
                          x_reg_6 WHEN  (cond(6)='1' OR cond(7)='1')  AND (fase_1="001" OR fase_1="010")                                                       ELSE				  
								  x_reg_8 WHEN  ((cond(8)='1' OR cond(10)='1') AND fase_2="000") OR((cond(8)='1' OR cond(9)='1') AND (fase_2="001" OR fase_2="011"))   ELSE   
                          x_reg_10 WHEN  (cond(10)='1' OR cond(11)='1')  AND (fase_2="001" OR fase_2="010")                                                    ELSE			  
								  x_reg_12 WHEN  ((cond(12)='1' OR cond(14)='1') AND fase_3="000") OR((cond(12)='1' OR cond(13)='1') AND (fase_3="001" OR fase_3="011"))ELSE   
                          x_reg_14 WHEN  (cond(14)='1' OR cond(15)='1')  AND (fase_3="001" OR fase_3="010")                                                    ELSE			  
								  x_reg_16 WHEN  ((cond(16)='1' OR cond(18)='1') AND fase_4="000") OR((cond(16)='1' OR cond(17)='1') AND (fase_4="001" OR fase_4="011"))ELSE   
                          x_reg_18 WHEN  (cond(18)='1' OR cond(19)='1')  AND (fase_4="001" OR fase_4="010")                                                     ELSE  
								  x_reg_20 WHEN  ((cond(20)='1' OR cond(22)='1') AND fase_5="000") OR((cond(20)='1' OR cond(21)='1') AND (fase_5="001" OR fase_5="011"))ELSE   
                          x_reg_22;
								  
	   y_actual_anterior<= y_reg_0 WHEN  ((cond(0)='1' OR cond(2)='1') AND fase_0="000") OR((cond(0)='1' OR cond(1)='1') AND (fase_0="001" OR fase_0="011"))    ELSE   
                          y_reg_2 WHEN  (cond(2)='1' OR cond(3)='1')  AND (fase_0="001" OR fase_0="010")                                                       ELSE				  
								  y_reg_4 WHEN  ((cond(4)='1' OR cond(6)='1') AND fase_1="000") OR((cond(4)='1' OR cond(5)='1') AND (fase_1="001" OR fase_1="011"))    ELSE   
                          y_reg_6 WHEN  (cond(6)='1' OR cond(7)='1')  AND (fase_1="001" OR fase_1="010")                                                       ELSE				  
								  y_reg_8 WHEN  ((cond(8)='1' OR cond(10)='1') AND fase_2="000") OR((cond(8)='1' OR cond(9)='1') AND (fase_2="001" OR fase_2="011"))   ELSE   
                          y_reg_10 WHEN  (cond(10)='1' OR cond(11)='1')  AND (fase_2="001" OR fase_2="010")                                                    ELSE			  
								  y_reg_12 WHEN  ((cond(12)='1' OR cond(14)='1') AND fase_3="000") OR((cond(12)='1' OR cond(13)='1') AND (fase_3="001" OR fase_3="011"))ELSE   
                          y_reg_14 WHEN  (cond(14)='1' OR cond(15)='1')  AND (fase_3="001" OR fase_3="010")                                                    ELSE			  
								  y_reg_16 WHEN  ((cond(16)='1' OR cond(18)='1') AND fase_4="000") OR((cond(16)='1' OR cond(17)='1') AND (fase_4="001" OR fase_4="011"))ELSE   
                          y_reg_18 WHEN  (cond(18)='1' OR cond(19)='1')  AND (fase_4="001" OR fase_4="010")                                                     ELSE  
								  y_reg_20 WHEN  ((cond(20)='1' OR cond(22)='1') AND fase_5="000") OR((cond(20)='1' OR cond(21)='1') AND (fase_5="001" OR fase_5="011"))ELSE   
                          y_reg_22;
------------------------------------------------------------------------------------------------------------------------------------------------------------	

		fase_sign_0<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_0="000" AND chopper(0)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_0="001" AND chopper(0)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_0="001" AND chopper(2)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_0="010" AND chopper(2)='1')OR (fase_0="011" AND chopper(0)='1'))  ELSE
						  "111";	
					
		fase_sign_1<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_1="000" AND chopper(4)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_1="001" AND chopper(4)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_1="001" AND chopper(6)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_1="010" AND chopper(6)='1')OR (fase_1="011" AND chopper(4)='1'))  ELSE
						  "111";	
		fase_sign_2<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_2="000" AND chopper(8)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_2="001" AND chopper(8)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_2="001" AND chopper(10)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_2="010" AND chopper(10)='1')OR (fase_2="011" AND chopper(8)='1'))  ELSE
						  "111";	
		fase_sign_3<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_3="000" AND chopper(12)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_3="001" AND chopper(12)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_3="001" AND chopper(14)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_3="010" AND chopper(14)='1')OR (fase_3="011" AND chopper(12)='1'))  ELSE
						  "111";	
		fase_sign_4<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_4="000" AND chopper(16)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_4="001" AND chopper(16)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_4="001" AND chopper(18)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_4="010" AND chopper(18)='1')OR (fase_4="011" AND chopper(16)='1'))  ELSE
						  "111";	
		fase_sign_5<= "000" WHEN  ena_reg_G='1' ELSE
						  "001" WHEN  numero ='1' AND fase_5="000" AND chopper(20)='1' ELSE
						  "010" WHEN  numero ='1' AND fase_5="001" AND chopper(20)='1'  ELSE
						  "011" WHEN  numero ='1' AND fase_5="001" AND chopper(22)='1'  ELSE
						  "100" WHEN  numero ='1' AND ((fase_5="010" AND chopper(22)='1')OR (fase_5="011" AND chopper(20)='1'))  ELSE
						  "111";	
------------------------------------------------------------------------------------------------------------------------------------------------------------
      ena_habilitar_sign(0)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(0)='1') OR (chopper(0)='1' AND (fase_0="100" OR fase_0="010")) ELSE
										'0';  
		ena_habilitar_sign(1)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(1)='1') OR (chopper(1)='1' AND (fase_0="100" OR fase_0="010")) ELSE
										'0';  
		ena_habilitar_sign(2)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(2)='1') OR (chopper(2)='1' AND (fase_0="100" OR fase_0="011")) ELSE
										'0';  
		ena_habilitar_sign(3)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(3)='1') OR (chopper(3)='1' AND (fase_0="100" OR fase_0="011")) ELSE
										'0';  
		
		ena_habilitar_sign(4)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(4)='1') OR (chopper(4)='1' AND (fase_1="100" OR fase_1="010")) ELSE
										'0';  
		ena_habilitar_sign(5)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(5)='1') OR (chopper(5)='1' AND (fase_1="100" OR fase_1="010")) ELSE
										'0';  
		ena_habilitar_sign(6)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(6)='1') OR (chopper(6)='1' AND (fase_1="100" OR fase_1="011")) ELSE
										'0';  
		ena_habilitar_sign(7)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(7)='1') OR (chopper(7)='1' AND (fase_1="100" OR fase_1="011")) ELSE
										'0'; 
		
		ena_habilitar_sign(8)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(8)='1') OR (chopper(8)='1' AND (fase_2="100" OR fase_2="010")) ELSE
										'0';  
		ena_habilitar_sign(9)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(9)='1') OR (chopper(9)='1' AND (fase_2="100" OR fase_2="010")) ELSE
										'0';  
		ena_habilitar_sign(10)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(10)='1') OR (chopper(10)='1' AND (fase_2="100" OR fase_2="011")) ELSE
										'0';  
		ena_habilitar_sign(11)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(11)='1') OR (chopper(11)='1' AND (fase_2="100" OR fase_2="011")) ELSE
										'0';
									
		ena_habilitar_sign(12)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(12)='1') OR (chopper(12)='1' AND (fase_3="100" OR fase_3="010")) ELSE
										'0';  
		ena_habilitar_sign(13)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(13)='1') OR (chopper(13)='1' AND (fase_3="100" OR fase_3="010")) ELSE
										'0';  
		ena_habilitar_sign(14)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(14)='1') OR (chopper(14)='1' AND (fase_3="100" OR fase_3="011")) ELSE
										'0';  
		ena_habilitar_sign(15)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(15)='1') OR (chopper(15)='1' AND (fase_3="100" OR fase_3="011")) ELSE
										'0';
									
		ena_habilitar_sign(16)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(16)='1') OR (chopper(16)='1' AND (fase_4="100" OR fase_4="010")) ELSE
										'0';  
		ena_habilitar_sign(17)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(17)='1') OR (chopper(17)='1' AND (fase_4="100" OR fase_4="010")) ELSE
										'0';  
		ena_habilitar_sign(18)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(18)='1') OR (chopper(18)='1' AND (fase_4="100" OR fase_4="011")) ELSE
										'0';  
		ena_habilitar_sign(19)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(19)='1') OR (chopper(19)='1' AND (fase_4="100" OR fase_4="011")) ELSE
										'0';
		
		ena_habilitar_sign(20)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(20)='1') OR (chopper(20)='1' AND (fase_5="100" OR fase_5="010")) ELSE
										'0'; 
		ena_habilitar_sign(21)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(21)='1') OR (chopper(21)='1' AND (fase_5="100" OR fase_5="010")) ELSE
										'0';  
		ena_habilitar_sign(22)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(22)='1') OR (chopper(22)='1' AND (fase_5="100" OR fase_5="011")) ELSE
										'0';  
		ena_habilitar_sign(23)<= '1' WHEN ena_reg_G='1'OR(habilitar_sign(23)='1') OR (chopper(23)='1' AND (fase_5="100" OR fase_5="011")) ELSE
										'0';

------------------------------------------------------------------------------------------------------------------------------------------------------------

		habilitar_sign(0)<='1' WHEN   ena_reg_G='1' ELSE
                             '0';
		habilitar_sign(1)<='1' WHEN   (fase_0="001" OR fase_0="011") AND chopper(0)='1' ELSE
											  '0';
		habilitar_sign(2)<='1' WHEN   fase_0="000" AND chopper(0)='1' 						  ELSE
											  '0';
		habilitar_sign(3)<='1' WHEN   (fase_0="001" OR fase_0="010") AND chopper(2)='1' ELSE
											  '0';   

		habilitar_sign(4)<='1' WHEN   ena_reg_G='1' ELSE
                             '0';
		habilitar_sign(5)<='1' WHEN   (fase_1="001" OR fase_1="011") AND chopper(4)='1' ELSE
											  '0';
		habilitar_sign(6)<='1' WHEN   fase_1="000" AND chopper(4)='1'  ELSE
											  '0';
		habilitar_sign(7)<='1' WHEN   (fase_1="001" OR fase_1="010") AND chopper(6)='1' ELSE
											  '0'; 

		habilitar_sign(8)<='1' WHEN   ena_reg_G='1' ELSE
                             '0';
		habilitar_sign(9)<='1' WHEN   (fase_2="001" OR fase_2="011") AND chopper(8)='1' ELSE
											  '0';
		habilitar_sign(10)<='1' WHEN   fase_2="000" AND chopper(8)='1'  ELSE
											  '0';
		habilitar_sign(11)<='1' WHEN   (fase_2="001" OR fase_2="010") AND chopper(10)='1' ELSE
											  '0'; 

		habilitar_sign(12)<='1' WHEN   ena_reg_G='1' ELSE
                             '0';
		habilitar_sign(13)<='1' WHEN   (fase_3="001" OR fase_3="011") AND chopper(12)='1' ELSE
											  '0';
		habilitar_sign(14)<='1' WHEN   fase_3="000" AND chopper(12)='1'  ELSE
											  '0';
		habilitar_sign(15)<='1' WHEN   (fase_3="001" OR fase_3="010") AND chopper(14)='1' ELSE
											  '0'; 

		habilitar_sign(16)<='1' WHEN   ena_reg_G='1' AND (nivel="01" OR nivel="10") ELSE
                             '0';
		habilitar_sign(17)<='1' WHEN   (fase_4="001" OR fase_4="011") AND chopper(16)='1' ELSE
											  '0';
		habilitar_sign(18)<='1' WHEN   fase_4="000" AND chopper(16)='1'  ELSE
											  '0';
		habilitar_sign(19)<='1' WHEN   (fase_4="001" OR fase_4="010") AND chopper(18)='1' ELSE
											  '0'; 

		habilitar_sign(20)<='1' WHEN   ena_reg_G='1' AND nivel="10" ELSE
                             '0';
		habilitar_sign(21)<='1' WHEN   (fase_5="001" OR fase_5="011") AND chopper(20)='1' ELSE
											  '0';
		habilitar_sign(22)<='1' WHEN   fase_5="000" AND chopper(20)='1'  ELSE
											  '0';
		habilitar_sign(23)<='1' WHEN   (fase_5="001" OR fase_5="010") AND chopper(22)='1' ELSE
											  '0'; 
------------------------------------------------------------------------------------------------------------------------------------------------------------
	memo_0:ENTITY work.mem_ast_1_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_0,
				  r_data   =>data_0);
				  
	memo_8:ENTITY work.mem_ast_2_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      =>clk,
				  addr     =>address_read_4,
				  r_data   =>data_8);
	
	memo_16:ENTITY work.mem_ast_3_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      =>clk,
				  addr     =>address_read_8,
				  r_data   =>data_16);
	memo_24:ENTITY work.mem_ast_4_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_12,
				  r_data   =>data_24);
				  
	memo_32:ENTITY work.mem_ast_5_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      =>clk,
				  addr     =>address_read_16,
				  r_data   =>data_32);
	
	memo_40:ENTITY work.mem_ast_6_50
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      =>clk,
				  addr     =>address_read_20,
				  r_data   =>data_40);
	
------------------------------------------------------------------------------------------------------------------------------------------------------------
	memo_1:ENTITY work.mem_ast_1_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_0(9 DOWNTO 0),
				  r_data   =>data_1);
				  
	memo_4:ENTITY work.mem_ast_2_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_2,
				  r_data   =>data_4);	
	
	memo_9:ENTITY work.mem_ast_3_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_4(9 DOWNTO 0),
				  r_data   =>data_9);
				  
	memo_12:ENTITY work.mem_ast_4_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_6,
				  r_data   =>data_12);
				  
	memo_17:ENTITY work.mem_ast_5_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_8(9 DOWNTO 0),
				  r_data   =>data_17);
				  
	memo_20:ENTITY work.mem_ast_6_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_10,
				  r_data   =>data_20);
				  
	memo_25:ENTITY work.mem_ast_1_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_12(9 DOWNTO 0),
				  r_data   =>data_25);
				  
	memo_28:ENTITY work.mem_ast_2_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_14,
				  r_data   =>data_28);
				  
	memo_33:ENTITY work.mem_ast_3_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_16(9 DOWNTO 0),
				  r_data   =>data_33);
				  
	memo_36:ENTITY work.mem_ast_4_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_18,
				  r_data   =>data_36);
				  
	memo_41:ENTITY work.mem_ast_5_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_20(9 DOWNTO 0),
				  r_data   =>data_41);
				  
	memo_44:ENTITY work.mem_ast_6_25
	GENERIC MAP(DATA_WIDTH => 2,
					ADDR_WIDTH => 10)
	PORT MAP ( clk      => clk,
				  addr     =>address_read_22,
				  r_data   =>data_44);
	
------------------------------------------------------------------------------------------------------------------------------------------------------------				
	memo_2:ENTITY work.mem_ast_1_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_0(7 DOWNTO 0),
					  r_data   =>data_2);
					  
	memo_3:ENTITY work.mem_ast_2_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_1,
					  r_data   =>data_3);
					  
	memo_5:ENTITY work.mem_ast_3_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_2(7 DOWNTO 0),
					  r_data   =>data_5);
					  
	memo_6:ENTITY work.mem_ast_4_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_3,
					  r_data   =>data_6);
					  
	memo_10:ENTITY work.mem_ast_5_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_4(7 DOWNTO 0),
					  r_data   =>data_10);
					  
	memo_11:ENTITY work.mem_ast_6_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_5,
					  r_data   =>data_11);
					  
	memo_13:ENTITY work.mem_ast_1_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_6(7 DOWNTO 0),
					  r_data   =>data_13);
					  
	memo_14:ENTITY work.mem_ast_2_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_7,
					  r_data   =>data_14);
	memo_18:ENTITY work.mem_ast_3_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_8(7 DOWNTO 0),
					  r_data   =>data_18);
					  
	memo_19:ENTITY work.mem_ast_4_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_9,
					  r_data   =>data_19);
					  
	memo_21:ENTITY work.mem_ast_5_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_10(7 DOWNTO 0),
					  r_data   =>data_21);
					  
	memo_22:ENTITY work.mem_ast_6_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_11,
					  r_data   =>data_22);
	memo_26:ENTITY work.mem_ast_1_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_12(7 DOWNTO 0),
					  r_data   =>data_26);
					  
	memo_27:ENTITY work.mem_ast_2_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_13,
					  r_data   =>data_27);
					  
	memo_29:ENTITY work.mem_ast_3_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_14(7 DOWNTO 0),
					  r_data   =>data_29);
					  
	memo_30:ENTITY work.mem_ast_4_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_15,
					  r_data   =>data_30);
	memo_34:ENTITY work.mem_ast_5_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_16(7 DOWNTO 0),
					  r_data   =>data_34);
					  
	memo_35:ENTITY work.mem_ast_6_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_17,
					  r_data   =>data_35);
					  
	memo_37:ENTITY work.mem_ast_1_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_18(7 DOWNTO 0),
					  r_data   =>data_37);
					  
	memo_38:ENTITY work.mem_ast_2_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_19,
					  r_data   =>data_38);
	memo_42:ENTITY work.mem_ast_3_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_20(7 DOWNTO 0),
					  r_data   =>data_42);
					  
	memo_43:ENTITY work.mem_ast_4_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_21,
					  r_data   =>data_43);
					  
	memo_45:ENTITY work.mem_ast_5_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_22(7 DOWNTO 0),
					  r_data   =>data_45);
					  
	memo_46:ENTITY work.mem_ast_6_12
		GENERIC MAP(DATA_WIDTH => 2,
						ADDR_WIDTH => 8)
		PORT MAP ( clk      => clk,
					  addr     =>address_read_23,
					  r_data   =>data_46);
					  
	data_reg_0<= data_0 WHEN fase_0="000" 						ELSE
					 data_1 WHEN fase_0="001" OR fase_0="011" ELSE
					 data_2;
					 
	data_reg_1<= data_3;

	data_reg_2<= data_4 WHEN fase_0="001" OR fase_0="011" ELSE
					 data_5;
					 
	data_reg_3<= data_6;		

	data_reg_4<= data_8 WHEN fase_1="000" ELSE
					 data_9 WHEN fase_1="001" OR fase_1="011" ELSE
					 data_10;
					 
	data_reg_5<= data_11;

	data_reg_6<= data_12 WHEN fase_1="001" OR fase_1="011" ELSE
					 data_13;
					 
	data_reg_7<= data_14;		

	data_reg_8<= data_16 WHEN fase_2="000" ELSE
					 data_17 WHEN fase_2="001" OR fase_2="011" ELSE
					 data_18;
					 
	data_reg_9<= data_19;

	data_reg_10<= data_29 WHEN fase_2="001" OR fase_2="011" ELSE
					 data_21;
					 
	data_reg_11<= data_22;		

	data_reg_12<= data_24 WHEN fase_3="000" ELSE
					 data_25 WHEN fase_3="001" OR fase_3="011" ELSE
					 data_26;
					 
	data_reg_13<= data_27;

	data_reg_14<= data_28 WHEN fase_3="001" OR fase_3="011" ELSE
					 data_29;
					 
	data_reg_15<= data_30;		

	data_reg_16<= data_32 WHEN fase_4="000" ELSE
					 data_33 WHEN fase_4="001" OR fase_4="011" ELSE
					 data_34;
					 
	data_reg_17<= data_35;

	data_reg_18<= data_36 WHEN fase_4="001" OR fase_4="011" ELSE
					 data_37;
					 
	data_reg_19<= data_38;		

	data_reg_20<= data_40 WHEN fase_5="000" ELSE
					 data_41 WHEN fase_5="001" OR fase_5="011" ELSE
					 data_42;
					 
	data_reg_21<= data_43;

	data_reg_22<= data_44 WHEN fase_5="001" OR fase_5="011" ELSE
					 data_45;
					 
	data_reg_23<= data_46;			
------------------------------------------------------------------------------------------------------------------------------------------------------------
END ARCHITECTURE rtl;