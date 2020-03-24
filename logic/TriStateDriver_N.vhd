-- An N bit tri state driver
-- Output Y follows input A when output enable is asserted. Otherwise,
-- output is set to Z.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TriStateDriver is
	generic (
		N: natural				-- Number of bits
	);
	port (
		A: 	in std_logic;		-- Data
		oe: in std_logic;		-- Output enable
		Y: out std_logic		-- Output
	);
end entity TriStateDriver;

architecture Structural of TriStateDriver is
	Y <= A when oe = '1' else (others => 'Z');
end architecture Structural;
