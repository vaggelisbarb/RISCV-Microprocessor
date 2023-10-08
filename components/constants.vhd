library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is

	subtype REG is STD_LOGIC_VECTOR(4 DOWNTO 0); -- Register address
	subtype OPCODE_SIZE is STD_LOGIC_VECTOR(6 DOWNTO 0);
	subtype FUNCT7_SIZE is STD_LOGIC_VECTOR(6 DOWNTO 0);
	subtype FUNCT3_SIZE is STD_LOGIC_VECTOR(2 DOWNTO 0);
	subtype INSTRUCTION_LENGTH is STD_LOGIC_VECTOR(31 DOWNTO 0);

	constant NOP : STD_LOGIC_VECTOR(31 DOWNTO 0) := X"00000013"; -- NOP instruction : addi x0, x0, 0

	constant ADDRESS_RESET  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
	constant OPCODE_INVALID : STD_LOGIC_VECTOR(6 DOWNTO 0)  := "0000000";

	-- RV32I Istruction Formats
	constant OPCODE_START : integer := 6; -- opcode MSB
	constant OPCODE_END   : integer := 0; -- opcode LSB

	constant RD_START : integer := 11;  -- rD MSB
	constant RD_END   : integer := 7;   -- rD LSB

	constant FUNCT3_START : integer := 14; -- funct3 MSB
	constant FUNCT3_END   : integer := 12; -- funct3 LSB

	constant RS1_START : integer := 19; -- rs1 MSB
	constant RS1_END   : integer := 15; -- rs1 LSB
	constant RS2_START : integer := 24; -- rs2 MSB
	constant RS2_END   : integer := 20; -- rs2 LSB

	constant FUNCT7_START : integer := 31; -- funct7 MSB
	constant FUNCT7_END   : integer := 25; -- funct7 LSB

	-- I-TYPE IMMEDIATE FORMAT
	constant IMM_ITYPE_START : integer := 31; -- I-Type immediate MSB / imm[11]
	constant IMM_ITYPE_END   : integer := 20; -- I-Type immediate LSB / imm[0]

	-- S-TYPE IMMEDIATE FORMAT
	constant IMM_A_STYPE_START : integer := 31; -- S-Type immediate MSB / imm[11]
	constant IMM_A_STYPE_END   : integer := 25; -- S-Type imm[5]
	constant IMM_B_STYPE_START : integer := 11; -- S-Type imm[4]
	constant IMM_B_STYPE_END   : integer := 7; -- S-Type immediate LSB / imm[0]

	-- B-TYPE IMMEDIATE FORMAT
	constant IMM_A_BTYPE_START : integer := 31; -- B-Type immediate MSB / imm[12]
	constant IMM_A_BTYPE_END   : integer := 25; -- B-Type imm[5]
	constant IMM_B_BTYPE_START : integer := 11; -- B-Type imm[4]
	constant IMM_B_BTYPE_END   : integer := 8; -- B-Type imm[1]

	-- U-TYPE IMMEDIATE FORMAT
	constant IMM_UTYPE_START : integer := 31; -- U-Type immediate MSB / imm[31]
	constant IMM_UTYPE_END   : integer := 12; -- U-Type imm [12]

	-- J-TYPE IMMEDIATE FORMAT
	constant IMM_JTYPE_START : integer := 31;
	constant IMM_JTYPE_END   : integer := 12;

	-- INSTRUCTIONS OPCODE 
	constant OPCODE_RTYPE        : std_logic_vector(6 DOWNTO 0) := "0110011";
	constant OPCODE_ITYPE_ALU    : std_logic_vector(6 DOWNTO 0) := "0010011";
	constant OPCODE_ITYPE_LOAD   : std_logic_vector(6 DOWNTO 0) := "0000011";
	constant OPCODE_STYPE_STORE  : std_logic_vector(6 DOWNTO 0) := "0100011";
	constant OPCODE_BTYPE_BRANCH : std_logic_vector(6 DOWNTO 0) := "1100011";
	constant OPCODE_JTYPE_JAL    : std_logic_vector(6 DOWNTO 0) := "1101111";
	constant OPCODE_ITYPE_JALR   : std_logic_vector(6 DOWNTO 0) := "1100111";
	constant OPCODE_UTYPE_LUI    : std_logic_vector(6 DOWNTO 0) := "0110111";
	constant OPCODE_UTYPE_AUIPC  : std_logic_vector(6 DOWNTO 0) := "0010111";
	constant OPCODE_ITYPE_ECALL  : std_logic_vector(6 DOWNTO 0) := "1110011";
	constant OPCODE_ITYPE_EBREAK : std_logic_vector(6 DOWNTO 0) := "1110011";

	-- INSTRUCTIONS FUNCT7 & FUNCT3
	--
	constant F3_ADD : std_logic_vector(2 DOWNTO 0) := "000";
	constant F7_ADD : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SUB : std_logic_vector(2 DOWNTO 0) := "000";
	constant F7_SUB : std_logic_vector(6 DOWNTO 0) := "0100000";

	constant F3_XOR : std_logic_vector(2 DOWNTO 0) := "100";
	constant F7_XOR : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_OR : std_logic_vector(2 DOWNTO 0) := "110";
	constant F7_OR : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_AND : std_logic_vector(2 DOWNTO 0) := "111";
	constant F7_AND : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SLL : std_logic_vector(2 DOWNTO 0) := "001";
	constant F7_SLL : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SRL : std_logic_vector(2 DOWNTO 0) := "101";
	constant F7_SRL : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SRA : std_logic_vector(2 DOWNTO 0) := "101";
	constant F7_SRA : std_logic_vector(6 DOWNTO 0) := "0100000";

	constant F3_SLT : std_logic_vector(2 DOWNTO 0) := "010";
	constant F7_STL : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SLTU : std_logic_vector(2 DOWNTO 0) := "011";
	constant F7_SLTU : std_logic_vector(6 DOWNTO 0) := "0000000";

	--
	constant F3_ADDI : std_logic_vector(2 DOWNTO 0) := "000";

	constant F3_XORI : std_logic_vector(2 DOWNTO 0) := "100";

	constant F3_ORI : std_logic_vector(2 DOWNTO 0) := "110";

	constant F3_ANDI : std_logic_vector(2 DOWNTO 0) := "111";

	constant F3_SLLI : std_logic_vector(2 DOWNTO 0) := "001";
	constant F7_SLLI : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SRLI : std_logic_vector(2 DOWNTO 0) := "101";
	constant F7_SRLI : std_logic_vector(6 DOWNTO 0) := "0000000";

	constant F3_SRAI : std_logic_vector(2 DOWNTO 0) := "101";
	constant F7_SRAI : std_logic_vector(6 DOWNTO 0) := "0100000";

	constant F3_SLTI : std_logic_vector(2 DOWNTO 0) := "010";

	constant F3_SLTIU : std_logic_vector(2 DOWNTO 0) := "011";

	--	
	constant F3_LB : std_logic_vector(2 DOWNTO 0) := "000";

	constant F3_LH : std_logic_vector(2 DOWNTO 0) := "001";

	constant F3_LW : std_logic_vector(2 DOWNTO 0) := "010";

	constant F3_LBU : std_logic_vector(2 DOWNTO 0) := "100";

	constant F3_LHU : std_logic_vector(2 DOWNTO 0) := "110";

	--	
	constant F3_SB : std_logic_vector(2 DOWNTO 0) := "000";

	constant F3_SH : std_logic_vector(2 DOWNTO 0) := "001";

	constant F3_SW : std_logic_vector(2 DOWNTO 0) := "010";

	--
	constant F3_BEQ : std_logic_vector(2 DOWNTO 0) := "000";

	constant F3_BNE : std_logic_vector(2 DOWNTO 0) := "001";

	constant F3_BLT : std_logic_vector(2 DOWNTO 0) := "100";

	constant F3_BGE : std_logic_vector(2 DOWNTO 0) := "101";

	constant F3_BLTU : std_logic_vector(2 DOWNTO 0) := "110";

	constant F3_BGEU : std_logic_vector(2 DOWNTO 0) := "111";

	--
	constant F3_JAL  : std_logic_vector(2 DOWNTO 0) := "000";
	constant F3_JALR : std_logic_vector(2 DOWNTO 0) := "000";

	--
	constant F3_ECALL : std_logic_vector(2 DOWNTO 0) := "000";
	constant F7_ECALL : std_logic_vector(6 DOWNTO 0) := "0000000";

	--
	constant F3_EBREAK : std_logic_vector(2 DOWNTO 0) := "000";

	--
	constant F7_EBREAK : std_logic_vector(6 DOWNTO 0) := "0000001";

end package constants;

package body constants is

end package body constants;
