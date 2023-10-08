library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.constants.all;
use work.aux_categories.all;

entity control_unit_tb is
end control_unit_tb;

architecture control_unit_beh of control_unit_tb is

	component control_unit
		port(
			opcode                         : in  OPCODE_SIZE;
			funct7                         : in  FUNCT7_SIZE;
			funct3                         : in  FUNCT3_SIZE;
			regWrite                       : out STD_LOGIC;
			branch                         : out BRANCH_type;
			alu_rs1_source, alu_rs2_source : out ALU_source_operands;
			alu_operation                  : out work.aux_categories.ALU_operation;
			branch_comp_op                 : out BRANCH_comparison_type;
			memRead                        : out STD_LOGIC;
			memWrite                       : out STD_LOGIC;
			mem_op_out                     : out MEM_op_type
		);
	end component control_unit;

	signal clock                       : STD_LOGIC;
	signal opcode_in, funct7_in        : STD_LOGIC_VECTOR(6 DOWNTO 0);
	signal funct3_in                   : STD_LOGIC_VECTOR(2 DOWNTO 0);
	signal regWrite, memRead, memWrite : STD_LOGIC;
	signal aluData1, aluData2          : ALU_source_operands;
	signal alu_operation               : ALU_operation;
	signal branch                      : BRANCH_type;
	signal mem_op_out                  : MEM_op_type;
	signal branch_comp_op : BRANCH_comparison_type;

	constant clk_period : time := 10 ns;

begin

	UUT : control_unit
		port map(
			opcode         => opcode_in,
			funct7         => funct7_in,
			funct3         => funct3_in,
			regWrite       => regWrite,
			branch         => branch,
			alu_rs1_source => aluData1,
			alu_rs2_source => aluData2,
			alu_operation  => alu_operation,
			branch_comp_op => branch_comp_op,
			memRead        => memRead,
			memWrite       => memWrite,
			mem_op_out     => mem_op_out
		);

	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	control_process : process
	begin

		-- instruction <= 0x00AE0533;
		-- ADD
		wait for clk_period/2;
		opcode_in <= "0110011";
		funct7_in <= "0000000";
		funct3_in <= "000";

		-- instruction 0x06957A13
		-- ANDI
		wait for clk_period;
		opcode_in <= "0010011";
		funct7_in <= "0000011";
		funct3_in <= "111";

		-- instruction 0x008AAB83
		-- LW
		wait for clk_period;
		opcode_in <= "0000011";
		funct7_in <= "0000000";
		funct3_in <= "010";

		--instruction 0x00AA2623
		-- SW
		wait for clk_period;
		opcode_in <= "0100011";
		funct7_in <= "0000000";
		funct3_in <= "010";

		-- instruction 0x020A0263
		-- BEQ
		wait for clk_period;
		opcode_in <= "1100011";
		funct7_in <= "0000001";
		funct3_in <= "000";

		-- instruction 0x020000EF
		-- JAL
		wait for clk_period;
		opcode_in <= "1101111";
		funct7_in <= "0000001";
		funct3_in <= "000";

		wait;

	end process;
end;
