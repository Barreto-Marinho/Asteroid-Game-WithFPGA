LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY multi_a2_tb IS
END ENTITY multi_a2_tb;
-------------------------------------
ARCHITECTURE testbench OF multi_a2_tb IS
		SIGNAL        ena_sum      :     STD_LOGIC:='0';
	   SIGNAL         a				:		STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL			b				: 		STD_LOGIC_VECTOR(3 DOWNTO 0);
		SIGNAL         ope         :     STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN-------------------------------------

	DUT:	ENTITY work.sub_add 
	GENERIC MAP (N => 4 )
	PORT MAP(	data_a       => a,
					data_b  	    => b,
					ena_sum      => ena_sum,
					ope  	       => ope);	
-------------------------------------
	signal_generation: PROCESS
	BEGIN
		
	-- TEST VECTOR 1
	a <="0000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 2
	a <="0001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 3
	a <="0010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 4
	a <="0011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 5
	a <="0100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 6
	a <="0101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 7
	a <="0110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 8
	a <="0111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 9
	a <="1000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 10
	a <="1001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 11
	a <="1010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 12
	a <="1011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 13
	a <="1100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 14
	a <="1101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 15
	a <="1110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 16
	a <="1111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 17
	a <="0000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 18
	a <="0001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 19
	a <="0010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 20
	a <="0011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 21
	a <="0100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 22
	a <="0101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 23
	a <="0110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 24
	a <="0111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 25
	a <="1000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 26
	a <="1001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 27
	a <="1010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 28
	a <="1011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 29
	a <="1100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 30
	a <="1101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 31
	a <="1110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 32
	a <="1111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 33
	a <="0000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 34
	a <="0001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 35
	a <="0010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 36
	a <="0011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 37
	a <="0100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 38
	a <="0101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 39
	a <="0110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 40
	a <="0111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 41
	a <="1000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 42
	a <="1001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 43
	a <="1010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 44
	a <="1011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 45
	a <="1100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 46
	a <="1101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 47
	a <="1110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 48
	a <="1111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 49
	a <="0000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 50
	a <="0001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 51
	a <="0010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 52
	a <="0011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 53
	a <="0100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 54
	a <="0101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 55
	a <="0110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 56
	a <="0111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 57
	a <="1000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 58
	a <="1001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 59
	a <="1010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 60
	a <="1011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 61
	a <="1100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 62
	a <="1101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 63
	a <="1110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 64
	a <="1111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 65
	a <="0000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 66
	a <="0001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 67
	a <="0010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 68
	a <="0011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 69
	a <="0100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 70
	a <="0101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 71
	a <="0110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 72
	a <="0111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 73
	a <="1000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 74
	a <="1001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 75
	a <="1010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 76
	a <="1011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 77
	a <="1100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 78
	a <="1101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 79
	a <="1110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 80
	a <="1111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 81
	a <="0000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 82
	a <="0001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 83
	a <="0010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 84
	a <="0011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 85
	a <="0100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 86
	a <="0101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 87
	a <="0110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 88
	a <="0111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 89
	a <="1000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 90
	a <="1001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 91
	a <="1010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 92
	a <="1011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 93
	a <="1100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 94
	a <="1101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 95
	a <="1110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 96
	a <="1111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 97
	a <="0000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 98
	a <="0001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 99
	a <="0010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 100
	a <="0011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 101
	a <="0100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 102
	a <="0101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 103
	a <="0110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 104
	a <="0111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 105
	a <="1000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 106
	a <="1001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 107
	a <="1010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 108
	a <="1011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 109
	a <="1100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 110
	a <="1101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 111
	a <="1110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 112
	a <="1111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 113
	a <="0000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 114
	a <="0001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 115
	a <="0010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 116
	a <="0011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 117
	a <="0100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 118
	a <="0101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 119
	a <="0110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 120
	a <="0111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 121
	a <="1000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 122
	a <="1001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 123
	a <="1010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 124
	a <="1011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 125
	a <="1100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 126
	a <="1101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 127
	a <="1110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 128
	a <="1111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 129
	a <="0000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 130
	a <="0001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 131
	a <="0010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 132
	a <="0011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 133
	a <="0100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 134
	a <="0101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 135
	a <="0110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 136
	a <="0111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 137
	a <="1000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 138
	a <="1001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 139
	a <="1010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 140
	a <="1011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 141
	a <="1100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 142
	a <="1101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 143
	a <="1110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 144
	a <="1111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 145
	a <="0000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 146
	a <="0001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 147
	a <="0010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 148
	a <="0011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 149
	a <="0100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 150
	a <="0101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 151
	a <="0110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 152
	a <="0111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 153
	a <="1000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 154
	a <="1001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 155
	a <="1010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 156
	a <="1011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 157
	a <="1100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 158
	a <="1101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 159
	a <="1110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 160
	a <="1111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 161
	a <="0000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 162
	a <="0001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 163
	a <="0010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 164
	a <="0011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 165
	a <="0100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 166
	a <="0101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 167
	a <="0110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 168
	a <="0111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 169
	a <="1000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 170
	a <="1001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 171
	a <="1010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 172
	a <="1011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 173
	a <="1100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 174
	a <="1101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 175
	a <="1110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 176
	a <="1111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 177
	a <="0000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 178
	a <="0001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 179
	a <="0010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 180
	a <="0011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 181
	a <="0100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 182
	a <="0101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 183
	a <="0110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 184
	a <="0111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 185
	a <="1000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 186
	a <="1001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 187
	a <="1010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 188
	a <="1011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 189
	a <="1100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 190
	a <="1101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 191
	a <="1110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 192
	a <="1111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 193
	a <="0000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 194
	a <="0001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 195
	a <="0010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 196
	a <="0011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 197
	a <="0100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 198
	a <="0101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 199
	a <="0110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 200
	a <="0111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 201
	a <="1000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 202
	a <="1001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 203
	a <="1010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 204
	a <="1011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 205
	a <="1100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 206
	a <="1101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 207
	a <="1110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 208
	a <="1111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 209
	a <="0000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 210
	a <="0001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 211
	a <="0010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 212
	a <="0011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 213
	a <="0100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 214
	a <="0101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 215
	a <="0110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 216
	a <="0111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 217
	a <="1000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 218
	a <="1001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 219
	a <="1010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 220
	a <="1011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 221
	a <="1100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 222
	a <="1101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 223
	a <="1110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 224
	a <="1111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 225
	a <="0000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 226
	a <="0001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 227
	a <="0010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 228
	a <="0011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 229
	a <="0100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 230
	a <="0101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 231
	a <="0110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 232
	a <="0111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 233
	a <="1000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 234
	a <="1001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 235
	a <="1010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 236
	a <="1011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 237
	a <="1100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 238
	a <="1101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 239
	a <="1110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 240
	a <="1111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 241
	a <="0000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 242
	a <="0001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 243
	a <="0010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 244
	a <="0011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 245
	a <="0100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 246
	a <="0101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 247
	a <="0110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 248
	a <="0111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 249
	a <="1000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 250
	a <="1001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 251
	a <="1010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 252
	a <="1011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 253
	a <="1100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 254
	a <="1101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 255
	a <="1110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 256
	a <="1111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 1
	a <="0000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 2
	a <="0001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 3
	a <="0010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 4
	a <="0011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 5
	a <="0100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 6
	a <="0101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 7
	a <="0110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 8
	a <="0111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 9
	a <="1000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 10
	a <="1001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 11
	a <="1010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 12
	a <="1011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 13
	a <="1100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 14
	a <="1101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 15
	a <="1110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 16
	a <="1111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 17
	a <="0000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 18
	a <="0001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 19
	a <="0010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 20
	a <="0011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 21
	a <="0100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 22
	a <="0101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 23
	a <="0110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 24
	a <="0111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 25
	a <="1000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 26
	a <="1001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 27
	a <="1010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 28
	a <="1011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 29
	a <="1100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 30
	a <="1101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 31
	a <="1110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 32
	a <="1111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 33
	a <="0000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 34
	a <="0001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 35
	a <="0010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 36
	a <="0011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 37
	a <="0100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 38
	a <="0101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 39
	a <="0110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 40
	a <="0111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 41
	a <="1000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 42
	a <="1001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 43
	a <="1010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 44
	a <="1011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 45
	a <="1100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 46
	a <="1101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 47
	a <="1110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 48
	a <="1111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 49
	a <="0000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 50
	a <="0001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 51
	a <="0010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 52
	a <="0011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 53
	a <="0100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 54
	a <="0101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 55
	a <="0110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 56
	a <="0111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 57
	a <="1000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 58
	a <="1001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 59
	a <="1010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 60
	a <="1011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 61
	a <="1100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 62
	a <="1101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 63
	a <="1110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 64
	a <="1111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 65
	a <="0000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 66
	a <="0001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 67
	a <="0010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 68
	a <="0011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 69
	a <="0100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 70
	a <="0101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 71
	a <="0110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 72
	a <="0111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 73
	a <="1000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 74
	a <="1001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 75
	a <="1010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 76
	a <="1011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 77
	a <="1100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 78
	a <="1101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 79
	a <="1110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 80
	a <="1111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 81
	a <="0000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 82
	a <="0001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 83
	a <="0010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 84
	a <="0011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 85
	a <="0100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 86
	a <="0101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 87
	a <="0110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 88
	a <="0111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 89
	a <="1000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 90
	a <="1001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 91
	a <="1010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 92
	a <="1011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 93
	a <="1100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 94
	a <="1101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 95
	a <="1110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 96
	a <="1111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 97
	a <="0000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 98
	a <="0001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 99
	a <="0010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 100
	a <="0011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 101
	a <="0100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 102
	a <="0101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 103
	a <="0110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 104
	a <="0111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 105
	a <="1000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 106
	a <="1001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 107
	a <="1010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 108
	a <="1011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 109
	a <="1100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 110
	a <="1101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 111
	a <="1110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 112
	a <="1111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 113
	a <="0000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 114
	a <="0001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 115
	a <="0010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 116
	a <="0011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 117
	a <="0100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 118
	a <="0101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 119
	a <="0110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 120
	a <="0111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 121
	a <="1000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 122
	a <="1001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 123
	a <="1010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 124
	a <="1011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 125
	a <="1100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 126
	a <="1101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 127
	a <="1110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 128
	a <="1111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 129
	a <="0000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 130
	a <="0001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 131
	a <="0010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 132
	a <="0011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 133
	a <="0100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 134
	a <="0101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 135
	a <="0110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 136
	a <="0111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 137
	a <="1000"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 138
	a <="1001"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 139
	a <="1010"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 140
	a <="1011"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 141
	a <="1100"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 142
	a <="1101"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 143
	a <="1110"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 144
	a <="1111"; 
	b <= "0000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 145
	a <="0000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 146
	a <="0001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 147
	a <="0010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 148
	a <="0011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 149
	a <="0100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 150
	a <="0101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 151
	a <="0110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 152
	a <="0111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 153
	a <="1000"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 154
	a <="1001"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 155
	a <="1010"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 156
	a <="1011"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 157
	a <="1100"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 158
	a <="1101"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 159
	a <="1110"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 160
	a <="1111"; 
	b <= "0010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 161
	a <="0000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 162
	a <="0001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 163
	a <="0010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 164
	a <="0011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 165
	a <="0100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 166
	a <="0101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 167
	a <="0110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 168
	a <="0111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 169
	a <="1000"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 170
	a <="1001"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 171
	a <="1010"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 172
	a <="1011"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 173
	a <="1100"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 174
	a <="1101"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 175
	a <="1110"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 176
	a <="1111"; 
	b <= "0100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 177
	a <="0000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 178
	a <="0001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 179
	a <="0010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 180
	a <="0011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 181
	a <="0100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 182
	a <="0101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 183
	a <="0110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 184
	a <="0111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 185
	a <="1000"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 186
	a <="1001"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 187
	a <="1010"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 188
	a <="1011"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 189
	a <="1100"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 190
	a <="1101"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 191
	a <="1110"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 192
	a <="1111"; 
	b <= "0110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 193
	a <="0000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 194
	a <="0001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 195
	a <="0010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 196
	a <="0011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 197
	a <="0100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 198
	a <="0101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 199
	a <="0110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 200
	a <="0111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 201
	a <="1000"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 202
	a <="1001"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 203
	a <="1010"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 204
	a <="1011"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 205
	a <="1100"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 206
	a <="1101"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 207
	a <="1110"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 208
	a <="1111"; 
	b <= "1000"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 209
	a <="0000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 210
	a <="0001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 211
	a <="0010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 212
	a <="0011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 213
	a <="0100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 214
	a <="0101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 215
	a <="0110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 216
	a <="0111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 217
	a <="1000"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 218
	a <="1001"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 219
	a <="1010"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 220
	a <="1011"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 221
	a <="1100"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 222
	a <="1101"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 223
	a <="1110"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 224
	a <="1111"; 
	b <= "1010"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 225
	a <="0000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 226
	a <="0001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 227
	a <="0010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 228
	a <="0011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 229
	a <="0100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 230
	a <="0101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 231
	a <="0110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 232
	a <="0111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 233
	a <="1000"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 234
	a <="1001"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 235
	a <="1010"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 236
	a <="1011"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 237
	a <="1100"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 238
	a <="1101"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 239
	a <="1110"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 240
	a <="1111"; 
	b <= "1100"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 241
	a <="0000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 242
	a <="0001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 243
	a <="0010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 244
	a <="0011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 245
	a <="0100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 246
	a <="0101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 247
	a <="0110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 248
	a <="0111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 249
	a <="1000"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 250
	a <="1001"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 251
	a <="1010"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 252
	a <="1011"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 253
	a <="1100"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 254
	a <="1101"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 255
	a <="1110"; 
	b <= "1110"; 
	WAIT FOR 200ns;
	-- TEST VECTOR 256
	a <= "1111"; 
	b <= "1110"; 
	WAIT FOR 200ns;
  

	END PROCESS signal_generation;
END ARCHITECTURE testbench;