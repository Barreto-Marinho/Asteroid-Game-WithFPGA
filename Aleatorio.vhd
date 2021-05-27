LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Aleatorio IS
	PORT    ( clk              :  IN    STD_LOGIC;
				 rst              :  IN    STD_LOGIC;
				 N_asteroide      :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 chopper_6        :  IN    STD_LOGIC_VECTOR(23 DOWNTO 0);
				 angulo_aleatorio :  OUT   STD_LOGIC_VECTOR(5 DOWNTO 0);
				 x_nave           :  IN    STD_LOGIC_VECTOR(9  DOWNTO 0);
				 y_nave           :  IN    STD_LOGIC_VECTOR(8  DOWNTO 0);
				 pos_x            :  OUT   STD_LOGIC_VECTOR(19 DOWNTO 0);
				 pos_y            :  OUT   STD_LOGIC_VECTOR(18 DOWNTO 0));
END ENTITY Aleatorio;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Aleatorio IS	
	SIGNAL  Reg_pos_x_signal,Reg_pos_x0,Reg_pos_x1,Reg_pos_x2,Reg_pos_x3,Reg_pos_x4,Reg_pos_x5  :  STD_LOGIC_VECTOR(9 DOWNTO 0);
   SIGNAL  Reg_pos_y_signal,Reg_pos_y0,Reg_pos_y1,Reg_pos_y2,Reg_pos_y3,Reg_pos_y4,Reg_pos_y5  :  STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL  Reg_pos_x,suma1,suma1_l639,suma1_m639 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  Reg_pos_y,suma2,suma2_m479,suma2_l479 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
BEGIN
------------------------------------------------------------------------------
	cont:ENTITY work.contador_uni
	GENERIC MAP(N => 10)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => '0',
				  ini      => "0010010110",
				  ena      => '1',
				  max      => "0111101001",
				  counter  => Reg_pos_x_signal);
------------------------------------------------------------------------------
	cont1:ENTITY work.contador_uni
	GENERIC MAP(N => 9)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => '0',
				  ini      => "010010110",
				  ena      => '1',
				  max      => "101001001",
				  counter  => Reg_pos_y_signal);
------------------------------------------------------------------------------
	regx0:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(0),  -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0010101010",--160
				  reg   => Reg_pos_x0);		
------------------------------------------------------------------------------
	regx1:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(4), -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0010100101",--160
				  reg   => Reg_pos_x1);		
 ------------------------------------------------------------------------------
	regx2:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(8), -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0101001000",--320
				  reg   => Reg_pos_x2);		
------------------------------------------------------------------------------
	regx3:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(12), -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0101000001",--320
				  reg   => Reg_pos_x3);		
------------------------------------------------------------------------------
	regx4:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(16), -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0111100110",--480
				  reg   => Reg_pos_x4);		
------------------------------------------------------------------------------
	regx5:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 10)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(20), -- cambiar lo que diga andres
				  sign  => Reg_pos_x_signal,
				  ini   => "0111101001",--480
				  reg   => Reg_pos_x5);		
------------------------------------------------------------------------------
	regy0:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(0), -- cambiar lo que diga andres
				  sign  => Reg_pos_y_signal,
				  ini   => "011100100",
				  reg   => Reg_pos_y0);		
------------------------------------------------------------------------------
	regy1:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(4), -- cambiar lo que diga andres
				  sign  => Reg_pos_y_signal, 
				  ini   => "101111100",
				  reg   => Reg_pos_y1);		
------------------------------------------------------------------------------
	regy2:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(8), -- cambiar lo que diga andres
				  sign  => Reg_pos_y_signal,
				  ini   => "011100100",
				  reg   => Reg_pos_y2);		
------------------------------------------------------------------------------
	regy3:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(12), -- cambiar lo que diga andres
				  sign  => Reg_pos_y_signal,
				  ini   => "101111100",
				  reg   => Reg_pos_y3);		
------------------------------------------------------------------------------
	regy4:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(16), -- cambiar lo que diga andres 
				  sign  => Reg_pos_y_signal,
				  ini   => "011100100",
				  reg   => Reg_pos_y4);		
------------------------------------------------------------------------------
	regy5:ENTITY work.Flip_flop_vector_ini
	GENERIC MAP(N => 9)
	PORT MAP ( clk   => clk,
				  rst   => rst,
				  ena   => chopper_6(20), -- cambiar lo que diga andres
				  sign  => Reg_pos_y_signal,
				  ini   => "101111100",
				  reg   => Reg_pos_y5);		
------------------------------------------------------------------------------
   reg_pos_x <= ('0'& Reg_pos_x0) WHEN (N_asteroide="000") ELSE 
	             ('0'& Reg_pos_x1) WHEN (N_asteroide="001") ELSE 
					 ('0'& Reg_pos_x2) WHEN (N_asteroide="010") ELSE 
					 ('0'& Reg_pos_x3) WHEN (N_asteroide="011") ELSE 
					 ('0'& Reg_pos_x4) WHEN (N_asteroide="100") ELSE 
					 ('0'& Reg_pos_x5);
------------------------------------------------------------------------------	
   reg_pos_y <= '0'& reg_pos_y0 WHEN (N_asteroide="000") ELSE 
	             '0'& reg_pos_y1 WHEN (N_asteroide="001") ELSE 
					 '0'& reg_pos_y2 WHEN (N_asteroide="010") ELSE 
					 '0'& reg_pos_y3 WHEN (N_asteroide="011") ELSE 
					 '0'& reg_pos_y4 WHEN (N_asteroide="100") ELSE 
					 '0'& reg_pos_y5;	
------------------------------------------------------------------------------
   suma1 <= STD_LOGIC_VECTOR(unsigned(reg_pos_x) + unsigned('0'&x_nave));
	
	suma2 <= STD_LOGIC_VECTOR(unsigned(reg_pos_y) + unsigned('0'&y_nave));
	
	angulo_aleatorio <= reg_pos_x(5 DOWNTO 0); 
------------------------------------------------------------------------------	
	
	suma1_m639<= STD_LOGIC_VECTOR(unsigned(suma1) + "01001111111");
	
	suma1_l639<= STD_LOGIC_VECTOR(unsigned(suma1) - "01001111111");
	
------------------------------------------------------------------------------
	suma2_m479<= STD_LOGIC_VECTOR(unsigned(suma2) + "0111011111");
	
	suma2_l479<= STD_LOGIC_VECTOR(unsigned(suma2) - "0111011111");

------------------------------------------------------------------------------

	
	pos_x<=   suma1_l639(9 DOWNTO 0)&"0000000000"   WHEN (suma1(10)='0') AND (suma1 >"01001111111") ELSE
				 suma1_m639(9 DOWNTO 0)&"0000000000"   WHEN (suma1(10)='1') AND (suma1 >"01001111111") ELSE
				 suma1     (9 DOWNTO 0)&"0000000000" ;
					 	
	pos_y<=   suma2_l479(8 DOWNTO 0)&"0000000000"  WHEN (suma2(9)='0') AND suma2 >"0111011111" ELSE
				 suma2_m479(8 DOWNTO 0)&"0000000000"   WHEN (suma2(9)='1') AND suma2 >"0111011111" ELSE
				 suma2     (8 DOWNTO 0)&"0000000000"  ;

------------------------------------------------------------------------------

END ARCHITECTURE rtl;