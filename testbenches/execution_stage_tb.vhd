library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

entity execution_stage_tb is
end execution_stage_tb;

architecture exe_beh of execution_stage_tb is

	component execution_stage
		port(
			clock                        : in  STD_LOGIC;
			reset                        : in  STD_LOGIC;
			flush                        : in  STD_LOGIC;
			stall                        : in  STD_LOGIC;
			rs1_reg_in, rs2_reg_in       : in  REG;
			rd_reg_in                    : in  REG;
			rd_reg_out                   : out REG;
			rs1_data_in, rs2_data_in     : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_data_out                  : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			rs1_source_in, rs2_source_in : in  ALU_source_operands;
			alu_operation_in             : in  ALU_operation;
			regWrite_out                 : out STD_LOGIC;
			branch_in                    : in  BRANCH_type;
			branch_out                   : out BRANCH_type;
			immediate_in                 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_in                        : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_out                       : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			stage_in                     : in  RV_STAGE;
			stage_out                    : out RV_STAGE;
			dmem_addr                    : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_data_out                : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_op_in                   : in  MEM_op_type;
			dmem_op_out                  : out MEM_op_type;
			dmem_read_in                 : in  STD_LOGIC;
			dmem_read_out                : out STD_LOGIC;
			dmem_write_in                : in  STD_LOGIC;
			dmem_write_out               : out STD_LOGIC;
			branch_taken                 : out STD_LOGIC;
			branch_target                : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			mem_rd_write_in              : in  STD_LOGIC;
			mem_rd_reg_in                : in  REG;
			mem_rd_data_in               : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			wb_rd_write_in               : in  STD_LOGIC;
			wb_rd_reg_in                 : in  REG;
			wb_rd_data_in                : in  STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component execution_stage;

	constant clk_period     : time := 10 ns;
	signal clock            : STD_LOGIC;
	signal reset            : STD_LOGIC;
	signal flush            : STD_LOGIC;
	signal stall            : STD_LOGIC;
	signal rs1_reg_in       : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rs2_reg_in       : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rd_reg_in        : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rs1_data_in      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs2_data_in      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs1_source_in    : ALU_source_operands;
	signal rs2_source_in    : ALU_source_operands;
	signal alu_operation_in : ALU_operation;
	signal regWrite_in      : STD_LOGIC;
	signal branch_in        : BRANCH_type;
	signal immediate_in     : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal pc_in            : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rd_reg_out       : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal rd_data_out      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal regWrite_out     : STD_LOGIC;
	signal branch_out       : BRANCH_type;
	signal pc_out           : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal jump_out         : STD_LOGIC;
	signal jump_target_out  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mem_rd_write_in  : std_logic;
	signal mem_rd_reg_in    : std_logic_vector(4 downto 0);
	signal mem_rd_data_in   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal wb_rd_write_in   : STD_LOGIC;
	signal wb_rd_reg_in     : STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal wb_rd_data_in    : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal stage_in         : RV_STAGE;
	signal stage_out        : RV_STAGE;
	signal dmem_addr        : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal dmem_data_out    : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal dmem_op_in       : MEM_op_type;
	signal dmem_op_out      : MEM_op_type;
	signal dmem_read_in     : STD_LOGIC;
	signal dmem_read_out    : STD_LOGIC;
	signal dmem_write_in    : STD_LOGIC;
	signal dmem_write_out   : STD_LOGIC;

begin

	UUT : execution_stage
		port map(
			clock            => clock,
			reset            => reset,
			flush            => flush,
			stall            => stall,
			rs1_reg_in       => rs1_reg_in,
			rs2_reg_in       => rs2_reg_in,
			rd_reg_in        => rd_reg_in,
			rd_reg_out       => rd_reg_out,
			rs1_data_in      => rs1_data_in,
			rs2_data_in      => rs2_data_in,
			rd_data_out      => rd_data_out,
			rs1_source_in    => rs1_source_in,
			rs2_source_in    => rs2_source_in,
			alu_operation_in => alu_operation_in,
			regWrite_out     => regWrite_out,
			branch_in        => branch_in,
			branch_out       => branch_out,
			immediate_in     => immediate_in,
			pc_in            => pc_in,
			pc_out           => pc_out,
			stage_in         => stage_in,
			stage_out        => stage_out,
			dmem_addr        => dmem_addr,
			dmem_data_out    => dmem_data_out,
			dmem_op_in       => dmem_op_in,
			dmem_op_out      => dmem_op_out,
			dmem_read_in     => dmem_read_in,
			dmem_read_out    => dmem_read_out,
			dmem_write_in    => dmem_write_in,
			dmem_write_out   => dmem_write_out,
			branch_taken     => jump_out,
			branch_target    => jump_target_out,
			mem_rd_write_in  => mem_rd_write_in,
			mem_rd_reg_in    => mem_rd_reg_in,
			mem_rd_data_in   => mem_rd_data_in,
			wb_rd_write_in   => wb_rd_write_in,
			wb_rd_reg_in     => wb_rd_reg_in,
			wb_rd_data_in    => wb_rd_data_in
		);

	clock_process : process
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end process;

	execution : process
	begin
		wait for 50 ns;

		reset <= '0';
		flush <= '0';
		stall <= '0';

		-- registers addr
		rs1_reg_in <= "00100";
		rs2_reg_in <= "01111";

		-- registers value
		rs1_data_in <= x"00000010";
		rs2_data_in <= x"00001101";

		-- registers source
		rs1_source_in <= ALU_SRC_REG;
		rs2_source_in <= ALU_SRC_IMM;

		-- forwarding signals
		mem_rd_write_in <= '0';
		mem_rd_reg_in   <= "00100";
		mem_rd_data_in  <= x"00000111";
		wb_rd_write_in  <= '0';

		rd_reg_in        <= "10000";
		alu_operation_in <= ALU_ADD;
		regWrite_in      <= '1';
		branch_in        <= BRANCH_NONE;
		immediate_in     <= x"000000A1";
		pc_in            <= x"000C0010";

		wait for clk_period;

	end process;
end;
