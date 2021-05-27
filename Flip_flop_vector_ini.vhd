LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------------------------------
--Es un bloque que guarda vectores en unas cadena de flip flops
 ENTITY Flip_flop_vector_ini IS
		GENERIC ( N			:	INTEGER	:= 4);
		PORT(	clk	  :IN	 STD_LOGIC;
				rst	  :IN  STD_LOGIC;
				ena	  :IN  STD_LOGIC;
				ini     :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				sign	  :IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
			   reg	  :OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY Flip_flop_vector_ini;
-------------------------------------------------------------
ARCHITECTURE rtl OF Flip_flop_vector_ini  IS
BEGIN 
	
	dff: PROCESS (clk,rst,sign,ena,ini)
	BEGIN 
		IF(rst = '1') THEN 
				reg<=ini;
		ELSIF (ena='1') THEN 
			IF (rising_edge(clk)) THEN 
				reg<= sign;
			END IF;
		END IF;
	END PROCESS;	

		
END ARCHITECTURE  ;
---------HECHO POR ANDRES BARRETO,SEBASTIAN MARINHO