LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Romper IS
	PORT    ( y_pos_anterior   :  IN    STD_LOGIC_VECTOR(8 DOWNTO 0);
				 x_pos_anterior   :  IN    STD_LOGIC_VECTOR(9 DOWNTO 0);
				 x_pos_out        :  OUT   STD_LOGIC_VECTOR(19 DOWNTO 0);
				 y_pos_out        :  OUT   STD_LOGIC_VECTOR(18 DOWNTO 0);
				 fase_0           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 fase_1           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 fase_2           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 fase_3           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 fase_4           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 fase_5           :  IN    STD_LOGIC_VECTOR(2 DOWNTO 0);
				 count_24         :  IN    STD_LOGIC_VECTOR(4 DOWNTO 0);
				 numero           :  IN    STD_LOGIC;
				 angulo           :  IN    STD_LOGIC_VECTOR(5  DOWNTO 0);
				 N                :  IN    STD_LOGIC_VECTOR(5  DOWNTO 0);
				 angulo_new       :  OUT   STD_LOGIC_VECTOR(5 DOWNTO 0));
END ENTITY Romper;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Romper IS	
	SIGNAL  fase_sel                    :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL  aux                         :  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL  fase_in                     :  STD_LOGIC_VECTOR(4 DOWNTO 0);
   SIGNAL  y_pos_sign,out_resta,out_479:  STD_LOGIC_VECTOR(9 DOWNTO 0);
	

BEGIN
    x_pos_out<= x_pos_anterior&"0000000000";
------------------------------------------------------------------------------
  fase_sel <= fase_0 WHEN (count_24<="00011") ELSE 
	            fase_1 WHEN (count_24<="00111") ELSE 
               fase_2 WHEN (count_24<="01011") ELSE 
					fase_3 WHEN (count_24<="01111") ELSE 
					fase_4 WHEN (count_24<="11001") ELSE 
					fase_5;
	
	fase_in <= "11001" WHEN (fase_sel="000") ELSE 
	           "01101";
------------------------------------------------------------------------------
   y_pos_sign <= '0'& y_pos_anterior;
	
	out_resta <= STD_LOGIC_VECTOR(unsigned(y_pos_sign)-unsigned("00000"&fase_in));

	out_479   <= STD_LOGIC_VECTOR(unsigned(out_resta)+"0111011111");
------------------------------------------------------------------------------
     aux <= out_resta(9) & numero;
	  
    y_pos_out <= out_resta (8 DOWNTO 0)&"0000000000" WHEN (aux="00")   ELSE 
	              out_479   (8 DOWNTO 0)&"0000000000" WHEN (aux="10")  ELSE 
				     y_pos_sign(8 DOWNTO 0)&"0000000000";	  

------------------------------------------------------------------------------
	rest:ENTITY work.sub_add
	GENERIC MAP(N =>6 )
	PORT MAP ( data_a    => angulo,
				  data_b    => N,
				  ena_sum   => numero,
				  ope       => angulo_new);

------------------------------------------------------------------------------
END ARCHITECTURE rtl;