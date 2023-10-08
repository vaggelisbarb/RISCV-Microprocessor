library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;

entity data_memory is
	port(
		clock         : in  STD_LOGIC;  -- clock signal
		reset         : in  STD_LOGIC;  -- reset signal
		stall         : in  STD_LOGIC;  -- stall signal
		dmem_data_in  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		dmem_addr_in  : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Address of the memory where the mem operation(mem_op_in) will be performed
		dmem_read_in  : in  STD_LOGIC;  -- Signal that indicates a read operation will be occured in memory. Only LOAD instructions enable this.
		dmem_write_in : in  STD_LOGIC;  -- c
		dmem_op_in    : in  MEM_op_type; -- The specific memory operaation will be exeuted based on the mem instruction
		dmem_op_out : out MEM_op_type;
		-- RD register if mem_read_in enabled
		rd_reg_in     : in  REG;        -- The destination register in which the data from memory will be written.
		rd_data_in    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
		rd_write_in   : in  STD_LOGIC;
		rd_write_out  : out STD_LOGIC;  -- Data to be stored at the memory address. Only in store terms
		rd_reg_out    : out REG;        -- The destination register in which the data from memory will be written.
		rd_data_out   : out STD_LOGIC_VECTOR(31 DOWNTO 0) -- Data that are fethed from memory
	);

end data_memory;

architecture dmem_behavior of data_memory is

	type DATA_MEMORY is array (0 to 255) of STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal D_MEM          : DATA_MEMORY := ((others => (others => '0')));
	signal mem_addr       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal data_word      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal data_half_word : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal data_byte      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal sign_half_word : STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal sign_byte      : STD_LOGIC_VECTOR(23 DOWNTO 0);

begin

	mem_addr  <= dmem_addr_in and (x"000000" & "00111111");
	data_word <= D_MEM(to_integer(unsigned(mem_addr) + 3)) & D_MEM(to_integer(unsigned(mem_addr) + 2)) & D_MEM(to_integer(unsigned(mem_addr) + 1)) & D_MEM(to_integer(unsigned(mem_addr)));

	data_half_word <= D_MEM(to_integer(unsigned(mem_addr) + 1)) & D_MEM(to_integer(unsigned(mem_addr)));
	data_byte      <= D_MEM(to_integer(unsigned(mem_addr)));
	sign_half_word <= x"0000" when data_half_word(15) = '0' else x"FFFF";
	sign_byte      <= x"000000" when data_byte(7) = '0' else x"FFFFFF";

	pip_reg : process(clock)
	begin
		if rising_edge(clock) then
			if reset = '1' then
				rd_write_out <= '0';
				dmem_op_out <= MEM_NONE;
			elsif stall = '0' then
				rd_write_out <= rd_write_in;
				rd_reg_out   <= rd_reg_in;
				dmem_op_out <= dmem_op_in;

				if dmem_write_in = '1' and dmem_read_in = '0' then
					case dmem_op_in is
						when MEM_STORE_WORD =>
							D_MEM(to_integer(unsigned(mem_addr)))     <= dmem_data_in(7 DOWNTO 0);
							D_MEM(to_integer(unsigned(mem_addr) + 1)) <= dmem_data_in(15 DOWNTO 8);
							D_MEM(to_integer(unsigned(mem_addr) + 2)) <= dmem_data_in(23 DOWNTO 16);
							D_MEM(to_integer(unsigned(mem_addr) + 3)) <= dmem_data_in(31 DOWNTO 24);
						when MEM_STORE_BYTE =>
							D_MEM(to_integer(unsigned(mem_addr))) <= dmem_data_in(7 DOWNTO 0);
						when MEM_STORE_HALF_WORD =>
							D_MEM(to_integer(unsigned(mem_addr)))     <= dmem_data_in(7 DOWNTO 0);
							D_MEM(to_integer(unsigned(mem_addr) + 1)) <= dmem_data_in(15 DOWNTO 8);
						when others =>
					end case;

				elsif dmem_write_in = '0' and dmem_read_in = '1' then
					case dmem_op_in is
						when MEM_LOAD_WORD =>
							rd_data_out <= data_word;
						when MEM_LOAD_BYTE =>
							rd_data_out <= sign_byte & data_byte;
						when MEM_LOAD_HALF_WORD =>
							rd_data_out <= sign_half_word & data_half_word;
						when MEM_LOAD_BYTE_UNSIGNED =>
							rd_data_out <= x"000000" & data_byte;
						when MEM_LOAD_HALF_UNSIGNED =>
							rd_data_out <= x"0000" & data_half_word;
						when others =>
					end case;
				else
					rd_data_out <= rd_data_in;
				end if;
			end if;
		end if;
	end process;

end dmem_behavior;
