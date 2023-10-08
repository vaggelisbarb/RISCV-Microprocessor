library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

entity riscv_processor is

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

end riscv_processor;

architecture riscv_beh of riscv_processor is

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

	component data_memory
		port(
			clock         : in  STD_LOGIC;
			reset         : in  STD_LOGIC;
			stall         : in  STD_LOGIC;
			dmem_data_in  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_addr_in  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			dmem_read_in  : in  STD_LOGIC;
			dmem_write_in : in  STD_LOGIC;
			dmem_op_in    : in  MEM_op_type;
			dmem_op_out   : out MEM_op_type;
			rd_reg_in     : in  REG;
			rd_data_in    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			rd_write_in   : in  STD_LOGIC;
			rd_write_out  : out STD_LOGIC;
			rd_reg_out    : out REG;
			rd_data_out   : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component data_memory;

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

	component register_file
		port(
			clock           : in  STD_LOGIC;
			reset           : in  STD_LOGIC;
			rd_write_enable : in  STD_LOGIC;
			rd_data         : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			rs1_reg         : in  REG;
			rs2_reg         : in  REG;
			rd_reg          : in  REG;
			rs1_data        : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			rs2_data        : out STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component register_file;

	component decoder
		port(
			clock       : in  STD_LOGIC;
			reset       : in  STD_LOGIC;
			flush       : in  STD_LOGIC;
			stall       : in  STD_LOGIC;
			pc_in       : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			instruction : in  INSTRUCTION_LENGTH;
			pc_out      : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			rs1         : out REG;
			rs2         : out REG;
			rd          : out REG;
			opcode      : out OPCODE_SIZE;
			immediate   : out STD_LOGIC_VECTOR(31 DOWNTO 0);
			funct7      : out FUNCT7_SIZE;
			funct3      : out FUNCT3_SIZE
		);
	end component decoder;

	component control_unit
		port(
			opcode                         : in  OPCODE_SIZE;
			funct7                         : in  FUNCT7_SIZE;
			funct3                         : in  FUNCT3_SIZE;
			regWrite                       : out STD_LOGIC;
			branch                         : out BRANCH_type;
			alu_rs1_source, alu_rs2_source : out ALU_source_operands;
			alu_operation                  : out ALU_operation;
			branch_comp_op                 : out BRANCH_comparison_type;
			memRead                        : out STD_LOGIC;
			memWrite                       : out STD_LOGIC;
			mem_op_out                     : out MEM_op_type
		);
	end component control_unit;

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
			regWrite_in                  : in  STD_LOGIC;
			regWrite_out                 : out STD_LOGIC;
			branch_in                    : in  BRANCH_type;
			branch_out                   : out BRANCH_type;
			immediate_in                 : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_in                        : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			pc_out                       : out STD_LOGIC_VECTOR(31 DOWNTO 0);
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
			branch_comparison_op         : in  BRANCH_comparison_type;
			branch_comparison_result           : out STD_LOGIC;
			mem_rd_write_in              : in  STD_LOGIC;
			mem_rd_reg_in                : in  REG;
			mem_rd_data_in               : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
			wb_rd_write_in               : in  STD_LOGIC;
			wb_rd_reg_in                 : in  REG;
			wb_rd_data_in                : in  STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component execution_stage;

	component hazard_detection_unit
		port(
			dmem_op    : in  MEM_op_type;
			dmem_read  : in  STD_LOGIC;
			rs1_source : in  ALU_source_operands;
			rs2_source : in  ALU_source_operands;
			rs1        : in  REG;
			rs2        : in  REG;
			rd         : in  REG;
			hazard     : out STD_LOGIC
		);
	end component hazard_detection_unit;


	component writeback
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
	end component writeback;

	-- Instruction Memory signals
	signal imem_data      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_next_addr : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal imem_addr      : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Instruction Fetch (IF) Signals
	signal if_instruction_data : INSTRUCTION_LENGTH;
	signal if_flush            : STD_LOGIC;
	signal if_stall            : STD_LOGIC := '0';
	signal if_pc_out           : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal if_current_instr    : INSTRUCTION_LENGTH;
	signal if_imem_request     : STD_LOGIC;

	-- Instrucstion Decode signals
	signal id_flush       : STD_LOGIC;
	signal id_stall       : STD_LOGIC := '0';
	signal id_instr_in    : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal id_rs1         : REG;
	signal id_rs2         : REG;
	signal id_rd          : REG;
	signal id_opcode      : OPCODE_SIZE;
	signal id_funct7      : FUNCT7_SIZE;
	signal id_funct3      : FUNCT3_SIZE;
	signal id_immediate   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal id_pc_out      : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Control unit signals
	signal ctrl_rs1_source : ALU_source_operands;
	signal ctrl_rs2_source : ALU_source_operands;
	signal ctrl_alu_op     : ALU_operation;
	signal ctrl_branch     : BRANCH_type;
	signal ctrl_memRead    : STD_LOGIC;
	signal ctrl_memWrite   : STD_LOGIC;
	signal ctrl_mem_op     : MEM_op_type;
	signal ctrl_regWrite   : STD_LOGIC;
	signal ctrl_branch_comp_op : BRANCH_comparison_type;

	-- Execution stage (EXE) signals
	signal exe_flush         : STD_LOGIC;
	signal exe_stall         : STD_LOGIC := '0';
	signal exe_rd            : REG;
	signal exe_rd_data       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal exe_branch_taken  : STD_LOGIC;
	signal exe_branch_target : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal exe_branch        : BRANCH_type;
	signal exe_pc            : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal exe_rd_write_en   : STD_LOGIC;
	signal exe_mem_op        : MEM_op_type;
	signal exe_memRead       : STD_LOGIC;
	signal exe_memWrite      : STD_LOGIC;
	signal exe_dmem_addr     : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal exe_dmem_data_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal hazard : STD_LOGIC;

	-- Register file signals
	signal rs1_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs2_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs1_addr  : REG;
	signal rs2_addr  : REG;

	-- Memory stage (MEM) signals
	signal mem_rd_write_en : STD_LOGIC;
	signal mem_rd_reg      : REG;
	signal dmem_data       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal mem_op_out : MEM_op_type;

	signal mem_rd_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal wb_rd_write : STD_LOGIC;
	signal wb_rd_data  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal wb_rd       : REG;
	signal if_imem_next_addr : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal exe_branch_comp_result : STD_LOGIC;

begin

	if_stall <= '0';
	id_stall <= '0';
	exe_stall <= '0';
	

	if_flush  <= exe_branch_taken and not if_stall;
	id_flush  <= exe_branch_taken and not id_stall;
	exe_flush <= exe_branch_taken and not exe_stall;

	
	i_mem_inst : instruction_memory
		port map(
			clock         => clock,
			reset         => reset,
			stall         => stall,
			imem_request  => if_imem_request,
			imem_address  => if_imem_next_addr,
			imem_data_out => imem_data
		);

	fetch_inst : fetch_unit
		port map(
			clock            => clock,
			reset            => reset,
			flush            => if_flush,
			imem_request     => if_imem_request,
			imem_next_addr => if_imem_next_addr,
			stall            => if_stall,
			branch           => exe_branch_taken,
			branch_target    => exe_branch_target,
			PC_out           => if_pc_out
		);

	-- Fetched insruction is passed to ID stage
	id_instr_in <= imem_data;

	decode : decoder
		port map(
			clock           => clock,
			reset           => reset,
			flush           => id_flush,
			stall           => id_stall,
			pc_in           => if_pc_out,
			instruction     => id_instr_in,
			pc_out          => id_pc_out,
			rs1             => id_rs1,
			rs2             => id_rs2,
			rd              => id_rd,
			opcode          => id_opcode,
			immediate       => id_immediate,
			funct7          => id_funct7,
			funct3          => id_funct3
		);

	control_unit_inst : control_unit
		port map(
			opcode         => id_opcode,
			funct7         => id_funct7,
			funct3         => id_funct3,
			regWrite       => ctrl_regWrite,
			branch         => ctrl_branch,
			alu_rs1_source => ctrl_rs1_source,
			alu_rs2_source => ctrl_rs2_source,
			alu_operation  => ctrl_alu_op,
			branch_comp_op => ctrl_branch_comp_op,
			memRead        => ctrl_memRead,
			memWrite       => ctrl_memWrite,
			mem_op_out     => ctrl_mem_op
		);

	rs1_addr <= id_rs1 when stall = '0';
	rs2_addr <= id_rs2 when stall = '0';

	reg_file_inst : register_file
		port map(
			clock           => clock,
			reset           => reset,
			rd_write_enable => wb_rd_write,
			rd_data         => wb_rd_data,
			rs1_reg         => rs1_addr,
			rs2_reg         => rs2_addr,
			rd_reg          => wb_rd,
			rs1_data        => rs1_value,
			rs2_data        => rs2_value
		);
	
	exe_stage_unit : execution_stage
		port map(
			clock            => clock,
			reset            => reset,
			flush            => exe_flush,
			stall            => exe_stall,
			rs1_reg_in       => rs1_addr,
			rs2_reg_in       => rs2_addr,
			rd_reg_in        => id_rd,
			rd_reg_out       => exe_rd,
			rs1_data_in      => rs1_value,
			rs2_data_in      => rs2_value,
			rd_data_out      => exe_rd_data,
			rs1_source_in    => ctrl_rs1_source,
			rs2_source_in    => ctrl_rs2_source,
			alu_operation_in => ctrl_alu_op,
			regWrite_in      => ctrl_regWrite,
			regWrite_out     => exe_rd_write_en,
			branch_in        => ctrl_branch,
			branch_out       => exe_branch,
			immediate_in     => id_immediate,
			pc_in            => id_pc_out,
			pc_out           => exe_pc,
			dmem_addr        => exe_dmem_addr,
			dmem_data_out    => exe_dmem_data_out,
			dmem_op_in       => ctrl_mem_op,
			dmem_op_out      => exe_mem_op,
			dmem_read_in     => ctrl_memRead,
			dmem_read_out    => exe_memRead,
			dmem_write_in    => ctrl_memWrite,
			dmem_write_out   => exe_memWrite,
			branch_taken     => exe_branch_taken,
			branch_target    => exe_branch_target,
			branch_comparison_op => ctrl_branch_comp_op,
			branch_comparison_result => exe_branch_comp_result,
			mem_rd_write_in  => mem_rd_write_en,
			mem_rd_reg_in    => mem_rd_reg,
			mem_rd_data_in   => mem_rd_data,
			wb_rd_write_in   => wb_rd_write,
			wb_rd_reg_in     => wb_rd,
			wb_rd_data_in    => wb_rd_data
		);

	
	hazard_detection_unit_inst : hazard_detection_unit
		port map(
			dmem_op => exe_mem_op,
			dmem_read => exe_memRead,
			rs1_source => ctrl_rs1_source,
			rs2_source => ctrl_rs1_source,
			rs1 => id_rs1,
			rs2 => id_rs2,
			rd => exe_rd,
			hazard => hazard
		);
	

	dmem_inst : data_memory
		port map(
			clock         => clock,
			reset         => reset,
			stall         => stall,
			dmem_data_in  => exe_dmem_data_out,
			dmem_addr_in  => exe_dmem_addr,
			dmem_read_in  => exe_memRead,
			dmem_write_in => exe_memWrite,
			dmem_op_in    => exe_mem_op,
			dmem_op_out => mem_op_out,
			rd_reg_in     => exe_rd,
			rd_data_in    => exe_rd_data,
			rd_write_in   => exe_rd_write_en,
			rd_write_out  => mem_rd_write_en,
			rd_reg_out    => mem_rd_reg,
			rd_data_out   => mem_rd_data
		);

	writeback_stage : writeback
		port map(
			clock        => clock,
			reset        => reset,
			rd_reg_in    => mem_rd_reg,
			rd_write_in  => mem_rd_write_en,
			rd_data_in   => mem_rd_data,
			rd_reg_out   => wb_rd,
			rd_write_out => wb_rd_write,
			rd_data_out  => wb_rd_data
		);

end;
