library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use work.aux_categories.all;
use work.constants.all;

ENTITY decoder_tb is
end decoder_tb;

ARCHITECTURE decoder_beh of decoder_tb is
	component decoder
		port(
			clock       : in  STD_LOGIC;
			reset       : in  STD_LOGIC;
			flush       : in  STD_LOGIC;
			stall       : in  STD_LOGIC;
			pc_in       : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			instruction : in  INSTRUCTION_LENGTH;
			pc_out      : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			rs1         : out REG;
			rs2         : out REG;
			rd          : out REG;
			opcode      : out OPCODE_SIZE;
			immediate   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			funct7      : out FUNCT7_SIZE;
			funct3      : out FUNCT3_SIZE
		);
	end component decoder;

	CONSTANT clk_period    : time := 10 ns;
	signal clock           : STD_LOGIC;
	signal reset           : STD_LOGIC;
	signal flush : STD_LOGIC;
	signal stall : STD_LOGIC;
	signal pc_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal instruction     : INSTRUCTION_LENGTH;
	signal pc_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs1             : REG;
	signal rs2             : REG;
	signal rd              : REG;
	signal opcode          : OPCODE_SIZE;
	signal immediate       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rd_write_enable : STD_LOGIC;
	signal funct7          : FUNCT7_SIZE;
	signal funct3          : FUNCT3_SIZE;
	

BEGIN
	UUT : decoder
		port map(
			clock           => clock,
			reset           => reset,
			flush => flush,
			stall => stall,
			pc_in => pc_in,
			instruction     => instruction,
			pc_out => pc_out,
			rs1             => rs1,
			rs2             => rs2,
			rd              => rd,
			opcode          => opcode,
			immediate       => immediate,
			funct7          => funct7,
			funct3          => funct3
		);

	clock_process : PROCESS
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end PROCESS;

	main_process : PROCESS
	begin
		reset <= '0';
		flush <= '0';
		stall <= '0';
		-- RTYPE INSTRUCTION
		-- add x10, x28, x30

		-- funct7	x30	 	x28  	funct3  x10		opcode	Field Name
		-- 0000000	11110	11100	000	 	01010	0110011	Field Value
		-- 0x01EE0533
		pc_in <= x"00000000";
		instruction <= X"00AE0533";

		wait for clk_period;

		-- ITYPE ALU INSTRUCTION
		-- andi x20, x10, 105
		-- IMM			x10		funct3	x20		opcode	Field Name
		-- 000001101001	01010	111		10100	0010011	Field Value
		-- 0x06957A13
		pc_in <= x"00000004";		
		instruction <= X"06957A13";

		wait for clk_period;

		-- LOAD INSTRUCTION
		-- lw x23, 8(x21)
		-- IMM			x21		funct3	x23		opcode	Field Name
		-- 000000001000	10101	010		10111	0000011	Field Value
		-- 0x008AAB83
		pc_in <= x"00000008";		
		instruction <= X"008AAB83";

		wait for clk_period;

		-- STORE INSTRUCTION
		-- sw x10, 12(x20)
		-- IMM		x20		x10		funct3	IMM		opcode	Field Name
		-- 0001100	10100	01010	010		01100	0100011	Field Value
		-- 0x19452623
		pc_in <= x"0000000C";
		instruction <= X"00AA2623";

		wait for clk_period;

		-- BRANCH INSTRUCTION
		-- beq x20, x0, 40560
		-- IMM		x0		x20		funct3		IMM		opcode	Field Name
		-- 1110000	00000	10100	000			10000	1100011	Field Value
		-- 0xE00A0863
		pc_in <= x"00000010";		
		instruction <= X"020A0263";

		wait for clk_period;

		-- JAL INSTRUCTION
		-- jal 110205678
		-- IMM					ra		opcode	Field Name
		-- 00011001101011101110	00001	1101111	Field Value
		-- 0x19AEE0EF
		pc_in <= x"00000014";				
		instruction <= X"020000EF";

		wait for clk_period;

		-- JALR INSTRUCTION
		-- jalr ra, 24(x20)
		-- IMM			x20		funct3	ra		opcode	Field Name
		-- 000000011000	10100	000		00001	1100111	Field Value
		-- 0x018A00E7
		pc_in <= x"00000018";		
		instruction <= X"018A00E7";
		
		wait;

	end process;

END;
