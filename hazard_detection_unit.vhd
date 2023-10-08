library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;


entity hazard_detection_unit is
	
	port(
		dmem_op : in MEM_op_type;
		dmem_read : in STD_LOGIC;
		
		rs1_source : in ALU_source_operands;
		rs2_source : in ALU_source_operands;
		
		rs1 : in REG;
		rs2 : in REG;
				
		rd : in REG;
		
		hazard : out STD_LOGIC
	);
	
end hazard_detection_unit;

architecture hazard_detection_beh of hazard_detection_unit is
begin
		
	detect_load_hazard  : process (dmem_op, rd, rs1, rs1_source, rs2, rs2_source, dmem_read)
	begin
		if (dmem_op = MEM_LOAD_WORD or
			dmem_op = MEM_LOAD_BYTE or
			dmem_op = MEM_LOAD_HALF_WORD or
			dmem_op = MEM_LOAD_HALF_UNSIGNED or
			dmem_op = MEM_LOAD_BYTE_UNSIGNED) and
			dmem_read = '1' then
			
			if (rs1_source = ALU_SRC_REG and rs1 = rd) or
				(rs2_source = ALU_SRC_REG and rs2 = rd) then
			
				hazard <= '1';
			else
				hazard <= '0';
			end if;
			
		end if;
		
	end process;
		
end hazard_detection_beh;