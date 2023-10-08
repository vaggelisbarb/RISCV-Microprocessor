library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.constants.all;
use work.aux_categories.all;

entity processor_tb is
end entity;

architecture beh of processor_tb is

	component riscv_processor
		port(
			clock             : in  STD_LOGIC;
			reset             : in  STD_LOGIC;
			stall             : in  STD_LOGIC;
			flush             : in  STD_LOGIC;
			imem_addr_in      : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			imem_data_in      : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			imem_read_en_in   : in  STD_LOGIC;
			imem_write_en_in  : in  STD_LOGIC;
			dmem_data_address : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_data_in      : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_data_out     : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_read_en_in   : in  STD_LOGIC;
			dmem_write_en_in  : in  STD_LOGIC
		);
	end component riscv_processor;

	constant clk_period      : time := 10 ns;
	signal clock             : STD_LOGIC;
	signal reset             : STD_LOGIC;
	signal stall             : STD_LOGIC;
	signal flush             : STD_LOGIC;
	signal imem_data_in      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_write_en_in  : STD_LOGIC;
	signal imem_read_en_in   : STD_LOGIC;
	signal dmem_data_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal dmem_data_in      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal dmem_read_en_in   : STD_LOGIC;
	signal dmem_write_en_in  : STD_LOGIC;
	signal dmem_data_out     : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_request      : STD_LOGIC;
	signal imem_addr_in      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal stage             : RV_STAGE;

begin

	UUT : riscv_processor
		port map(
			clock             => clock,
			reset             => reset,
			stall             => stall,
			flush             => flush,
			imem_addr_in      => imem_addr_in,
			imem_data_in      => imem_data_in,
			imem_read_en_in   => imem_read_en_in,
			imem_write_en_in  => imem_write_en_in,
			dmem_data_address => dmem_data_address,
			dmem_data_in      => dmem_data_in,
			dmem_data_out     => dmem_data_out,
			dmem_read_en_in   => dmem_read_en_in,
			dmem_write_en_in  => dmem_write_en_in
		);

	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	processor_function : process
	begin
		reset <= '1';
		-- I MEM WRITE
		--reset            <= '0';
		--stall            <= '0';
		--flush            <= '0';
		--imem_addr_in     <= x"00000000";
		--imem_data_in     <= x"01EE0533";
		--imem_write_en_in <= '1';

		-- I MEM WRITE
		--reset            <= '0';
		--stall            <= '0';
		--flush            <= '0';
		--imem_addr_in     <= x"00000004";
		--imem_data_in     <= x"06957A13";
		--imem_write_en_in <= '1';

		wait for 20 ns;

		-- I MEM READ
		reset            <= '0';
		stall            <= '0';
		flush            <= '0';
		imem_addr_in     <= x"00000000";
		imem_write_en_in <= '0';
		imem_read_en_in  <= '1';

		wait;

		-- I MEM READ
		--reset            <= '0';
		--stall            <= '0';
		--flush            <= '0';
		--imem_addr_in     <= x"00000004";
		--imem_write_en_in <= '0';
		--imem_read_en_in  <= '1';

		--wait for clk_period;

		--wait;
	end process;

end;
