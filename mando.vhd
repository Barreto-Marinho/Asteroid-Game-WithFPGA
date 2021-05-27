LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY mando IS
	PORT    ( data         :  IN     STD_LOGIC;
				 clk_teclado  :  IN     STD_LOGIC;
				 clk          :  IN     STD_LOGIC;
				 rst          :  IN     STD_LOGIC;
				 signal_16_m  :  IN     STD_LOGIC;
				 pantalla_ganar   :  IN     STD_LOGIC;
				 pantalla_perder  :  IN     STD_LOGIC;
				 arriba_reg   :  OUT    STD_LOGIC;
				 derecha_reg  :  OUT    STD_LOGIC;
				 izquierda_reg:  OUT    STD_LOGIC;
				 espacio_reg  :  OUT    STD_LOGIC
				);
END ENTITY mando;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF mando IS	
	SIGNAL max_tick, ena_count, ena_reg							: STD_LOGIC;
	SIGNAL syn_clr_a,syn_clr_d,syn_clr_i,syn_clr_s			: STD_LOGIC;
	SIGNAL clk_ps2, syn_clr											: STD_LOGIC;
	SIGNAL der_sig,izq_sig,arri_sig, space_sig				: STD_LOGIC;
	SIGNAL max_tick_arriba,max_tick_izquierda  				: STD_LOGIC;
	SIGNAL arriba, derecha, izquierda, espacio  				: STD_LOGIC;
	SIGNAL max_tick_derecha, max_tick_espacio  				: STD_LOGIC;
	SIGNAL counter                                	      : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL counter_arriba,counter_espacio	               : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL counter_derecha,counter_izquierda   				: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL ena_registro, registro	   							: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	arriba_reg<= arriba;
	derecha_reg<= derecha;
	izquierda_reg<= izquierda;
	espacio_reg<= espacio;

	 def_mux_1: FOR i IN 0 To 7 GENERATE
			DUT: ENTITY work.my_dff
			PORT MAP (		clk				=>	clk,
								rst				=>	rst,
								en 				=>	ena_registro(i),
								d 					=>	data,
								q 					=>	registro(i));
	 END GENERATE;		
						
	DUT: ENTITY work.my_dff
			PORT MAP (		clk				=>	clk,
								rst				=>	rst,
								en 				=>	'1',
								d 					=>	clk_teclado,
								q 					=>	clk_ps2);
	
	ena_registro<= "00000001" WHEN counter="0000"AND ena_reg='1' ELSE
						"00000010" WHEN counter="0001"AND ena_reg='1' ELSE
						"00000100" WHEN counter="0010"AND ena_reg='1' ELSE
						"00001000" WHEN counter="0011"AND ena_reg='1' ELSE
						"00010000" WHEN counter="0100"AND ena_reg='1' ELSE
						"00100000" WHEN counter="0101"AND ena_reg='1' ELSE
						"01000000" WHEN counter="0110"AND ena_reg='1' ELSE
						"10000000" WHEN counter="0111"AND ena_reg='1' ELSE
						"00000000";
	
	cont_x:ENTITY work.contador_uni
	GENERIC MAP(N => 4)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  =>syn_clr,
				  ini      => "0000",
				  ena      => ena_count,
				  max      => "1010",
				  counter  => counter,
				  max_tick => max_tick);

	fsm:ENTITY work.teclado
	PORT MAP ( clk      		=> clk,
				  rst      		=> rst,
				  clk_ps2  		=> clk_ps2,
				  syn_clr      => syn_clr,
				  max_tick     => max_tick,
				  ena_reg      => ena_reg,
				  ena_count    => ena_count);		  

	der_sig<= '1' WHEN registro= X"46" ELSE
				 '0';
	izq_sig<= '1' WHEN registro= X"38" ELSE
				 '0';
				 
	arri_sig<= '1' WHEN registro= X"3A" ELSE
				      '0';
	space_sig<= '1' WHEN registro= X"52" ELSE
				       '0';
	
	PROCESS(clk, rst,signal_16_m,max_tick,arri_sig,der_sig,izq_sig,space_sig)
	BEGIN
		IF(rst = '1') THEN
			 arriba<= '0';
			 derecha<= '0';
			 izquierda<= '0';
			 espacio<= '0';
		ELSIF (rising_edge(clk)) THEN
			IF(signal_16_m='1') THEN
				IF(max_tick_arriba='1') THEN
					arriba<= '0';
				END IF;
				IF(max_tick_derecha='1') THEN
					derecha<= '0';
				END IF;
				IF(max_tick_izquierda='1') THEN
					izquierda<= '0';
				END IF;
				IF(max_tick_espacio='1' OR pantalla_perder='1' OR pantalla_ganar='1') THEN
					espacio<= '0';
				END IF;
			ELSIF (max_tick = '1') THEN
				 arriba<= arri_sig;
				 derecha<= der_sig;
				 izquierda<= izq_sig;
				 espacio<= space_sig;
			END IF;
		END IF;
	END PROCESS;
	
------------------------------------------------------------------------------
	syn_clr_a<= signal_16_m AND NOT(arriba);
	cont_1:ENTITY work.contador_uni
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_a,
				  ini      => "000000",
				  ena      => signal_16_m,
				  max      => "000101",
				  counter  => counter_arriba,
				  max_tick => max_tick_arriba);
------------------------------------------------------------------------------
	syn_clr_d<= signal_16_m AND NOT(derecha);
	cont_2:ENTITY work.contador_uni
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_d,
				  ini      => "000000",
				  ena      => signal_16_m,
				  max      => "001010",
				  counter  => counter_derecha,
				  max_tick => max_tick_derecha);
------------------------------------------------------------------------------
	syn_clr_i<= signal_16_m AND NOT(izquierda);
	cont_3:ENTITY work.contador_uni
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_i,
				  ini      => "000000",
				  ena      => signal_16_m,
				  max      => "001010",
				  counter  => counter_izquierda,
				  max_tick => max_tick_izquierda);
------------------------------------------------------------------------------
	syn_clr_s<= signal_16_m AND NOT(espacio);
	cont_4:ENTITY work.contador_uni
	GENERIC MAP(N => 6)
	PORT MAP ( clk      => clk,
				  rst      => rst,
				  up       => '1',
				  syn_clr  => syn_clr_s,
				  ini      => "000000",
				  ena      => signal_16_m,
				  max      => "000001",
				  counter  => counter_espacio,
				  max_tick => max_tick_espacio);
	
END ARCHITECTURE rtl;