LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Memoria_bala IS
	GENERIC (	DATA_WIDTH	:	INTEGER:=1;
					ADDR_WIDTH	:	INTEGER:=7);
	PORT (	clk		:	IN  STD_LOGIC;
				addr		:	IN  STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
				r_data	:	OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY;
-----------------------------------
ARCHITECTURE funtional OF Memoria_bala IS
----------------------------------- Build of memory
	TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL ram	:	mem_2d_type;
	SIGNAL data_reg	:	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
----------------------------------- Contents
	CONSTANT DATA_ROM: mem_2d_type:=("0","0","0","0","0","0","0","0","0","0","0",
												"0","0","0","1","1","1","1","1","0","0","0",
												"0","0","1","1","1","1","1","1","1","0","0",
												"0","1","1","1","1","1","1","1","1","1","0",
												"0","1","1","1","1","1","1","1","1","1","0",
												"0","1","1","1","1","1","1","1","1","1","0",
												"0","1","1","1","1","1","1","1","1","1","0",
												"0","1","1","1","1","1","1","1","1","1","0",
												"0","0","1","1","1","1","1","1","1","0","0",
												"0","0","0","1","1","1","1","1","0","0","0",
												"0","0","0","0","0","0","0","0","0","0","0",
												"0","0","0","0","0","0","0");
												
												
BEGIN 
	--WRITE PROCESS
   read_process: PROCESS(clk)
	BEGIN 
	   IF (rising_edge(clk)) THEN
			data_reg <= DATA_ROM(to_integer(unsigned(addr)));
		END IF;
	END PROCESS;
	--READ 
	r_data <= data_reg;
 END ARCHITECTURE funtional;