LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Calculo_addres_read IS
	GENERIC (BIT_WIDTH	:	INTEGER:=3);
	PORT    ( x_lect      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_lect      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 pos_x       :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 pos_y       :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 addres_read :  OUT   STD_LOGIC_VECTOR(2*BIT_WIDTH-1 DOWNTO 0);
				 ancho_mem   :  IN    STD_LOGIC_VECTOR(BIT_WIDTH-1 DOWNTO 0);
				 seis1_ancho :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 seis0_ancho :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 cuat1_ancho :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 cuat0_ancho :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 enable_x    :  OUT   STD_LOGIC;
				 enable_y    :  OUT   STD_LOGIC);
END ENTITY Calculo_addres_read;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Calculo_addres_read IS	
	CONSTANT all_zeros_x					:STD_LOGIC_VECTOR(9-BIT_WIDTH  DOWNTO 0):= (OTHERS => '0');
	CONSTANT all_zeros_y					:STD_LOGIC_VECTOR(8-BIT_WIDTH  DOWNTO 0):= (OTHERS => '0');
	SIGNAL  resta_x_ac, suma_x_ac		: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  seleccion_x					: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  resta_y_ac, suma_y_ac		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  seleccion_y					: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  multi_y,  data_b_aux_1   : STD_LOGIC_VECTOR(2*BIT_WIDTH-1 DOWNTO 0);
	

BEGIN


				  
-----------------------------------------------------------------------------				  
	rest_x:ENTITY work.sub_add
	GENERIC MAP(N => 11)
	PORT MAP ( data_a    =>'0' & x_lect,
				  data_b    =>'0' & pos_x,
				  ena_sum   => '0',
				  ope       => resta_x_ac);	  			  
-----------------------------------------------------------------------------

	rest_y:ENTITY work.sub_add
	GENERIC MAP(N => 10)
	PORT MAP ( data_a    =>'0' & y_lect,
				  data_b    =>'0' & pos_y,
				  ena_sum   => '0',
				  ope       => resta_y_ac);	
			
-----------------------------------------------------------------------------
	sum_1:ENTITY work.sub_add
	GENERIC MAP(N => 11)
	PORT MAP ( data_a    => resta_x_ac,
				  data_b    => "01010000000",
				  ena_sum   => '1',
				  ope       => suma_x_ac);
-----------------------------------------------------------------------------
	sum_2:ENTITY work.sub_add
	GENERIC MAP(N => 10)
	PORT MAP ( data_a    => resta_y_ac,
				  data_b    => "0111100000",
				  ena_sum   => '1',
				  ope       => suma_y_ac);
-----------------------------------------------------------------------------	
	mu_6:ENTITY work.Multiplicador
	GENERIC MAP(N => BIT_WIDTH)
	PORT MAP ( dataa  => seleccion_y(BIT_WIDTH-1 DOWNTO 0),
				  datab  => ancho_mem,
				  result => multi_y);	
-----------------------------------------------------------------------------
	data_b_aux_1<= seleccion_x(2*BIT_WIDTH-1 DOWNTO 0);-- depronto se debe cambiar
	sum_15:ENTITY work.sub_add
	GENERIC MAP(N => 2*BIT_WIDTH)
	PORT MAP ( data_a    => multi_y,
				  data_b    => data_b_aux_1,
				  ena_sum   => '1',
				  ope       => addres_read);

	
	seleccion_x <=resta_x_ac WHEN (resta_x_ac(10)='0') ELSE
					  suma_x_ac;
					  
	seleccion_y <= resta_y_ac WHEN (resta_y_ac(9)='0') ELSE
					  suma_y_ac;
					  
	
	enable_x<= '1' WHEN  ((x_lect>=pos_x) AND pos_x>=seis1_ancho) 
                          OR(x_lect>=pos_x AND pos_x<seis1_ancho AND x_lect< STD_LOGIC_VECTOR(UNSIGNED(all_zeros_x & ancho_mem)+ UNSIGNED(pos_x))) 
                          OR(x_lect<pos_x AND (pos_x>= seis1_ancho) AND (STD_LOGIC_VECTOR(UNSIGNED(seis0_ancho)+UNSIGNED('0' & x_lect))<'0' & pos_x)) ELSE 
				  '0';
								  
	enable_y<= '1' WHEN        ((y_lect>=pos_y) AND pos_y>=cuat1_ancho) 
                            OR(y_lect>=pos_y AND pos_y<cuat1_ancho AND y_lect< STD_LOGIC_VECTOR(UNSIGNED(all_zeros_y & ancho_mem)+ UNSIGNED(pos_y))) 
                            OR(y_lect<pos_y AND (pos_y>= cuat1_ancho) AND (STD_LOGIC_VECTOR(UNSIGNED(cuat0_ancho)+UNSIGNED('0' & y_lect))< '0'& pos_y)) ELSE
					'0';
	
END ARCHITECTURE rtl;