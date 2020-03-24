-- Comparator for signed N bit numbers
-- All the comparisons are done like in
-- 		operand(A, B)
-- EXAMPLE: the output 'ls' is asserted when
--		A < B
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ComparatorSigned is
	generic (
		N : natural
	);
	port (
		A: in signed(N-1 downto 0);		-- Input A
		B: in signed(N-1 downto 0);		-- Input B
		eq: out std_logic;				-- A = B
		lt: out std_logic;				-- A < B
		le: out std_logic;				-- A <= B
		gt: out std_logic;				-- A > B
		ge: out std_logic				-- A >= B
	);
end entity ComparatorSigned;

architecture Structure of ComparatorSigned is
	-- Signals for equal and less than
	signal s_eq, s_lt: std_logic;
begin
	proc_comp_eq: process(A, B)
	begin
		if A = B then
			s_eq <= '1';
		else
			s_eq <= '0';
		end if;
	end process proc_comp_eq;

	proc_comp_lt: process(A, B)
	begin
		if A < B then
			s_lt <= '1';
		else
			s_lt <= '0';
		end if;
	end process proc_comp_lt;

	-- Comparator logic
	eq <= s_eq;
	lt <= s_lt;
	le <= lt or eq;
	gt <= (not eq) and (not lt);
	ge <= not lt;
end architecture Structure;
