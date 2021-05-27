LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-----------------------------------
ENTITY SPRAM IS
	GENERIC (	DATA_WIDTH	:	INTEGER:=8;
				ADDR_WIDTH	:	INTEGER:=2);
	PORT (	clk		:	IN  STD_LOGIC;
				Wr_rdn	:	IN  STD_LOGIC;
				addr		:	IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				addr_read:	IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				W_data	:  IN  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				r_data	:	OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY;



-----------------------------------
ARCHITECTURE funtional OF SPRAM IS
----------------------------------- Build of memory
	TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL ram	:	mem_2d_type;
	SIGNAL addr_reg	:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
----------------------------------- Contents

BEGIN 
	--WRITE PROCESS
   write_process: PROCESS(clk)
	BEGIN 
	   IF (rising_edge(clk)) THEN
			IF (wr_rdn ='1') THEN 
				ram(to_integer(unsigned(addr)))<= w_data;
			END IF;
			addr_reg <= addr_read;
		END IF;
	END PROCESS;
	--READ 
	r_data <= ram(to_integer(unsigned(addr_reg)));
 END ARCHITECTURE funtional;