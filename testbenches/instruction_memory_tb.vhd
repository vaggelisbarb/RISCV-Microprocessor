library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;

entity instruction_memory_tb is
end instruction_memory_tb;

architecture imem_beh of instruction_memory_tb is

	component instruction_memory
		port(
			clock         : in  STD_LOGIC;
			reset         : in  STD_LOGIC;
			stall         : in  STD_LOGIC;
			imem_request  : in  STD_LOGIC;
			imem_address  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			imem_data_out : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component instruction_memory;

	constant clk_period        : time := 10 ns;
	signal clock               : STD_LOGIC;
	signal reset               : STD_LOGIC;
	signal stall               : STD_LOGIC;
	signal instruction_addr_in : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_request : STD_LOGIC;
	signal mem_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

	UUT : instruction_memory
		port map(
			clock         => clock,
			reset         => reset,
			stall         => stall,
			imem_request => imem_request,
			imem_address  => instruction_addr_in,
			imem_data_out => mem_data_out
		);

	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	imem_proc : process
	begin

		-- I MEM READ
		reset               <= '0';
		stall               <= '0';
		imem_request		<= '0';
		instruction_addr_in <= ADDRESS_RESET;
		
		wait for clk_period;
		
		
		imem_request <= '1';
		instruction_addr_in <= std_logic_vector(unsigned(ADDRESS_RESET) + 4);
		
		wait for clk_period;

		instruction_addr_in <= std_logic_vector(unsigned(ADDRESS_RESET) + 8);
		

		wait for clk_period;
		
		instruction_addr_in <= std_logic_vector(unsigned(ADDRESS_RESET) + 12);
		
		wait ;
		

	end process;
end;
