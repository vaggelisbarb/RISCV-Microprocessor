library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;

entity writeback is
	port(
		clock        : in  STD_LOGIC;
		reset        : in  STD_LOGIC;
		rd_reg_in    : in  REG;
		rd_write_in  : in  STD_LOGIC;
		rd_data_in   : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd_reg_out   : out REG;
		rd_write_out : out STD_LOGIC;
		rd_data_out  : out STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end writeback;

architecture wb_behavior of writeback is
begin

	pip_reg : process(clock)
	begin
		if rising_edge(clock) then
			if reset = '1' then
				rd_write_out <= '0';
			else
				rd_write_out <= rd_write_in;
				rd_reg_out   <= rd_reg_in;
				rd_data_out  <= rd_data_in;

			end if;
		end if;
	end process;

end wb_behavior;
