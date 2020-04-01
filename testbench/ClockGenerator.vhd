-- !! NOT SYNTHESIZABLE !!
-- Generates clock output according to the requested frequency

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.math_real.all;

entity ClockGenerator is
	generic (
		f : real
	);
	port (
		clk: out std_logic
	);
end entity ClockGenerator;

architecture Behavior of ClockGenerator is
	-- Period in nanoseconds
	constant T_ns : real := 1.0e9 / f;
begin
	proc_clk: process
	begin
		clk <= '0';
		wait for T_ns/2.0 * 1.0 ns;
		clk <= '1';
		wait for T_ns/2.0 * 1.0 ns;
	end process;
end architecture Behavior;
