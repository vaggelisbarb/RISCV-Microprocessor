library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;


entity branch_unit is
	port(
		branch_comparison_op : in BRANCH_comparison_type;
		rs1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		rs2 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		comparison_result : out STD_LOGIC
	);
	
end branch_unit;

architecture branch_unit_behavior of branch_unit is
begin
	
	condition_comparison : process(branch_comparison_op, rs1, rs2)
	begin
		case branch_comparison_op is
			when IS_EQUAL =>
				if rs1 = rs2 then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when NOT_EQUAL =>
				if rs1 /= rs2 then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when LESS_THAN =>
				if signed(rs1) < signed(rs2) then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when GREATER_THAN =>
					if signed(rs1) >= signed(rs2) then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when LESS_THAN_UNSIGNED =>
				if unsigned(rs1) < unsigned(rs2) then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when GREATER_THAN_UNSIGNED =>
				if unsigned(rs1) >= unsigned(rs2) then
						comparison_result <= '1';
					else
						comparison_result <= '0';
					end if;
			when NON_COMP =>
				comparison_result <= '0';          
			end case;
	end process;
	
end branch_unit_behavior;