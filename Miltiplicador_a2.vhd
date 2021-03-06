LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY Miltiplicador_a2 IS
	GENERIC ( N			:	INTEGER	:= 6);
	PORT    ( data_a         :  IN     STD_LOGIC_VECTOR(N-1   DOWNTO 0);
				 data_b         :  IN     STD_LOGIC_VECTOR(N-1   DOWNTO 0);
				 multi          :  OUT    STD_LOGIC_VECTOR(2*N-2 DOWNTO 0)
				);
END ENTITY Miltiplicador_a2;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF Miltiplicador_a2 IS	
	SIGNAL signal_a, signal_b	: STD_LOGIC_VECTOR (N-1 	 DOWNTO 0);
	SIGNAL dataa, datab			: STD_LOGIC_VECTOR (N-2 	 DOWNTO 0);
	SIGNAL result      			: STD_LOGIC_VECTOR (2*N-3	 DOWNTO 0);
BEGIN

	signal_a<= STD_LOGIC_VECTOR((UNSIGNED(NOT(data_a)))+1) WHEN data_a(N-1)='1' ELSE
				  data_a;
				  
	dataa<= signal_a(N-2 DOWNTO 0);
	
-------------------------------------------------------------------------------	
	
	signal_b<= STD_LOGIC_VECTOR((UNSIGNED(NOT(data_b)))+1) WHEN data_b(N-1)='1' ELSE
				  data_b;
				  
	datab<= signal_b(N-2 DOWNTO 0);
	
-------------------------------------------------------------------------------	
	

	
	multi(2*N-2 DOWNTO 0)<= STD_LOGIC_VECTOR((UNSIGNED(NOT('0' & result)))+1) WHEN ((data_a(N-1)='1') XOR (data_b(N-1)='1')) ELSE
						         ('0'&result);
						
-------------------------------------------------------------------------------	
	
	multi_a2:ENTITY work.Multiplicador
	GENERIC MAP(N => N-1)
	PORT MAP ( dataa      => dataa,
				  datab      => datab,
				  result     => result);			  


END ARCHITECTURE rtl;