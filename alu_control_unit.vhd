library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.constants.all;
use work.aux_categories.all;

-- ALU CONTROL : component that is responsible to give as output the properly ALU operation type,
-- based on the instruction's indices.
entity alu_control_unit is

	port(
		opcode                         : in  OPCODE_SIZE; -- Instruction's opcode
		funct7                         : in  FUNCT7_SIZE; -- Instruction's funct7
		funct3                         : in  FUNCT3_SIZE; -- Instruction's funct3
		alu_operation                  : out ALU_operation; -- ALU operation based on the instruction's type
		alu_rs1_source, alu_rs2_source : out ALU_source_operands -- Source of the 2 operands (Register, Immediate etc)
	);

end alu_control_unit;

architecture alu_control_unit_behavior of alu_control_unit is
begin

	alu_control_signals_setup : process(opcode, funct7, funct3)
	begin
		alu_operation  <= ALU_NOP;
		alu_rs1_source <= ALU_SRC_NULL;
		alu_rs2_source <= ALU_SRC_NULL;
		case opcode is
			when OPCODE_RTYPE =>
				alu_rs1_source <= ALU_SRC_REG;
				alu_rs2_source <= ALU_SRC_REG;

				if funct3 = F3_ADD OR funct3 = F3_SUB then
					if funct7 = F7_ADD then
						alu_operation <= ALU_ADD;
					elsif funct7 = F7_SUB then
						alu_operation <= ALU_SUB;
					end if;
				elsif funct3 = F3_XOR then
					alu_operation <= ALU_XOR;
				elsif funct3 = F3_OR then
					alu_operation <= ALU_OR;
				elsif funct3 = F3_AND then
					alu_operation <= ALU_AND;
				elsif funct3 = F3_SLL then
					alu_operation <= ALU_SLL;
				elsif funct3 = F3_SRL or funct3 = F3_SRA then
					if funct7 = F7_SRL then
						alu_operation <= ALU_SRL;
					elsif funct7 = F7_SRA then
						alu_operation <= ALU_SRA;
					end if;
				elsif funct3 = F3_SLT then
					alu_operation <= ALU_SLT;
				elsif funct3 = F3_SLTU then
					alu_operation <= ALU_SLTU;
				end if;

			when OPCODE_ITYPE_ALU =>
				alu_rs1_source <= ALU_SRC_REG;
				alu_rs2_source <= ALU_SRC_IMM;

				if funct3 = F3_ADDI then
					alu_operation <= ALU_ADD;
				elsif funct3 = F3_XORI then
					alu_operation <= ALU_XOR;
				elsif funct3 = F3_ORI then
					alu_operation <= ALU_OR;
				elsif funct3 = F3_ANDI then
					alu_operation <= ALU_AND;
				elsif funct3 = F3_SLLI then
					alu_operation <= ALU_SLL;
				elsif funct3 = F3_SRLI OR funct3 = F3_SRAI then
					if funct7 = F7_SRLI then
						alu_operation <= ALU_SRL;
					elsif funct7 = F7_SRAI then
						alu_operation <= ALU_SRA;
					end if;
				elsif funct3 = F3_SLTI then
					alu_operation <= ALU_SLT;
				elsif funct3 = F3_SLTIU then
					alu_operation <= ALU_SLTU;
				end if;

			when OPCODE_ITYPE_LOAD =>
				alu_rs1_source <= ALU_SRC_REG;
				alu_rs2_source <= ALU_SRC_IMM;
				alu_operation  <= ALU_ADD;

			when OPCODE_STYPE_STORE =>
				alu_rs1_source <= ALU_SRC_REG;
				alu_rs2_source <= ALU_SRC_IMM;
				alu_operation  <= ALU_ADD;

			when OPCODE_BTYPE_BRANCH =>
				alu_rs1_source <= ALU_SRC_REG;
				alu_rs2_source <= ALU_SRC_REG;
				alu_operation <= ALU_NOP;
				
			when OPCODE_JTYPE_JAL =>
				alu_rs1_source <= ALU_SRC_PC_NEXT;
				alu_rs2_source <= ALU_SRC_NULL;
				alu_operation  <= ALU_ADD;

			when OPCODE_ITYPE_JALR =>
				alu_rs1_source <= ALU_SRC_PC_NEXT;
				alu_rs2_source <= ALU_SRC_NULL;
				alu_operation  <= ALU_ADD;

			when OPCODE_UTYPE_LUI =>
				alu_rs1_source <= ALU_SRC_NULL;
				alu_rs2_source <= ALU_SRC_IMM;
				alu_operation  <= ALU_ADD;

			when OPCODE_UTYPE_AUIPC =>
				alu_rs1_source <= ALU_SRC_PC;
				alu_rs2_source <= ALU_SRC_IMM;
				alu_operation  <= ALU_ADD;

			when others =>
		end case;
	end process;
end alu_control_unit_behavior;
