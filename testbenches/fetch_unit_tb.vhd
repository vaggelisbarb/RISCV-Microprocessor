library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

entity fetch_unit_tb is
end fetch_unit_tb;

architecture fetch_unit_beh of fetch_unit_tb is

	component fetch_unit
		port(
			clock          : in  STD_LOGIC;
			reset          : in  STD_LOGIC;
			flush          : in  STD_LOGIC;
			imem_request   : out STD_LOGIC;
			imem_next_addr : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			stall          : in  STD_LOGIC;
			branch         : in  STD_LOGIC;
			branch_target  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			PC_out         : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component fetch_unit;
	
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

	constant clk_period     : time := 10 ns;
	signal stall            : STD_LOGIC;
	signal reset            : STD_LOGIC;
	signal clock            : STD_LOGIC;
	
	-- Fetch unit signals
	signal flush : STD_LOGIC;
	signal imem_request     : STD_LOGIC;
	signal imem_next_addr   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal branch           : STD_LOGIC;
	signal branch_target    : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal PC_out           : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Instruction memory signals
	signal imem_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

	UUT : fetch_unit
		port map(
			clock            => clock,
			reset            => reset,
			flush => flush,
			imem_request     => imem_request,
			imem_next_addr   => imem_next_addr,
			stall            => stall,
			branch           => branch,
			branch_target    => branch_target,
			PC_out           => PC_out
		);
		
	UUT2 : instruction_memory
		port map(
			clock => clock,
			reset => reset,
			stall => stall,
			imem_request => imem_request,
			imem_address => imem_next_addr,
			imem_data_out => imem_data_out
		);

	
	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	fetching_process : process
	begin
		reset <= '1';
		wait for clk_period;
		
		imem_request <= '1';
		reset            <= '0';
		stall            <= '0';
		branch           <= '0';
		flush <= '0';

		wait for clk_period;
		
		branch <= '1';
		flush <= '1';
		branch_target <= X"0000000c";
		
		wait;


	end process;

end;
