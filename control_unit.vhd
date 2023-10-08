library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.constants.all;
use work.aux_categories.all;

entity control_unit is
	port(
		-- Inputs that correspond to instruction bit parts
		opcode                         : in  OPCODE_SIZE; -- Opcode
		funct7                         : in  FUNCT7_SIZE; -- Funct7
		funct3                         : in  FUNCT3_SIZE; -- Funct3

		-- Control signals
		regWrite                       : out STD_LOGIC; -- Signal that enables data to be written to the rD register
		branch                         : out BRANCH_type; -- Branch types (Conditionial, direct etc)

		-- Source of the operands
		alu_rs1_source, alu_rs2_source : out ALU_source_operands; -- Operands value source (Register, Immediate etc)
		-- ALU Operation
		alu_operation                  : out ALU_operation; -- The ALU operation that needs to be executed by ALU
		-- Branch comparison operation
		branch_comp_op : out BRANCH_comparison_type;
		-- Memory signals
		memRead                        : out STD_LOGIC; -- Signal that indicates if a memory read action is needed
		memWrite                       : out STD_LOGIC; -- Signal that indicates if a memory write action is needed
		mem_op_out                     : out MEM_op_type -- Memory operation signal (Read/write, word/byte/half/unsigned)
	);

end control_unit;

architecture control_unit_behavior of control_unit is
begin

	control_alu : entity work.alu_control_unit
		port map(
			opcode         => opcode,
			funct7         => funct7,
			funct3         => funct3,
			alu_operation  => alu_operation,
			alu_rs1_source => alu_rs1_source,
			alu_rs2_source => alu_rs2_source
		);

	control_signals_setup : process(opcode, funct3)
	begin
		mem_op_out <= MEM_NONE;

		case opcode is
			when OPCODE_UTYPE_LUI =>
				regWrite <= '1';
				memRead  <= '1';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
			when OPCODE_UTYPE_AUIPC =>
				regWrite <= '1';
				memRead  <= '1';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
			when OPCODE_JTYPE_JAL =>
				regWrite <= '1';
				memRead  <= '0';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_JUMP;
			when OPCODE_ITYPE_JALR =>
				regWrite <= '1';
				memRead  <= '0';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_JUMP_INDIRECT;
			when OPCODE_BTYPE_BRANCH =>
				regWrite <= '0';
				memRead  <= '0';
				memWrite <= '0';
				branch   <= BRANCH_CONDITIONAL;
				case funct3 is
					when F3_BEQ =>
						branch_comp_op <= IS_EQUAL;
					when F3_BNE =>
						branch_comp_op <= NOT_EQUAL;
					when F3_BLT =>
						branch_comp_op <= LESS_THAN;
					when F3_BGE =>
						branch_comp_op <= GREATER_THAN;
					when F3_BLTU =>
						branch_comp_op <= LESS_THAN_UNSIGNED;
					when F3_BGEU =>
						branch_comp_op <= GREATER_THAN_UNSIGNED;
					when others =>
						branch_comp_op <= NON_COMP;
				end case;
			when OPCODE_ITYPE_LOAD =>
				regWrite <= '1';
				memRead  <= '1';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
				case funct3 is
					when F3_LB =>
						mem_op_out <= MEM_LOAD_BYTE;
					when F3_LH =>
						mem_op_out <= MEM_LOAD_HALF_WORD;
					when F3_LW =>
						mem_op_out <= MEM_LOAD_WORD;
					when F3_LBU =>
						mem_op_out <= MEM_LOAD_BYTE_UNSIGNED;
					when F3_LHU =>
						mem_op_out <= MEM_LOAD_HALF_UNSIGNED;
					when others =>
						mem_op_out <= MEM_NONE;
				end case;
			when OPCODE_STYPE_STORE =>
				regWrite <= '0';
				memRead  <= '0';
				memWrite <= '1';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
				case funct3 is
					when F3_SB =>
						mem_op_out <= MEM_STORE_BYTE;
					when F3_SH =>
						mem_op_out <= MEM_STORE_HALF_WORD;
					when F3_SW =>
						mem_op_out <= MEM_STORE_WORD;
					when others =>
						mem_op_out <= MEM_NONE;
				end case;
			when OPCODE_RTYPE =>
				regWrite <= '1';
				memRead  <= '0';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
			when OPCODE_ITYPE_ALU =>
				regWrite <= '1';
				memRead  <= '0';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
			when others =>
				regWrite <= '0';
				memRead  <= '0';
				memWrite <= '0';
				branch_comp_op <= NON_COMP;
				branch   <= BRANCH_NONE;
		end case;
	end process;

end control_unit_behavior;
