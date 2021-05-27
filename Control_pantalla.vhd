LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Control_pantalla IS
	PORT    ( clk        	    :  IN    STD_LOGIC;
				 rst         		 :  IN    STD_LOGIC;
				 strobe      		 :  IN    STD_LOGIC;
				 syn_clr_pan 		 :  IN    STD_LOGIC;
				 juego             :  IN    STD_LOGIC;
				 titi              :  IN    STD_LOGIC;
				 invencible        :  IN    STD_LOGIC; 
				 color_pix_nave    :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 shoot_pix         :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 pixel_as          :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 pixel_obj         :  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);  
				 signal_16_m 		 :  OUT   STD_LOGIC;
				 vsyn        		 :  OUT   STD_LOGIC;
				 hsyn        		 :  OUT   STD_LOGIC;
				 x_actual    		 :  OUT   STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_actual    		 :  OUT   STD_LOGIC_VECTOR(8 DOWNTO 0);
				 VGA_R      		 :  OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
				 VGA_G      		 :  OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
				 VGA_B      		 :  OUT   STD_LOGIC_VECTOR(3 DOWNTO 0));
END ENTITY Control_pantalla;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Control_pantalla IS	
	SIGNAL  	  hsyn_aux							     	:STD_LOGIC;
	SIGNAL  	  syn, ena_cont, max_tick_px      	:STD_LOGIC;
	SIGNAL  	  syn_h, ena_cont_h, max_tick_h   	:STD_LOGIC;
	SIGNAL  	  ena_x,ena_y ,max_tick_actual_x	 	:STD_LOGIC;
	SIGNAL  	  max_tick_actual_y,ena_cont_h_aux	:STD_LOGIC;
	SIGNAL     ena_rgb, vsyn_aux                 :STD_LOGIC;
	SIGNAL  	  VGA_R_sig, VGA_B_sig, VGA_G_sig  	:STD_LOGIC_VECTOR(3  DOWNTO 0);
	SIGNAL  	  counter_time, max     			 	:STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  	  counter_time_h, max_h     	    	:STD_LOGIC_VECTOR(9  DOWNTO 0);
	SIGNAL  	  x_actual_aux					    	 	:STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  	  y_actual_aux					    	 	:STD_LOGIC_VECTOR(8  DOWNTO 0);
	
BEGIN


   VGA_R_sig<= "0000"  WHEN x_actual_aux="00000000000"    ELSE
	            pixel_obj(3 DOWNTO 0)       WHEN pixel_obj/="000000000000" ELSE
	            color_pix_nave(3 DOWNTO 0)  WHEN color_pix_nave /="000000000000" AND juego='1' AND (invencible='0' OR (invencible='1' AND titi='1'))ELSE
					shoot_pix(3 DOWNTO 0)       WHEN shoot_pix/="000000000000" AND juego='1' ELSE
					pixel_as(3 DOWNTO 0)        WHEN pixel_as/="000000000000" AND juego='1' ELSE
					"0001";
					
	VGA_B_sig<= "0000"  WHEN x_actual_aux="00000000000"    ELSE
	            pixel_obj(7 DOWNTO 4)       WHEN pixel_obj/="000000000000" ELSE
	            color_pix_nave(7 DOWNTO 4)  WHEN color_pix_nave /="000000000000" AND juego='1' AND (invencible='0' OR (invencible='1' AND titi='1')) ELSE
					shoot_pix(7 DOWNTO 4)       WHEN shoot_pix/="000000000000" AND juego='1' ELSE	
					pixel_as(7 DOWNTO 4)        WHEN pixel_as/="000000000000" AND juego='1' ELSE
					"0001";
					
	VGA_G_sig<= "0000"  WHEN x_actual_aux="00000000000"    ELSE
	            pixel_obj(11 DOWNTO 8)       WHEN pixel_obj/="000000000000" ELSE
	            color_pix_nave(11 DOWNTO 8)  WHEN color_pix_nave /="000000000000" AND juego='1' AND (invencible='0' OR (invencible='1' AND titi='1')) ELSE
					shoot_pix(11 DOWNTO 8)       WHEN shoot_pix/="000000000000" AND juego='1' ELSE
					pixel_as(11 DOWNTO 8)        WHEN pixel_as/="000000000000" AND juego='1' ELSE
					"0001";
			  
-------------------------------------------------------------------------------
				  
	ff2:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 4)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_rgb,
				  sign  =>VGA_R_sig,
				  reg   =>VGA_R);		
-------------------------------------------------------------------------------
	ff1:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 4)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_rgb,
				  sign  =>VGA_B_sig,
				  reg   =>VGA_B);		
-------------------------------------------------------------------------------
	ff_sen:ENTITY work.Flip_flop_vector
	GENERIC MAP(N => 4)
	PORT MAP ( clk   => clk,
				  rst   =>rst,
				  ena   =>ena_rgb,
				  sign  =>VGA_G_sig,
				  reg   =>VGA_G);		
-------------------------------------------------------------------------------
	ena_rgb<= (counter_time(0));

	ena_x<= '1' WHEN (counter_time>"00001011101")AND(counter_time<"10101011110")AND(hsyn_aux='1') ELSE
			  '0';
			  
	x_actual<= x_actual_aux(10 DOWNTO 1);

	------------------------------------------------------------------------------
	cont_x:ENTITY work.contador_uni
	GENERIC MAP(N => 11)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_pan,
				  ini      => "00000000000",
				  ena      => ena_x,
				  max      => "10011111111",
				  counter  => x_actual_aux,
				  max_tick => max_tick_actual_x);
	------------------------------------------------------------------------------
	y_actual<= y_actual_aux;
	cont_y:ENTITY work.contador_uni
	GENERIC MAP(N => 9)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_pan,
				  ini      => "000000000",
				  ena      => ena_y,
				  max      => "111011111",
				  counter  => y_actual_aux,
				  max_tick => max_tick_actual_y);
	------------------------------------------------------------------------------
	cont_1:ENTITY work.contador_uni
	GENERIC MAP(N => 11)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn,
				  ini      => "00000000000",
				  ena      => ena_cont,
				  max      => max,
				  counter  => counter_time,--2counter_time=1px
				  max_tick => max_tick_px);
	------------------------------------------------------------------------------
	ena_cont_h_aux<= (max_tick_px AND (not(hsyn_aux)) AND ena_cont_h)OR max_tick_h;
	ena_y<= '1' WHEN (ena_cont_h_aux='1') AND((counter_time_h>"0000100000")AND(counter_time_h<"1000000001")) ELSE
			  '0';
	
	signal_16_m<= '1' WHEN counter_time_h="1000000000" AND ena_cont_h_aux='1' AND vsyn_aux='1' ELSE
					  '0';
	vsyn<= vsyn_aux;
	
	cont_2:ENTITY work.contador_uni
	GENERIC MAP(N => 10)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_h,
				  ini      => "0000000000",
				  ena      => ena_cont_h_aux,
				  max      => max_h,
				  counter  => counter_time_h,--2counter_time=1px
				  max_tick => max_tick_h);
	------------------------------------------------------------------------------
	fsm_v:ENTITY work.fsm_vsyn
	PORT MAP ( clk         => clk,
				  rst         => rst,
				  strobe      => strobe,
				  MaxTick_h   => Max_Tick_h,
				  ena_cont_h  => ena_cont_h,
				  syn_h       => syn_h,
				  vsyn        => vsyn_aux,
				  Max_h       => Max_h);
	------------------------------------------------------------------------------
	fsm_h:ENTITY work.fsm_hsyn
	PORT MAP ( clk      		=> clk,
				  rst      		=> rst,
				  strobe       => strobe,
				  MaxTick_px   => Max_Tick_px,
				  ena_cont     => ena_cont,
				  syn      		=> syn,
				  hsyn      	=> hsyn_aux,
				  Max      		=> Max);
	hsyn<= hsyn_aux;
	------------------------------------------------------------------------------
		

END ARCHITECTURE rtl;