-- Flip Flop D
-- Output <Q> follows input <D> when <en> is asserted.
-- <rst> has the highest priority and sets <Q> to 0
-- <prst> has lower priority and sets <Q> to 1
-- <en> has lowest priority and sets <Q> to <D>
library IEEE;
use IEEE.std_logic_1164.all;

entity FlipFlopD is
	port (
		clk	: in std_logic;		-- Clcok signal
		en 	: in std_logic;		-- Enable
		rst	: in std_logic;		-- Synchronous reset
		prst: in std_logic;		-- Synchronous preset
		D	: in std_logic;		-- Data
		Q	: out std_logic		-- Output
	);
end entity FlipFlopD;

architecture RTL of FlipFlopD is
begin
	proc_ff: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				Q <= '0';
			elsif prst = '1' then
				Q <= '1';
			elsif en = '1' then
				Q <= D;
			end if;
		end if;
	end process proc_ff;
end architecture RTL;
