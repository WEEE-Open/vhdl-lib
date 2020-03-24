-- A tri-state driver
-- Output Y follows A when oe is asserted. Otherwise, Y is set
-- to Z
library IEEE;
use IEEE.std_logic_1164.all;

entity TriStateDriver is
	port (
		A: 	in std_logic;		-- Data
		oe: in std_logic;		-- Output enable
		Y: out std_logic		-- Output
	);
end entity TriStateDriver;

architecture Structural of TriStateDriver is
	Y <= A when oe = '1' else 'Z';
end architecture Structural;
