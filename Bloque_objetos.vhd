LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Bloque_objetos IS
	PORT    ( clk                    :  IN    STD_LOGIC;
				 x_actual      			:  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 y_actual      			:  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 counter_cor      		:  IN    STD_LOGIC_VECTOR(1 DOWNTO 0);
				 counter_nivel      		:  IN    STD_LOGIC_VECTOR(1 DOWNTO 0);
				 color 			     		:  IN    STD_LOGIC_VECTOR(11 DOWNTO 0);
				 pantalla_perder        :  IN    STD_LOGIC;
				 juego		            :  IN    STD_LOGIC;
				 ena_intro              :  IN    STD_LOGIC;
				 pantalla_ganar         :  IN    STD_LOGIC;
				 titi                   :  IN    STD_LOGIC;
				 pixel_obj              :  OUT   STD_LOGIC_VECTOR(11 DOWNTO 0));
END ENTITY Bloque_objetos;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Bloque_objetos IS	
	SIGNAL  x_lect,x_aux															: STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  y_lect,y_aux															: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  x_rest																	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  y_rest, xlen				   										: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  mul_aux       														: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL  mul, address          											: STD_LOGIC_VECTOR(14 DOWNTO 0);
	SIGNAL  xlen_chop_in, xlen_chop_pe, x_len_chop_ce,x_len_ni_0   : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  x_len_ni_1,x_len_ni_2, x_len_let_1,x_len_let_2         : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  x_len_cor                                              : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL  cond                                                   : STD_LOGIC_VECTOR(10 DOWNTO 0);
	SIGNAL  pix_chop_in, pix_chop_pe, pix_chop_ce						: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL  pix_ni_0, pix_ni_1,pix_ni_2, pix_let_1,pix_let_2 		: STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL  pix_cor                                                : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL  pix_chop_in_12, pix_chop_pe_12, pix_chop_ce_12			: STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL  pix_ni_0_12, pix_ni_1_12,pix_ni_2_12 						: STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL  pix_cor_12, pix_let_1_12,pix_let_2_12                  : STD_LOGIC_VECTOR(11 DOWNTO 0);
	

BEGIN

	pixel_obj<= pix_chop_in_12 		WHEN cond(0)='1'  									  ELSE
					pix_chop_pe_12 		WHEN cond(1)='1' 									     ELSE
					pix_chop_ce_12			WHEN cond(2)='1' 										  ELSE
					pix_ni_0_12          WHEN cond(3)='1'									     ELSE
					pix_ni_1_12          WHEN cond(4)='1' 										  ELSE
					pix_ni_2_12          WHEN cond(5)='1' 										  ELSE
					pix_let_1_12         WHEN cond(6)='1' 										  ELSE
					pix_let_2_12         WHEN cond(7)='1'  									  ELSE
					pix_cor_12				WHEN cond(8)='1'OR cond(9)='1' OR cond(10)='1' ELSE
					"000000000000";
------------------------------------------------------------------------------
	xlen_chop_in	<= "0001110001";
	xlen_chop_pe	<= "0001111101";
	x_len_chop_ce	<= "0001100101";
	x_len_ni_0		<= "0000100100";
	x_len_ni_1		<= "0000010110";
	x_len_ni_2		<= "0000011111";
	x_len_let_1		<= "0011111011";
	x_len_let_2		<= "0011110001";
	x_len_cor		<= "0000101100";

------------------------------------------------------------------------------
	x_aux<= STD_LOGIC_VECTOR(UNSIGNED('0' & x_actual)-UNSIGNED(x_lect));

	x_rest<= x_aux(9 DOWNTO 0);

	y_aux<= STD_LOGIC_VECTOR(UNSIGNED('0' & y_actual)-UNSIGNED(y_lect));

	y_rest<= y_aux(9 DOWNTO 0);
------------------------------------------------------------------------------	
	cond(0)<= '1' WHEN ena_intro='1' 		AND ("0100001000"<x_actual) AND (x_actual<"0101111001") AND ("010010000"<y_actual) AND (y_actual<"100001110") ELSE
				 '0';
	cond(1)<= '1' WHEN pantalla_perder='1' AND ("0100001000"<x_actual) AND (x_actual<"0110000101") AND ("010010000"<y_actual) AND (y_actual<"100010000") ELSE
				 '0';
	cond(2)<= '1' WHEN pantalla_ganar='1' AND ("0100001000"<x_actual) AND (x_actual<"0101101101") AND ("010010000"<y_actual) AND (y_actual<"100000110") ELSE
				 '0';
	cond(3)<= '1' WHEN juego='1' AND counter_nivel="00" AND ("1001011000"<x_actual) AND (x_actual<"1001111100") AND ("000001010"<y_actual) AND (y_actual<"000111101") ELSE
				 '0';
	cond(4)<= '1' WHEN juego='1' AND counter_nivel="01" AND ("1001100000"<x_actual) AND (x_actual<"1001110110") AND ("000001010"<y_actual) AND (y_actual<"000111110") ELSE
				 '0';
	cond(5)<= '1' WHEN juego='1' AND counter_nivel="10" AND ("1001010111"<x_actual) AND (x_actual<"1001110110") AND ("000001010"<y_actual) AND (y_actual<"001010010") ELSE
				 '0';
	cond(6)<= '1' WHEN titi ='1' AND juego='0' AND ("0011001000"<x_actual) AND (x_actual<"0111000011") AND ("100011000"<y_actual) AND (y_actual<"101010100") ELSE
				 '0';
	cond(7)<= '1' WHEN pantalla_perder='1' AND ("0011001000"<x_actual) AND (x_actual<"0110111001") AND ("000101000"<y_actual) AND (y_actual<"001100010") ELSE
				 '0';
	cond(8)<= '1' WHEN juego='1'AND (counter_cor="10" OR counter_cor="01" OR counter_cor="00") AND ("0000001010"<x_actual) AND (x_actual<"0000110110") AND ("000001010"<y_actual) AND (y_actual<"000110010") ELSE
				 '0';
	cond(9)<= '1' WHEN juego='1'AND (counter_cor="01" OR counter_cor="00") AND ("0001000000"<x_actual) AND (x_actual<"0001101100") AND ("000001010"<y_actual) AND (y_actual<"000110010") ELSE
				 '0';
	cond(10)<='1' WHEN juego='1'AND counter_cor="00" AND ("0001110110"<x_actual) AND (x_actual<"0010100010") AND ("000001010"<y_actual) AND (y_actual<"000110010") ELSE
				 '0';
				 
	
------------------------------------------------------------------------------
	xlen<= xlen_chop_in 			WHEN cond(0)='1'  									  ELSE
			 xlen_chop_pe 			WHEN cond(1)='1' 									     ELSE
			 x_len_chop_ce			WHEN cond(2)='1' 										  ELSE
			 x_len_ni_0          WHEN cond(3)='1'									     ELSE
			 x_len_ni_1          WHEN cond(4)='1' 										  ELSE
			 x_len_ni_2          WHEN cond(5)='1' 										  ELSE
			 x_len_let_1         WHEN cond(6)='1'  									  ELSE
			 x_len_let_2         WHEN cond(7)='1'  									  ELSE
			 x_len_cor				WHEN cond(8)='1'OR cond(9)='1' OR cond(10)='1' ELSE
			 "0000000000";
------------------------------------------------------------------------------
	x_lect<=	"00100001000" 	    	  WHEN cond(0)='1'   ELSE
				"00100001000"			  WHEN cond(1)='1' 	ELSE
				"00100001000" 			  WHEN cond(2)='1' 	ELSE
				"01001011000"          WHEN cond(3)='1' 	ELSE
				"01001100000"          WHEN cond(4)='1'   ELSE
				"01001010111"          WHEN cond(5)='1'   ELSE
				"00011001000"          WHEN cond(6)='1'   ELSE
				"00011001000"          WHEN cond(7)='1'   ELSE
				"00000001010" 			  WHEN cond(8)='1'   ELSE
				"00001000000" 			  WHEN cond(9)='1'   ELSE
				"00001110110" 			  WHEN cond(10)='1'  ELSE
				"00000000000" ;
				
	y_lect<=	"0010010000"  			  WHEN cond(0)='1'  	ELSE
				"0010010000"		     WHEN cond(1)='1'  	ELSE
				"0010010000"		     WHEN cond(2)='1'  	ELSE
				"0000001010"		     WHEN cond(3)='1'  	ELSE
				"0000001010"		     WHEN cond(4)='1'   ELSE
				"0000001010"		     WHEN cond(5)='1'   ELSE
				"0100011000"		     WHEN cond(6)='1'   ELSE
				"0000101000"		     WHEN cond(7)='1'  	ELSE
				"0000001010" 			  WHEN cond(8)='1'   ELSE
				"0000001010" 			  WHEN cond(9)='1'   ELSE
				"0000001010" 			  WHEN cond(10)='1'   ELSE
			   "0000000000" ;
				
----------------------------------------------------------------------------
	mul<= mul_aux(14 DOWNTO 0);

	m:ENTITY work.Multiplicador
	GENERIC MAP(N => 10)
	PORT MAP ( dataa  => y_rest,
				  datab  => xlen,
				  result => mul_aux);
------------------------------------------------------------------------------			 
	address<= STD_LOGIC_VECTOR(UNSIGNED("00000" & x_rest)+UNSIGNED(mul));			 

------------------------------------------------------------------------------

	pix_ni_2_12<= color 				WHEN pix_ni_2="1" ELSE
					  "000000000000";

	memo_1:ENTITY work.nivel_2
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 12)
	PORT MAP ( clk      => clk,
				  addr     =>address(11 DOWNTO 0),
				  r_data   =>pix_ni_2);
	
	pix_ni_1_12<= color 				WHEN pix_ni_1="1" ELSE
					  "000000000000";
	
	memo_2:ENTITY work.nivel_1
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 11)
	PORT MAP ( clk      => clk,
				  addr     =>address(10 DOWNTO 0),
				  r_data   =>pix_ni_1);
				  
	pix_ni_0_12<= color 				WHEN pix_ni_0="1" ELSE
					  "000000000000";
	
	memo_3:ENTITY work.nivel_0
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 11)
	PORT MAP ( clk      => clk,
				  addr     =>address(10 DOWNTO 0),
				  r_data   =>pix_ni_0);
				  
	pix_let_2_12<= "000100001111" 				WHEN pix_let_2="1" ELSE
					  "000000000000";
					  
	memo_4:ENTITY work.letras_2
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 14)
	PORT MAP ( clk      => clk,
				  addr     =>address(13 DOWNTO 0),
				  r_data   =>pix_let_2);
				  
	pix_let_1_12<= color 				WHEN pix_let_1="1" ELSE
				  "000000000000";
					  
	memo_5:ENTITY work.letras_1
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 14)
	PORT MAP ( clk      => clk,
				  addr     =>address(13 DOWNTO 0),
				  r_data   =>pix_let_1);
	
pix_cor_12  <= "000100001111"				WHEN pix_cor="1" ELSE
					 "000000000000";
				  
	memo_6:ENTITY work.corazon
	GENERIC MAP(DATA_WIDTH => 1,
					ADDR_WIDTH => 11)
	PORT MAP ( clk      => clk,
				  addr     =>address(10 DOWNTO 0),
				  r_data   =>pix_cor);
	
	pix_chop_in_12<="000100010001"   WHEN pix_chop_in="0000"  ELSE
					  "100001011011"   WHEN pix_chop_in="0001"  ELSE
					  "100110001111"   WHEN pix_chop_in="0010"  ELSE
					  "111111111111"   WHEN pix_chop_in="0011"  ELSE
					  "110011110100"   WHEN pix_chop_in="0100"  ELSE
					  "110010001111"   WHEN pix_chop_in="0101"  ELSE
					  "110011100100"   WHEN pix_chop_in="0110"  ELSE
					  "111111111111"   WHEN pix_chop_in="0111"  ELSE
					  "100001101011"   WHEN pix_chop_in="1000"  ELSE
					  "100001101010"   WHEN pix_chop_in="1001"  ELSE
					  "111111111111"   WHEN pix_chop_in="1010"  ELSE
					  "100001001111"   WHEN pix_chop_in="1011"  ELSE
					  "011101100111"   WHEN pix_chop_in="1100"  ELSE
					  "100001011010"   WHEN pix_chop_in="1101"  ELSE
					  "111111111111"   WHEN pix_chop_in="1110"  ELSE
					  "000000000000";
	
	memo_7:ENTITY work.chopper_intro
	GENERIC MAP(DATA_WIDTH => 4,
					ADDR_WIDTH => 14)
	PORT MAP ( clk      => clk,
				  addr     =>address(13 DOWNTO 0),
				  r_data   =>pix_chop_in);
		
	pix_chop_pe_12<="000100010001"   WHEN pix_chop_pe="0000"  ELSE
						  "110011100100"   WHEN pix_chop_pe="0001"  ELSE
						  "100110011110"   WHEN pix_chop_pe="0010"  ELSE
						  "100001011010"   WHEN pix_chop_pe="0011"  ELSE
						  "111111111110"   WHEN pix_chop_pe="0100"  ELSE
						  "111111111111"   WHEN pix_chop_pe="0101"  ELSE
						  "110010001111"   WHEN pix_chop_pe="0110"  ELSE
						  "111111111111"   WHEN pix_chop_pe="0111"  ELSE
						  "010100111000"   WHEN pix_chop_pe="1000"  ELSE
						  "100110011111"   WHEN pix_chop_pe="1001"  ELSE
						  "100101011101"   WHEN pix_chop_pe="1010"  ELSE
						  "100010100010"   WHEN pix_chop_pe="1011"  ELSE
						  "111111111111"   WHEN pix_chop_pe="1100"  ELSE
						  "001100100100"   WHEN pix_chop_pe="1101"  ELSE
						  "011001101101"   WHEN pix_chop_pe="1110"  ELSE
						  "100001001110";
	
	memo_8:ENTITY work.chopper_perder
	GENERIC MAP(DATA_WIDTH => 4,
					ADDR_WIDTH => 14)
	PORT MAP ( clk      => clk,
				  addr     =>address(13 DOWNTO 0),
				  r_data   =>pix_chop_pe);
				  
	pix_chop_ce_12<=    "000100010001"   WHEN pix_chop_ce="0000"  ELSE
							  "011001111100"   WHEN pix_chop_ce="0001"  ELSE
							  "100101011100"   WHEN pix_chop_ce="0010"  ELSE
							  "011101001001"   WHEN pix_chop_ce="0011"  ELSE
							  "011110001101"   WHEN pix_chop_ce="0100"  ELSE
							  "011101011010"   WHEN pix_chop_ce="0101"  ELSE
							  "001101000110"   WHEN pix_chop_ce="0110"  ELSE
							  "110011011111"   WHEN pix_chop_ce="0111"  ELSE
							  "011001001000"   WHEN pix_chop_ce="1000"  ELSE
							  "111010101101"   WHEN pix_chop_ce="1001"  ELSE
							  "011001101101"   WHEN pix_chop_ce="1010"  ELSE
							  "000000000000"   WHEN pix_chop_ce="1011"  ELSE
							  "110010001110"   WHEN pix_chop_ce="1100"  ELSE
							  "010101111011"   WHEN pix_chop_ce="1101"  ELSE
							  "001100111001"   WHEN pix_chop_ce="1110"  ELSE
							  "111111111111";
	
	memo_9:ENTITY work.chopper_celebrate
	GENERIC MAP(DATA_WIDTH => 4,
					ADDR_WIDTH => 14)
	PORT MAP ( clk      => clk,
				  addr     =>address(13 DOWNTO 0),
				  r_data   =>pix_chop_ce);
		
----------------------------------------------------------------------------
END ARCHITECTURE rtl;