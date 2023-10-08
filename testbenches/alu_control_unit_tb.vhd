library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.constants.ALL;
use work.aux_categories.ALL;

ENTITY alu_control_unit_tb is
end alu_control_unit_tb;

ARCHITECTURE alu_control_unit_beh of alu_control_unit_tb is

	COMPONENT alu_control_unit
		PORT(
			opcode                         : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			funct7                         : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			funct3                         : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
			alu_operation                  : OUT ALU_operation;
			alu_rs1_source, alu_rs2_source : OUT ALU_source_operands
		);
	end COMPONENT;

	SIGNAL clock             : STD_LOGIC;
	SIGNAL opcode_in         : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL funct7_in         : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL funct3_in         : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL instruction       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL alu_operation_out : ALU_operation;
	SIGNAL aluData1_out      : ALU_source_operands;
	SIGNAL aluData2_out      : ALU_source_operands;

	CONSTANT clk_period : time := 10 ns;

BEGIN
	UUT : alu_control_unit
		PORT MAP(
			opcode         => opcode_in,
			funct7         => funct7_in,
			funct3         => funct3_in,
			alu_operation  => alu_operation_out,
			alu_rs1_source => aluData1_out,
			alu_rs2_source => aluData2_out
		);

	clock_process : PROCESS
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end PROCESS;

	control_process : PROCESS
	BEGIN
		wait for 50 ns;

		-- instruction <= X"01EE0533";
		opcode_in <= "0110011";
		funct7_in <= "0000000";
		funct3_in <= "000";

		wait for clk_period;

		-- instruction <= X"008AAB83";
		opcode_in <= "0000011";
		funct7_in <= "0000000";
		funct3_in <= "010";

		wait for clk_period;

		-- instruction <= X"19452623";
		opcode_in <= "1100011";
		funct7_in <= "1110000";
		funct3_in <= "000";

	end PROCESS;

END;
