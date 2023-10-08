library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.aux_categories.all;
USE work.constants.all;

ENTITY register_file_tb is
end register_file_tb;

ARCHITECTURE regfile_beh of register_file_tb is

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

	-- Input signals
	SIGNAL clock        : STD_LOGIC                     := '0';
	SIGNAL write_enable : STD_LOGIC                     := '0';
	SIGNAL rD_data_in   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL selA         : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
	SIGNAL selB         : STD_LOGIC_VECTOR(4 DOWNTO 0) ;
	SIGNAL selD         : STD_LOGIC_VECTOR(4 DOWNTO 0) ;

	-- Output signals
	SIGNAL dataA_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL dataB_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock setup
	CONSTANT clk_period : time    := 10 ns;
	signal reset        : STD_LOGIC;

BEGIN

	-- Unit Under Test (UUT)
	UUT : register_file
		PORT MAP(
			clock           => clock,
			reset           => reset,
			rd_write_enable => write_enable,
			rd_data         => rD_data_in,
			rs1_reg         => selA,
			rs2_reg         => selB,
			rd_reg          => selD,
			rs1_data        => dataA_out,
			rs2_data        => dataB_out
		);

	clock_process : PROCESS
	begin
		clock <= '0';
		wait for clk_period / 2;
		clock <= '1';
		wait for clk_period / 2;
	end PROCESS;

	main_process : PROCESS
	begin
		
		reset <= '0';
		-- writing test
		write_enable <= '1';
		selA         <= "00000";
		selB         <= "00001";
		selD         <= "00010";
		rD_data_in   <= x"0000002C";

		wait for clk_period;
		
		-- writing to register zero test
		selA         <= "00000";
		selB         <= "00001";
		selD         <= "00000";
		rD_data_in   <= x"0000002C";

		wait for clk_period;
		
		-- reading test
		write_enable <= '0';            
		selA         <= "00000";
		selB         <= "00010";
		
		wait;

	end PROCESS;
END;
