library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

entity execution_stage is
	port(
		-- Stage controls
		clock                        : in  STD_LOGIC; -- Clock signal
		reset                        : in  STD_LOGIC; -- Clear signal
		flush                        : in  STD_LOGIC; -- Signal to detect whether or not the input instruction must be flushed
		stall                        : in  STD_LOGIC; -- Signal that indicates that a stall ocurs
		-- Registers address & values
		rs1_reg_in, rs2_reg_in       : in  REG; -- The inputs register (1st operand and 2nd operand) if the source is ALU_SRC_REG
		rd_reg_in                    : in  REG; -- Destination register in which the result will be written
		rd_reg_out                   : out REG; -- Destination register in which the result will be written
		rs1_data_in, rs2_data_in     : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- The input registers' data
		rd_data_out                  : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- The data of the destination register
		-- Control signals
		rs1_source_in, rs2_source_in : in  ALU_source_operands; -- The source of the operands ( Registers, Immediate etc)
		alu_operation_in             : in  ALU_operation; -- The operation that will be executed on the ALU instance
		regWrite_in                  : in  STD_LOGIC;
		regWrite_out                 : out STD_LOGIC; -- Signal that indicates if the ALU result will be written to the destination register
		branch_in                    : in  BRANCH_type; -- Flag signal if a branch instruction is detected
		branch_out                   : out BRANCH_type; -- Flag signal if a branch instruction is detected
		-- Constant values
		immediate_in                 : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Immediate value (used when source is ALU_SRC_IMMEDIATE)
		-- Instruction
		pc_in                        : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Current executed instruction address
		pc_out                       : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- Current executed instruction address

		-- Memory control signals
		dmem_addr                    : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		dmem_data_out                : out STD_LOGIC_VECTOR(31 DOWNTO 0);
		dmem_op_in                   : in  MEM_op_type;
		dmem_op_out                  : out MEM_op_type;
		dmem_read_in                 : in  STD_LOGIC;
		dmem_read_out                : out STD_LOGIC;
		dmem_write_in                : in  STD_LOGIC;
		dmem_write_out               : out STD_LOGIC;
		-- Branch signals
		branch_taken                 : out STD_LOGIC; -- Signal that indicates if a jump must be made
		branch_target                : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- The target address. PC_next=PC+target when the jump_out signal is enabled
		branch_comparison_op : in BRANCH_comparison_type;
		branch_comparison_result : out STD_LOGIC;
		
		-- Forwarding MEM->EXE
		mem_rd_write_in              : in  STD_LOGIC; -- Signal which indicates that the value of rd from previous instruction must be forwarded from MEM to EXE stage
		mem_rd_reg_in                : in  REG; -- The rd register from previous instr
		mem_rd_data_in               : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- Value of rd register that will be forwarded

		-- Forwarding WB->EXE
		wb_rd_write_in               : in  STD_LOGIC; -- Signal which indicates that the value of rd from previous instruction must be forwarded from WB to EXE stage
		wb_rd_reg_in                 : in  REG; -- The rd register from previous instr
		wb_rd_data_in                : in  STD_LOGIC_VECTOR(31 DOWNTO 0) -- Value of rd register that will be forwarded

	);

end execution_stage;

architecture execution_behavior of execution_stage is

	signal pc : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- ALU signals
	signal alu_operation   : ALU_operation;
	signal alu_unit_result : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal branch          : BRANCH_type;
	signal jump_target     : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal branch_unit_result : STD_LOGIC;
	signal branch_comp_op : BRANCH_comparison_type;

	-- First ALU operand source and value
	signal rs1_alu_source      : ALU_source_operands;
	signal rs1_alu_value       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs1_forwarded_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs1_reg             : REG;

	-- Second ALU operand source and value
	signal rs2_alu_source      : ALU_source_operands;
	signal rs2_alu_value       : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs2_forwarded_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal rs2_reg             : REG;

	signal rs1_data, rs2_data : STD_LOGIC_VECTOR(31 DOWNTO 0);

	signal immediate : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

	pc_out <= pc;

	branch_out <= branch;
	
	branch_taken <= '1' when ((branch = BRANCH_JUMP or branch = BRANCH_JUMP_INDIRECT) or
						(branch = BRANCH_CONDITIONAL and branch_unit_result = '1'))
						else '0';
	branch_target <= jump_target;
	
	rs1_data    <= rs1_data_in;
	rs2_data    <= rs2_data_in;
	rd_data_out <= alu_unit_result;

	-- setting dmem signals

	dmem_data_out <= rs2_forwarded_value;
	dmem_addr     <= alu_unit_result;

	pip_reg : process(clock)
	begin
		if rising_edge(clock) then
			if reset = '1' or flush = '1' then
				branch        <= BRANCH_NONE;
				alu_operation <= ALU_NOP;
				dmem_op_out <= MEM_NONE;
				regWrite_out  <= '0';
				branch_comp_op <= NON_COMP;
			elsif stall = '0' then
				pc <= pc_in;

				-- registers
				rd_reg_out   <= rd_reg_in;
				rs1_reg      <= rs1_reg_in;
				rs2_reg      <= rs2_reg_in;
				regWrite_out <= regWrite_in;

				-- alu
				alu_operation  <= alu_operation_in;
				immediate      <= immediate_in;
				rs1_alu_source <= rs1_source_in;
				rs2_alu_source <= rs2_source_in;
				
				-- branch
				branch         <= branch_in;
				branch_comp_op <= branch_comparison_op;
				branch_comparison_result <= branch_unit_result;
				
				-- mem
				dmem_op_out    <= dmem_op_in;
				dmem_write_out <= dmem_write_in;
				dmem_read_out  <= dmem_read_in;

			end if;
		end if;
	end process;

	
	branch_target_calculation : process(branch, immediate, pc, rs1_forwarded_value)
	begin
		case branch is
			when BRANCH_NONE =>
			when BRANCH_JUMP =>
				jump_target <= std_logic_vector(unsigned(pc) + unsigned(immediate));
			when BRANCH_JUMP_INDIRECT =>
				-- e.g jalr 
				jump_target <= std_logic_vector(unsigned(rs1_forwarded_value) + unsigned(immediate));
			when BRANCH_CONDITIONAL =>
				jump_target <= std_logic_vector(unsigned(pc) + unsigned(immediate));
		end case;

	end process;

	forwarding_alu_rs1 : process(mem_rd_write_in, mem_rd_reg_in, rs1_reg, wb_rd_reg_in, wb_rd_data_in, mem_rd_data_in, rs1_data, wb_rd_write_in)
	begin
		if mem_rd_write_in = '1' and mem_rd_reg_in = rs1_reg then
			rs1_forwarded_value <= mem_rd_data_in;
		elsif wb_rd_write_in = '1' and wb_rd_reg_in = rs1_reg then
			rs1_forwarded_value <= wb_rd_data_in;
		else
			rs1_forwarded_value <= rs1_data;
		end if;
	end process;

	forwarding_alu_rs2 : process(mem_rd_write_in, mem_rd_reg_in, rs2_reg, wb_rd_reg_in, wb_rd_data_in, mem_rd_data_in, rs2_data, wb_rd_write_in)
	begin
		if mem_rd_write_in = '1' and mem_rd_reg_in = rs2_reg then
			rs2_forwarded_value <= mem_rd_data_in;
		elsif wb_rd_write_in = '1' and wb_rd_reg_in = rs2_reg then
			rs2_forwarded_value <= wb_rd_data_in;
		else
			rs2_forwarded_value <= rs2_data;
		end if;
	end process;

	alu_first_operand_mux : entity work.alu_mux
		port map(
			source       => rs1_alu_source,
			reg_value    => rs1_forwarded_value,
			imm_value    => immediate,
			pc_value     => pc,
			output_value => rs1_alu_value
		);

	alu_second_operand_mux : entity work.alu_mux
		port map(
			source       => rs2_alu_source,
			reg_value    => rs2_forwarded_value,
			imm_value    => immediate,
			pc_value     => pc,
			output_value => rs2_alu_value
		);

	alu : entity work.alu
		port map(
			reset         => reset,
			alu_operand1  => rs1_alu_value,
			alu_operand2  => rs2_alu_value,
			alu_operation => alu_operation,
			alu_result    => alu_unit_result
		);
		
	branch_unit : entity work.branch_unit
		port map(
			branch_comparison_op => branch_comp_op,
			rs1                  => rs1_forwarded_value,
			rs2                  => rs2_forwarded_value,
			comparison_result    => branch_unit_result
		);
	

end execution_behavior;
