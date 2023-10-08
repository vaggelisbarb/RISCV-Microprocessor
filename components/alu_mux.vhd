library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

-- Multiplexer that selects the data source of the ALU input
entity alu_mux is

	port(
		source       : in  ALU_source_operands; -- Data source

		reg_value    : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Register value
		imm_value    : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Immediate value
		pc_value     : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- PC value

		output_value : out STD_LOGIC_VECTOR(31 DOWNTO 0) -- Register/Immediate/PC value based on the given data source
	);
end alu_mux;

architecture alu_mux_behavior of alu_mux is
begin

	alu_operand_source_selection : process(source, reg_value, imm_value, pc_value)
	begin
		case source is
			when ALU_SRC_REG =>
				output_value <= reg_value;
			when ALU_SRC_IMM =>
				output_value <= imm_value;
			when ALU_SRC_PC =>
				output_value <= pc_value;
			when ALU_SRC_PC_NEXT =>
				output_value <= std_logic_vector(unsigned(pc_value) + 4);
			when ALU_SRC_NULL =>
				output_value <= (others => '0');
		end case;
	end process;
end alu_mux_behavior;
