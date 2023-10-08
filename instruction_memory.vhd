library IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use work.constants.all;
use work.aux_categories.all;

entity instruction_memory is

	port(
		clock         : in  STD_LOGIC; -- Σήμα ρολογιού
		reset         : in  STD_LOGIC; -- Σήμα RESET
		stall         : in  STD_LOGIC; -- Σήμα καθυστέρησης
		imem_request  : in  STD_LOGIC; -- Σήμα που καθορίζει αν θα γίνει ανάγνωση από τη μνήμη εντολών
		imem_address  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);	-- Διεύθυνση στην οποία θα γίνει ανάγνωση του περιεχομένου
		imem_data_out : out STD_LOGIC_VECTOR(31 DOWNTO 0)	-- Το περιεχόμενο από τη παραπάνω διεύθυνση. Πρόκειται για την εντολή που θα δοθεί για εκτέλεση στον επεξεργαστή
	);

end instruction_memory;

architecture imem_behavior of instruction_memory is

	type INSTRUCTION_MEMORY is array (0 to 63) of STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal I_MEM : INSTRUCTION_MEMORY := (	
		"10010011",
		"00000000",
		"00010000",
		"00000000",
		
		"00010011",
		"00000001",
		"00110000",
		"00000000",
		
		"00100011",
		"00000000",
		"00010000",
		"00000000",
		
		"10100011",
		"00000000",
		"00100000",
		"00000000",
		
		"00000011",
		"00000001",
		"00000000",
		"00000000",
		
		"10000011",
		"00000000",
		"00010000",
		"00000000",
		
		"00010011",
		"00000001",
		"00010001",
		"00000000",
		
		"11100011",
		"10011110",
		"00100000",
		"11111110",
				
		"00010011",
		"00000000",
		"00000000",
		"00000000",
		
		"11100011",
		"00000000",
		"00000000",
		"11111110",
				
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		
		"00000000",
		"00000000",
		"00000000",
		"00000000",
			
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000",
		"00000000"
	);

begin

	imem_process : process(clock)
	begin
		if rising_edge(clock)then
			if reset = '0' and imem_request = '1' and stall = '0' then
				imem_data_out <= I_MEM(to_integer(unsigned(imem_address) + 3)) & I_MEM(to_integer(unsigned(imem_address) + 2)) & I_MEM(to_integer(unsigned(imem_address) + 1)) & I_MEM(to_integer(unsigned(imem_address)));
			elsif stall = '1' then
				imem_data_out <= NOP;
			elsif imem_request <= '0' or reset = '1' then
				imem_data_out <= ADDRESS_RESET;
			
			end if;
		end if;
	end process;

end imem_behavior;
