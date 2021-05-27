LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Asteroid IS
	PORT    ( clk          :  IN     STD_LOGIC;
				 rst          :  IN     STD_LOGIC;
				 data         :  IN     STD_LOGIC;
				 clk_teclado  :  IN     STD_LOGIC;
				 invi         :  IN     STD_LOGIC;
				 strobe       :  IN     STD_LOGIC;
				 trampa       :  IN     STD_LOGIC; 
				 vsyn         :  OUT    STD_LOGIC;
				 hsyn         :  OUT    STD_LOGIC;
				 arriba_o     :  OUT    STD_LOGIC;
				 derecha_o    :  OUT    STD_LOGIC;
				 izquierda_o  :  OUT    STD_LOGIC;
				 espacio_o    :  OUT    STD_LOGIC;
				 habilitar_reg_o   :  OUT    STD_LOGIC_VECTOR(23 DOWNTO 0);
				 VGA_R        :  OUT    STD_LOGIC_VECTOR(3 DOWNTO 0);
				 VGA_B        :  OUT    STD_LOGIC_VECTOR(3 DOWNTO 0);
				 VGA_G        :  OUT    STD_LOGIC_VECTOR(3 DOWNTO 0)
				);
END ENTITY Asteroid;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Asteroid IS	
	SIGNAL  	  signal_16_m, arriba, derecha, izquierda, espacio,reset_nave,perder	   :STD_LOGIC;
	SIGNAL     ena_intro,new_level,juego,pantalla_ganar,respawn,pantalla_perder      :STD_LOGIC;
	SIGNAL  	  ready_pos,arriba_reg, derecha_reg, izquierda_reg,ganar,reiniciar	   :STD_LOGIC;
	SIGNAL  	  sen_angulo, cos_angulo,color_pix,shoot_pix,pixel_as,pixel_obj	      :STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL     x_actual                                             :STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL     y_actual                                             :STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL     x_nave                                               :STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL     y_nave                                               :STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL     nave,titi,invencible                                 :STD_LOGIC;
	SIGNAL     asteroide,chopper                                    :STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL     bola,choque_bola                                     :STD_LOGIC_VECTOR(2 DOWNTO 0);  
   SIGNAL     counter_cora,counter_nivel                           :STD_LOGIC_VECTOR(1 DOWNTO 0); 
	
BEGIN
	arriba_o   <=arriba;
	derecha_o  <=derecha;
	izquierda_o<= izquierda;
	espacio_o  <=ganar;
-------------------------------------------------------------------------------
	Bloque_mando:ENTITY work.mando
	PORT MAP (  data   			=> data,
					clk_teclado    => clk_teclado,
					clk   			=> clk,
					pantalla_ganar => pantalla_ganar,
					pantalla_perder=> pantalla_perder,
					rst   			=> rst,
					signal_16_m    => signal_16_m,
					arriba_reg   		=> arriba,
					derecha_reg   		=> izquierda,
					izquierda_reg   	=> derecha,
					espacio_reg   		=> espacio);	
								
-------------------------------------------------------------------------------		
   reset_nave<=perder;		  		  
	Bloque_control_angulo:ENTITY work.Control_angulo
	PORT MAP (  clk   			=> clk,
					rst    			=> rst,
					sel_angulo   	=> reset_nave,--synclr del angulo
					signal_16_m    => signal_16_m,
					derecha_b   	=> derecha,
					izquierda_b    => izquierda,
					sen_angulo   	=> sen_angulo,
					cos_angulo   	=> cos_angulo);	
-------------------------------------------------------------------------------
	Bloque_control_nave:ENTITY work.Control_nave
	PORT MAP (  clk   			=> clk,
					rst    			=> rst,
					signal_16_m    => signal_16_m,
					x_actual       => x_actual,
					y_actual       => y_actual,
					x_nave         => x_nave,
					y_nave         => y_nave,
					sen_angulo     => sen_angulo,
					cos_angulo     => cos_angulo,
					nave           => nave,
					color_nave     => "111111111111",
					color_pix      => color_pix);			  
-------------------------------------------------------------------------------
	Bloque_pantall:ENTITY work.Control_pantalla
	PORT MAP (  clk   					=> clk,
					rst   					=> rst,
					strobe   				=> strobe,
					syn_clr_pan   			=> '0',
					signal_16_m   			=> signal_16_m,
					vsyn   					=> vsyn,
					hsyn   					=> hsyn,
					juego                => juego,
					pixel_obj            => pixel_obj,
					color_pix_nave       => color_pix,
					x_actual   				=> x_actual,
					y_actual   				=> y_actual,
					VGA_R   					=> VGA_R,
					VGA_G   					=> VGA_G,
					shoot_pix            => shoot_pix,
					pixel_as             => pixel_as,
					invencible           => invencible,
					titi                 => titi,
					VGA_B   					=> VGA_B );
-------------------------------------------------------------------------------					
	Bloque_VEL_NAVE:ENTITY work.Velocidad_nave
	PORT MAP (  clk   			=> clk,
					rst   			=> rst,
					reset_nave    	=> reset_nave,
					signal_16_m   	=> signal_16_m,
					arriba   		=> arriba,
					sen_angulo   	=> sen_angulo,
					cos_angulo   	=> cos_angulo,
					x_nave   		=> x_nave,
					y_nave   		=> y_nave,
					ready_pos   	=> ready_pos);			
-------------------------------------------------------------------------------	
	Bloque_DISPARO:ENTITY work.Control_disparos
	PORT MAP (  clk   			=> clk,
					rst   			=> rst,
					espacio   	   => espacio,
					signal_16_m   	=> signal_16_m,
					choque_bola   	=> choque_bola,
					cos_angulo   	=> cos_angulo,
					sen_angulo   	=> sen_angulo,
					x_nave   		=> x_nave,
					y_nave   		=> y_nave,
					x_actual       => x_actual,
					y_actual       => y_actual,
					color_bola     => "001000101101",
					bola           => bola,
					shoot_pix      => shoot_pix);
-------------------------------------------------------------------------------	
	Bloque_Asteroide:ENTITY work.Control_asteroid
	PORT MAP (  clk   			=> clk,
					rst   			=> rst,
					ganar          => ganar,
					signal_16_m   	=> signal_16_m,
					perder   	   => reiniciar,
					new_level   	=> '1',
					habilitar_reg_o=> habilitar_reg_o,
					chopper   	   => chopper,
					x_nave   		=> x_nave,
					y_nave   		=> y_nave,
				   x_actual       => x_actual,
					y_actual       => y_actual,
					nivel          => "00",
					color_as_1     => "011001100110",  
					color_as_2     => "100010001000",
					color_as_3     => "110011001100",
					asteroide      => asteroide,
					pixel_as       => pixel_as);
-------------------------------------------------------------------------------
	Bloque_doctor_chopper:ENTITY work.control_chopper
	PORT MAP (  clk   			=> clk,
					rst    			=> rst,
					signal_16_m   	=> signal_16_m,
				   nave   			=> nave,
					invencible     => invencible,
					bola   			=> bola,
					asteroide   	=> asteroide,
					choque_bola   	=> choque_bola,
					perder         => perder,  --indica cuando la nave choca
					chopper      	=> chopper);		
-------------------------------------------------------------------------------
	fsm :ENTITY work.fsm_general
	PORT MAP (  clk   			=> clk,
					rst    			=> rst,
					signal_16_m   	=> signal_16_m,
					espacio     	=> espacio,
					reiniciar      => reiniciar,
					perder         => perder, --si va
					ganar        	=> ganar, 
					ena_intro      => ena_intro,
					new_level      => new_level,
					juego          => juego,
					pantalla_ganar => pantalla_ganar,
					respawn        => respawn,	
					counter_cora   => counter_cora,
					counter_nivel  => counter_nivel,
					pantalla_perder=> pantalla_perder);		
-------------------------------------------------------------------------------			
 	imagenes :ENTITY work.Bloque_objetos
	PORT MAP (  clk   			=> clk,
					x_actual   	   => x_actual,
					y_actual     	=> y_actual,
					counter_cor    => counter_cora, 
					counter_nivel  => counter_nivel,
					color          => "111111111111",
					juego          => juego,
					titi           => titi,
					pantalla_ganar => pantalla_ganar OR trampa,
					pantalla_perder=> pantalla_perder,
					ena_intro      => ena_intro,
					pixel_obj      => pixel_obj);		
 
-------------------------------------------------------------------------------
tit :ENTITY work.titileo
	PORT MAP (  clk   		=> clk,
	            invi        => invi,
					rst   	   => rst,
					perder      => perder, 
					invencible  => invencible,
					titi        => titi);		
-------------------------------------------------------------------------------

END ARCHITECTURE rtl;