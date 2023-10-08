library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;

-- Represents the register file. It contains 32 registers of width 32 bit each.
entity register_file is
	port(
		clock           : in  STD_LOGIC; -- Clock signal
		reset           : in  STD_LOGIC; -- Enable signal
		rd_write_enable : in  STD_LOGIC; -- Write to rD register signal
		rd_data         : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data to be written in rD register
		rs1_reg         : in  REG;      -- Selection of rs1 register 
		rs2_reg         : in  REG;      -- Selection of rs2 register
		rd_reg          : in  REG;      -- Selection of rD register
		rs1_data        : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- rs1 register's value
		rs2_data        : out STD_LOGIC_VECTOR(31 DOWNTO 0) -- rs2 regsiter's value
	);
end register_file;

architecture register_file_behavior of register_file is
	-- 32 registers (type array) with size 32 bit each
	type REGISTERS is array (0 to 31) of STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- set all registers' value to 0
	signal regs_file : REGISTERS := (others => x"00000000");

begin
	-- Selects the properly registers from register file
	register_selection : process(clock)
	begin
		if rising_edge(clock) and reset = '0' then
			rs1_data <= regs_file(TO_INTEGER(unsigned(rs1_reg)));
			rs2_data <= regs_file(TO_INTEGER(unsigned(rs2_reg)));

			-- If write_enable is 1 data from rD_data_in have to saved in the register RD given from selD
			if rd_write_enable = '1' and rd_reg /= b"00000" then
				regs_file(TO_INTEGER(unsigned(rd_reg))) <= rd_data;
			end if;
		end if;
	end process;

end register_file_behavior;
