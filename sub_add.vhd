LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
------------------------------------------------------------------------------
ENTITY sub_add IS
	GENERIC ( N			:	INTEGER	:= 6);
	PORT    ( data_a         :  IN     STD_LOGIC_VECTOR(N-1   DOWNTO 0);
				 data_b         :  IN     STD_LOGIC_VECTOR(N-1   DOWNTO 0);
				 ena_sum        :  IN     STD_LOGIC;
				 ope            :  OUT    STD_LOGIC_VECTOR(N-1   DOWNTO 0)
				);
END ENTITY sub_add;
-------------------------------------------------------------------------------			 
ARCHITECTURE  rtl OF sub_add IS	
	SIGNAL signal_b	: UNSIGNED(N-1 DOWNTO 0);
BEGIN


	signal_b<= UNSIGNED(NOT data_b)+1		WHEN ena_sum='0' ELSE  
				  UNSIGNED(data_b);
	
	ope<= STD_LOGIC_VECTOR((UNSIGNED(data_a)) + signal_b);
-------------------------------------------------------------------------------	

END ARCHITECTURE rtl;