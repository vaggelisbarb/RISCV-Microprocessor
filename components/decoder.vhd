library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.constants.all;
use work.aux_categories.all;

-- Represents the decoder. The instruction is decodes based on the format of each instruction type.
entity decoder is

	port(
		clock           : in  STD_LOGIC; -- Clock 
		reset           : in  STD_LOGIC; -- Enable in 						
		flush           : in  STD_LOGIC;
		stall           : in  STD_LOGIC;
		pc_in           : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		instruction     : in  INSTRUCTION_LENGTH; -- Input instruction to be decoded
		pc_out          : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		rs1             : out REG;      -- rs1 register 
		rs2             : out REG;      -- rs2 register
		rd              : out REG;      -- rD register 
		opcode          : out OPCODE_SIZE; -- Opcode
		immediate       : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- Immediate data output
		funct7          : out FUNCT7_SIZE; -- funct 7 field
		funct3          : out FUNCT3_SIZE -- funct 3 field

	);

end decoder;

architecture decoder_behavior of decoder is
	
	signal instruction_to_decode : INSTRUCTION_LENGTH;
	
begin

	pip_reg : process(clock)
	begin
		if RISING_EDGE(clock) then
			if reset = '0' and stall = '0' and flush = '0' then
				pc_out <= pc_in;
				instruction_to_decode <= instruction;
			elsif stall = '1' then
				pc_out <= pc_in;
				--instruction_to_decode <= instruction;
			elsif reset = '1' then
				pc_out <= ADDRESS_RESET;
			end if;
		end if;
	end process;
	
	instruction_decoding : process(instruction_to_decode)
	begin
		-- Decoding instruction
		-- Getting opcode, rd, rs1, rs2, funct7, funct3 fields	
		rs1    <= instruction_to_decode(RS1_START DOWNTO RS1_END);
		rs2    <= instruction_to_decode(RS2_START DOWNTO RS2_END);
		rd     <= instruction_to_decode(RD_START DOWNTO RD_END);
		funct7 <= instruction_to_decode(FUNCT7_START DOWNTO FUNCT7_END);
		funct3 <= instruction_to_decode(FUNCT3_START DOWNTO FUNCT3_END);

				case instruction_to_decode(OPCODE_START DOWNTO OPCODE_END) is
					when OPCODE_RTYPE =>
						opcode          <= OPCODE_RTYPE;
					when OPCODE_ITYPE_ALU =>
						opcode          <= OPCODE_ITYPE_ALU;
						if instruction_to_decode(IMM_ITYPE_START) = '1' then
							immediate <= X"FFFFF" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
						else
							immediate <= X"00000" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
						end if;
					when OPCODE_ITYPE_LOAD =>
						if instruction_to_decode(1 DOWNTO 0) = "11" then
							opcode          <= OPCODE_ITYPE_LOAD;
							if instruction_to_decode(IMM_ITYPE_START) = '1' then
								immediate <= X"FFFFF" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
							else
								immediate <= X"00000" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
							end if;
						end if;
					when OPCODE_STYPE_STORE =>
						opcode          <= OPCODE_STYPE_STORE;
						if instruction_to_decode(IMM_A_STYPE_START) = '1' then
							immediate <= X"FFFFF" & instruction_to_decode(IMM_A_STYPE_START DOWNTO IMM_A_STYPE_END) & instruction_to_decode(IMM_B_STYPE_START DOWNTO IMM_B_STYPE_END);
						else
							immediate <= X"00000" & instruction_to_decode(IMM_A_STYPE_START DOWNTO IMM_A_STYPE_END) & instruction_to_decode(IMM_B_STYPE_START DOWNTO IMM_B_STYPE_END);
						end if;

					when OPCODE_BTYPE_BRANCH =>
						opcode          <= OPCODE_BTYPE_BRANCH;
						if instruction_to_decode(IMM_A_BTYPE_START) = '1' then
							immediate <= X"FFFF" & "111" & instruction_to_decode(IMM_A_BTYPE_START) & instruction_to_decode(7) & instruction_to_decode(30 DOWNTO IMM_A_BTYPE_END) & instruction_to_decode(IMM_B_BTYPE_START DOWNTO IMM_B_BTYPE_END) & '0';
						else
							immediate <= X"0000" & "000" & instruction_to_decode(IMM_A_BTYPE_START) & instruction_to_decode(7) & instruction_to_decode(30 DOWNTO IMM_A_BTYPE_END) & instruction_to_decode(IMM_B_BTYPE_START DOWNTO IMM_B_BTYPE_END) & '0';
						end if;

					when OPCODE_JTYPE_JAL =>
						opcode <= OPCODE_JTYPE_JAL;
						if instruction_to_decode(IMM_JTYPE_START) = '1' then
							immediate <= X"FF" & "111" & instruction_to_decode(IMM_JTYPE_START) & instruction_to_decode(19 DOWNTO 12) & instruction_to_decode(20) & instruction_to_decode(30 DOWNTO 21) & '0';
						else
							immediate <= X"00" & "000" & instruction_to_decode(IMM_JTYPE_START) & instruction_to_decode(19 DOWNTO 12) & instruction_to_decode(20) & instruction_to_decode(30 DOWNTO 21) & '0';
						end if;

					when OPCODE_ITYPE_JALR =>
						opcode <= OPCODE_ITYPE_JALR;
						if instruction_to_decode(IMM_ITYPE_START) = '1' then
							immediate <= X"FFFFF" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
						else
							immediate <= X"00000" & instruction_to_decode(IMM_ITYPE_START DOWNTO IMM_ITYPE_END);
						end if;

					when OPCODE_UTYPE_LUI =>
						opcode <= OPCODE_UTYPE_LUI;
						immediate <= instruction_to_decode(IMM_UTYPE_START DOWNTO IMM_UTYPE_END) & X"000";

					when OPCODE_UTYPE_AUIPC =>
						opcode <= OPCODE_UTYPE_AUIPC;
						immediate <= instruction_to_decode(IMM_UTYPE_START DOWNTO IMM_UTYPE_END) & X"000";

					when OPCODE_ITYPE_ECALL =>
						opcode          <= OPCODE_ITYPE_ECALL;
						immediate       <= X"00000000";

					when others =>
						opcode          <= OPCODE_INVALID;
						immediate       <= X"00000000";
				end case;
		end process;

end decoder_behavior;
