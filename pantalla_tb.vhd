LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY pantalla_tb IS
END ENTITY  pantalla_tb ;
-------------------------------------
ARCHITECTURE testbench OF pantalla_tb  IS

	SIGNAL	clk				 :   STD_LOGIC := '0'; 
	SIGNAL   rst     			 :   STD_LOGIC := '1';
	SIGNAL   vsyn     		 :   STD_LOGIC ;	
	SIGNAL   hsyn     		 :   STD_LOGIC ;
	SIGNAL   VGA_R    		 :   STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SIGNAL   VGA_G    		 :   STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SIGNAL   VGA_B    		 :   STD_LOGIC_VECTOR(3 DOWNTO 0);	
	
		
BEGIN
	--CLOCK GENERATION:------------------------
	clk <= not clk after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst <= '0' after 20ns;
	
	
	DUT:	ENTITY work.Asteroid				 
	PORT MAP(	clk   => clk,
					rst   => rst,
					vsyn  => vsyn,
					hsyn  => hsyn,
					VGA_R => VGA_R,
					VGA_G => VGA_G,
					VGA_B => VGA_B,
					data  			=> '1',
					clk_teclado   =>'1',
					strobe        => '1'
					);
										
														
END ARCHITECTURE testbench;