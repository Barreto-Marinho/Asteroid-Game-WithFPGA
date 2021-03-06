LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
--Es un bloque que guarda vectores en unas cadena de flip flops
 ENTITY Flip_flop_vector IS
		GENERIC ( N			:	INTEGER	:= 4);
		PORT(	clk	  :IN	 STD_LOGIC;
				rst	  :IN  STD_LOGIC;
				ena	  :IN  STD_LOGIC;
				sign	  :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			   reg	  :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY Flip_flop_vector;
-------------------------------------------------------------
ARCHITECTURE rtl OF Flip_flop_vector  IS
	CONSTANT ZEROS      :STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS =>'0');
BEGIN 
	
	dff: PROCESS (clk,rst,sign,ena)
	BEGIN 
		IF(rst = '1') THEN 
				reg<=ZEROS;
		ELSIF (ena='1') THEN 
			IF (rising_edge(clk)) THEN 
				reg<= sign;
			END IF;
		END IF;
	END PROCESS;	

		
END ARCHITECTURE  ;
---------HECHO POR ANDRES BARRETO,SEBASTIAN MARINHO