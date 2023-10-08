library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

use work.constants.all;
use work.aux_categories.all;

-- Instruction fetching unit.
-- Responsible to fetch the instruction from current pc to the CPU
-- and set the next PC address
entity fetch_unit is
	port(
		clock            : in  STD_LOGIC; -- Σήμα ρολογιού
		reset            : in  STD_LOGIC; -- Σήμα RESET
		flush            : in  STD_LOGIC; -- Σήμα που υποδεικνύει αν πρέπει 
		-- Connection with I-MEM
		imem_request     : out STD_LOGIC; -- Σήμα που καθορίζει αν θα γίνει αίτηση στην μνήμη εντολών
		imem_next_addr : out STD_LOGIC_VECTOR(31 DOWNTO 0); -- Η επόμενη διεύθυνση για ανάγνωση από τη μνήμη εντολών. Πρόκειται για την διεύθυνση της επόμενης εντολής (PC NEXT)
		
		-- Fetch unit control signals
		stall            : in  STD_LOGIC; -- Σήμα για καθυστέρηση της μονάδας προσκόμισης. Δεν θα προσκομιστεί επόμενη εντολή αν το σήμα είναι 0.
		branch           : in  STD_LOGIC; -- Flag is enabled if a branch instruction is appeared in later stage of CPU. Setting next PC qual to the branch target
		branch_target    : in  STD_LOGIC_VECTOR(31 DOWNTO 0); -- New address of the instruction to be fetched if the branch flag is enabled
		-- Connection with Decoder
		PC_out           : out STD_LOGIC_VECTOR(31 DOWNTO 0) -- Address of the instruction that it will be passed to decoder
	);

end fetch_unit;

architecture fetch_unit_behavior of fetch_unit is
	
	signal PC_STATE : PC_STATE := PC_RESET;
	signal PC   : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal PC_NEXT : STD_LOGIC_VECTOR(31 DOWNTO 0);
begin

	imem_next_addr <= PC_NEXT;
	imem_request <= not reset;
	PC_out <= PC;
	
		
	set_pc : process(clock)
	begin
		if rising_edge(clock) then
			if reset = '1' then
				PC_STATE <= PC_RESET;
				PC <= PC_NEXT;
			elsif reset = '0' then
				if flush = '1' and branch = '1' then
					PC_STATE <= PC_BRANCH;
					PC <= PC_NEXT;
				elsif stall = '1' then
					PC_STATE <= PC_HALT;
					PC <= PC_NEXT;
				else
					PC_STATE <= PC_INCREMENT;
					PC <= PC_NEXT;
				end if;
			end if;
		end if;
	end process;

	set_next_pc : process(PC_STATE, PC, branch_target)
	begin
		case PC_STATE is
			when PC_NOP =>
				PC_NEXT <= NOP;
			when PC_RESET =>
				PC_NEXT   <= ADDRESS_RESET;
			when PC_INCREMENT =>
				PC_NEXT <= std_logic_vector(unsigned(PC) + 4);
			when PC_BRANCH =>
				PC_NEXT <= branch_target; 
			when PC_HALT =>
				PC_NEXT <= PC;
		end case;
	end process;
	

end fetch_unit_behavior;
