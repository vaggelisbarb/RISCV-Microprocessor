library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

-- ALU is the main component of the central processing unit,
-- which stands for arithmetic logic unit and performs arithmetic and logic operations.
entity alu is

	port(
		reset         : in  STD_LOGIC;  -- Enable signal
		alu_operand1  : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- First operand data (src1)
		alu_operand2  : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Second operand data (src2)
		alu_operation : in  ALU_operation; -- The arithmetic/logical operation that the ALU will execute
		alu_result    : out STD_LOGIC_VECTOR(31 DOWNTO 0) -- ALU result data
	);

end alu;

architecture alu_behavior of alu is

	-- stores the properly result data	
	signal result : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

	calculation : process(reset, alu_operand1, alu_operand2, alu_operation)
	begin
		if reset = '0' then
			case alu_operation is
				when ALU_ADD =>
					result <= std_logic_vector(unsigned(alu_operand1) + unsigned(alu_operand2));
				when ALU_SUB =>
					result <= std_logic_vector(unsigned(alu_operand1) - unsigned(alu_operand2));
				when ALU_AND =>
					result <= alu_operand1 and alu_operand2;
				when ALU_OR =>
					result <= alu_operand1 or alu_operand2;
				when ALU_XOR =>
					result <= alu_operand1 xor alu_operand2;
				when ALU_SLT =>
					if signed(alu_operand1) < signed(alu_operand2) then
						result <= X"00000001";
					else
						result <= X"00000000";
					end if;
				when ALU_SLTU =>
					if unsigned(alu_operand1) < unsigned(alu_operand2) then
						result <= X"00000001";
					else
						result <= X"00000000";
					end if;
				when ALU_SRL =>
					result <= std_logic_vector(shift_right(unsigned(alu_operand1), to_integer(unsigned(alu_operand2(4 DOWNTO 0)))));
				when ALU_SLL =>
					result <= std_logic_vector(shift_left(unsigned(alu_operand1), to_integer(unsigned(alu_operand2(4 DOWNTO 0)))));
				when ALU_SRA =>
					result <= std_logic_vector(shift_right(unsigned(alu_operand1), to_integer(signed(alu_operand2(4 DOWNTO 0)))));
				when ALU_NOP =>
					result <= (others => '0');
				when ALU_INV =>
					result <= (others => '0');
			end case;
		end if;
	end process;

	alu_result <= result;

end alu_behavior;
