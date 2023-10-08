library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;

entity data_memory_tb is
end entity;

architecture dmem_beh of data_memory_tb is

	component data_memory
		port(
			clock                       : in  STD_LOGIC;
			reset                       : in  STD_LOGIC;
			stall                       : in  STD_LOGIC;
			dmem_addr_in                : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_data_in                  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_read_in, dmem_write_in : in  STD_LOGIC;
			dmem_op_in                  : in  MEM_op_type;
			rd_reg_in                   : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_write_out                : out STD_LOGIC;
			rd_reg_out                  : out STD_LOGIC_VECTOR(4 DOWNTO 0);
			rd_data_out                 : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_op_out                  : out MEM_op_type
		);
	end component data_memory;

	constant clk_period : time := 10 ns;
	signal clock        : STD_LOGIC;
	signal mem_addr_in  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mem_data_in  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mem_read_in  : STD_LOGIC;
	signal mem_write_in : STD_LOGIC;
	signal mem_op_in    : MEM_op_type;
	signal mem_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal reset        : STD_LOGIC;
	signal rd_reg_in    : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rd_reg_out   : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal mem_op_out   : MEM_op_type;
	signal rd_write_out : STD_LOGIC;
	signal stall        : STD_LOGIC;

begin

	UUT : data_memory
		port map(
			clock         => clock,
			reset         => reset,
			stall         => stall,
			dmem_addr_in  => mem_addr_in,
			rd_data_in    => mem_data_in,
			dmem_read_in  => mem_read_in,
			dmem_write_in => mem_write_in,
			dmem_op_in    => mem_op_in,
			rd_reg_in     => rd_reg_in,
			rd_write_out  => rd_write_out,
			rd_reg_out    => rd_reg_out,
			rd_data_out   => mem_data_out,
			mem_op_out    => mem_op_out
		);

	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	mem_proc : process
	begin
		wait for 50 ns;

		-- STORE MODE

		reset <= '0';
		stall <= '0';

		-- Store Word
		mem_addr_in  <= x"00000010";
		mem_data_in  <= x"0000011A";
		mem_op_in    <= MEM_STORE_WORD;
		mem_write_in <= '1';
		mem_read_in  <= '0';
		rd_reg_in    <= "00000";

		wait for clk_period;

		-- Store Byte
		mem_addr_in  <= x"00000001";
		mem_data_in  <= x"00000001";
		mem_op_in    <= MEM_STORE_BYTE;
		mem_write_in <= '1';
		mem_read_in  <= '0';
		rd_reg_in    <= "00000";

		wait for clk_period;

		-- Store half word
		mem_addr_in  <= x"00000020";
		mem_data_in  <= x"00000002";
		mem_op_in    <= MEM_STORE_HALF_WORD;
		mem_write_in <= '1';
		mem_read_in  <= '0';

		wait for clk_period * 2;

		-- LOAD MODE

		-- Load word
		mem_addr_in  <= x"00000010";
		mem_op_in    <= MEM_LOAD_WORD;
		rd_reg_in    <= "00010";
		mem_write_in <= '0';
		mem_read_in  <= '1';
		mem_data_in  <= (others => '0');

		wait for clk_period;

		-- Load byte
		mem_addr_in  <= x"00000001";
		mem_op_in    <= MEM_LOAD_BYTE;
		rd_reg_in    <= "01000";
		mem_write_in <= '0';
		mem_read_in  <= '1';
		mem_data_in  <= (others => '0');

		wait for clk_period;

		-- Load half word;
		mem_addr_in  <= x"00000020";
		mem_op_in    <= MEM_LOAD_HALF_WORD;
		rd_reg_in    <= "00111";
		mem_write_in <= '0';
		mem_read_in  <= '1';
		mem_data_in  <= (others => '0');

		wait for clk_period;

		-- Load byte unsigned
		mem_addr_in  <= x"00000001";
		mem_op_in    <= MEM_LOAD_BYTE_UNSIGNED;
		rd_reg_in    <= "01000";
		mem_write_in <= '0';
		mem_read_in  <= '1';
		mem_data_in  <= (others => '0');

		wait for clk_period;

	end process;

end;
