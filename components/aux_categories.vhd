library ieee;
use ieee.std_logic_1164.all;

package aux_categories is

	-- RISC-V CPU 5 stages
	type RV_STAGE is (
		NONE, InF, ID, EXE, MEM, WB
	);

	-- Each arithemtic/logical operation that can be executed in the ALU unit
	type ALU_operation is (
		ALU_ADD, ALU_SUB,
		ALU_AND, ALU_OR, ALU_XOR,
		ALU_SLT, ALU_SLTU,
		ALU_SRL, ALU_SLL, ALU_SRA,
		ALU_NOP, ALU_INV
	);
	
	type BRANCH_comparison_type is (
		IS_EQUAL, NOT_EQUAL, LESS_THAN, GREATER_THAN, LESS_THAN_UNSIGNED, GREATER_THAN_UNSIGNED,
		NON_COMP
	);

	-- Every possible source where the values of the operands can come from
	type ALU_source_operands is (
		ALU_SRC_REG, ALU_SRC_IMM, ALU_SRC_PC, ALU_SRC_PC_NEXT, ALU_SRC_NULL
	);

	-- The categories of branch types
	type BRANCH_type is (
		BRANCH_NONE,
		BRANCH_JUMP,
		BRANCH_JUMP_INDIRECT,
		BRANCH_CONDITIONAL
	);

	-- Memory operations used for load/store instructions
	type MEM_op_type is (
		MEM_NONE, MEM_LOAD_WORD, MEM_LOAD_BYTE, MEM_LOAD_HALF_WORD, MEM_LOAD_HALF_UNSIGNED, MEM_LOAD_BYTE_UNSIGNED,
		MEM_STORE_WORD, MEM_STORE_BYTE, MEM_STORE_HALF_WORD
	);
	
	type PC_STATE is (
		PC_INCREMENT, PC_NOP, PC_BRANCH, PC_RESET, PC_HALT
	);
	
	
end package aux_categories;

package body aux_categories is
	
end package body aux_categories;
