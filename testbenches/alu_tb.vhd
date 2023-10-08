library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;


entity alu_tb is
end alu_tb;

architecture alu_beh of alu_tb is
	
	component alu
		port(
			reset         : in  STD_LOGIC;
			alu_operand1  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			alu_operand2  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			alu_operation : in  ALU_operation;
			alu_result    : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component alu;


	constant clk_period        : time := 10 ns;
	signal clock : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal alu_operand1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal alu_operand2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal alu_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal alu_op : ALU_operation;


begin

	UUT : alu
		port map(
			reset => reset,
			alu_operand1 => alu_operand1,
			alu_operand2 => alu_operand2,
			alu_operation => alu_op,
			alu_result => alu_result
		);
		
		
	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	alu_calculations_process : process
	begin
		
		reset <= '0';
		
		alu_operand1 <= x"00000068";
		alu_operand2 <= x"00000015";
		alu_op <= ALU_ADD;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000068";
		alu_operand2 <= x"00000015";
		alu_op <= ALU_SUB;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000148";
		alu_operand2 <= x"00000881";
		alu_op <= ALU_AND;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000148";
		alu_operand2 <= x"00000881";
		alu_op <= ALU_OR;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000068";
		alu_operand2 <= x"00000015";
		alu_op <= ALU_XOR;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000002";
		alu_operand2 <= x"00000005";
		alu_op <= ALU_SLT;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000002";
		alu_operand2 <= x"00000005";
		alu_op <= ALU_SLTU;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000014";
		alu_operand2 <= x"00000002";
		alu_op <= ALU_SRL;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000014";
		alu_operand2 <= x"00000002";
		alu_op <= ALU_SLL;
		
		wait for clk_period;
		
		alu_operand1 <= x"00000014";
		alu_operand2 <= x"00000002";		
		alu_op <= ALU_SRA;
		
		wait;
		
	end process;


end alu_beh;