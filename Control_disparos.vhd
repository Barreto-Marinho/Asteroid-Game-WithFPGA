LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

------------------------------------------------------------------------------
ENTITY Control_disparos IS
	PORT    ( clk         :  IN    STD_LOGIC;
				 rst         :  IN    STD_LOGIC;
				 espacio     :  IN    STD_LOGIC;
				 choque_bola :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 signal_16_m :  IN    STD_LOGIC;
				 x_actual    :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_actual    :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 x_nave      :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_nave      :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 sen_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 cos_angulo  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 color_bola  :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 bola        :  OUT   STD_LOGIC_VECTOR(2 DOWNTO 0); 
				 shoot_pix   :  OUT   STD_LOGIC_VECTOR(11 DOWNTO 0));
END ENTITY Control_disparos;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Control_disparos IS	
	SIGNAL ena,ena_dff,ena_creacion,ena_pos,ena_vel,max_tick_2,ram,ena_count_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
   SIGNAL max_tick,syn_clr,ena_count,ena_bola                       : STD_LOGIC;
	SIGNAL shoot1_pix,shoot2_pix,shoot3_pix                          : STD_LOGIC_VECTOR(11 DOWNTO 0); 
	
BEGIN
-------------------------------------------------------------------------------
ena_vel(0)       <= ena_creacion(0) OR signal_16_m;
ena_pos(0)       <= ena_creacion(0) OR signal_16_m;
ena_creacion(0)  <= '1' WHEN ena_bola='1' AND ena(0)='0' ElSE
                    '0';
						
ena_vel(1)       <= ena_creacion(1) OR signal_16_m;
ena_pos(1)       <= ena_creacion(1) OR signal_16_m;
ena_creacion(1)  <= '1' WHEN ena_bola='1' AND ena(1)='0' AND ena(0)='1' ElSE
                    '0';
						
ena_vel(2)       <= ena_creacion(2) OR signal_16_m;
ena_pos(2)       <= ena_creacion(2) OR signal_16_m;
ena_creacion(2)  <= '1' WHEN ena_bola='1' AND ena(2)='0' AND ena(1)='1' AND ena(0)='1' ElSE
                    '0';
-------------------------------------------------------------------------------
   ena_dff(0)<= ena_creacion(0) OR max_tick_2(0) OR choque_bola(0);
	
	ff_2:ENTITY work.my_dff
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  en    => ena_dff(0),
				  d     => NOT(ena(0)),
				  q     => ena(0));		
-------------------------------------------------------------------------------			
   ena_dff(1)<= ena_creacion(1) OR max_tick_2(1) OR choque_bola(1);
	
	ff_3:ENTITY work.my_dff
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  en    => ena_dff(1),
				  d     => NOT(ena(1)),
				  q     => ena(1));		
-------------------------------------------------------------------------------
   ena_dff(2)<= ena_creacion(2) OR max_tick_2(2) OR choque_bola(2);
	
	ff_cos:ENTITY work.my_dff
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  en    => ena_dff(2),
				  d     => NOT(ena(2)),
				  q     => ena(2));		
-------------------------------------------------------------------------------	
	fsm:ENTITY work.fsm_disparos
	PORT MAP (  clk  				 => clk,
					rst 				 => rst,
					espacio 	       => espacio,
					max_tick  		 => max_tick,
					ena_creacion 	 => ena_creacion,
					ena_bola 		 => ena_bola,
					ena_count 		 => ena_count,
					syn_clr 			 => syn_clr);	
					
	cont_1:ENTITY work.contador_uni
	GENERIC MAP(N => 25)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr,
				  ini      => "0000000000000000000000000",
				  ena      => ena_count,
				  max      => "1000000110110011001000000",
				  max_tick => max_tick);				

-------------------------------------------------------------------------------	
   ena_count_2(0) <= (signal_16_m AND ena(0)) OR max_tick_2(0) OR choque_bola(0);
	bb_1:ENTITY work.Bloque_bola_individual
	PORT MAP ( clk         => clk,
				  rst          => rst,
				  signal_16_m  => signal_16_m,
				  syn_clr      => max_tick_2(0) OR choque_bola(0),
				  ena_vel      => ena_vel(0),
				  ena_count    => ena_count_2(0),
				  ena_pos      => ena_pos(0),
				  ena_creacion => ena_creacion(0),
				  x_lect       => x_actual,
				  y_lect       => y_actual,
				  ena          => ena(0),
				  x_nave       => x_nave ,
				  y_nave       => y_nave ,
				  sen_angulo   => sen_angulo,
				  cos_angulo   => cos_angulo,	
				  pix          => ram(0),
				  max_tick     => max_tick_2(0));	
-------------------------------------------------------------------------------
   ena_count_2(1)<=(signal_16_m AND ena(1)) OR max_tick_2(1) OR choque_bola(1);
	bb_2:ENTITY work.Bloque_bola_individual
	PORT MAP ( clk         => clk,
				  rst          => rst,
				  signal_16_m  => signal_16_m,
				  syn_clr      => max_tick_2(1) OR choque_bola(1),
				  ena_vel      => ena_vel(1),
				  ena_count    =>  ena_count_2(1),
				  ena_pos      => ena_pos(1),
				  ena_creacion => ena_creacion(1),
				  x_lect       => x_actual,
				  ena          => ena(1),
				  y_lect       => y_actual,
				  x_nave       => x_nave ,
				  y_nave       => y_nave ,
				  sen_angulo   => sen_angulo,
				  cos_angulo   => cos_angulo,	
				  pix          => ram(1),
				  max_tick     => max_tick_2(1));	
-------------------------------------------------------------------------------
   ena_count_2(2)<=(signal_16_m AND ena(2)) OR max_tick_2(2) OR choque_bola(2);
	bb_3:ENTITY work.Bloque_bola_individual
	PORT MAP ( clk         => clk,
				  rst          => rst,
				  signal_16_m  => signal_16_m,
				  syn_clr      => max_tick_2(2) OR choque_bola(2),
				  ena_vel      => ena_vel(2),
				  ena_count    => ena_count_2(2),
				  ena_pos      => ena_pos(2),
				  ena_creacion => ena_creacion(2),
				  x_lect       => x_actual,
				  y_lect       => y_actual,
				  x_nave       => x_nave ,
				  ena          => ena(2),
				  y_nave       => y_nave ,
				  sen_angulo   => sen_angulo,
				  cos_angulo   => cos_angulo,	
				  pix          => ram(2),
				  max_tick     => max_tick_2(2));	
-------------------------------------------------------------------------------
		shoot1_pix<= color_bola WHEN (ram(0)='1') ELSE
					    "000000000000";
		
		shoot2_pix<= color_bola WHEN (ram(1)='1') ELSE
					    "000000000000";

		shoot3_pix<= color_bola WHEN (ram(2)='1') ELSE
					    "000000000000"; 
						 
						 
		bola<=ram;
						 
		shoot_pix<= shoot1_pix OR shoot2_pix OR shoot3_pix;
-------------------------------------------------------------------------------
END ARCHITECTURE rtl;