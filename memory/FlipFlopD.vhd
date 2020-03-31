-- Flip Flop D
-- Output <Q> follows input <D> when <en> is asserted.
-- You have to choose the correct architecture according to your
-- clock edge and reset needs.

-- Command priorities:
-- 		<rst> has the highest priority and sets <Q> to 0
-- 		<prst> has lower priority and sets <Q> to 1
-- 		<en> has lowest priority and sets <Q> to <D>
library IEEE;
use IEEE.std_logic_1164.all;

entity FlipFlopD is
	port (
		clk	: in std_logic;		-- Clcok signal
		en 	: in std_logic;		-- Enable
		rst	: in std_logic;		-- Reset
		prst: in std_logic;		-- Preset
		D	: in std_logic;		-- Data
		Q	: out std_logic		-- Output
	);
end entity FlipFlopD;

architecture RisingEdge of FlipFlopD is
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
end architecture RisingEdge;

architecture FallingEdge of FlipFlopD is
begin
	proc_ff: process(clk)
	begin
		if falling_edge(clk) then
			if rst = '1' then
				Q <= '0';
			elsif prst = '1' then
				Q <= '1';
			elsif en = '1' then
				Q <= D;
			end if;
		end if;
	end process proc_ff;
end architecture FallingEdge;

architecture AsynchRstRisingEdge of FlipFlopD is
begin
	proc_ff: process(clk, rst, prst)
	begin
		if rst = '1' then
			Q <= '0';
		elsif prst = '1' then
			Q <= '1';
		elsif rising_edge(clk) then
			if en = '1' then
				Q <= D;
			end if;
		end if;
	end process proc_ff;
end architecture AsynchRstRisingEdge;

architecture AsynchRstFallingEdge of FlipFlopD is
begin
	proc_ff: process(clk, rst, prst)
	begin
		if rst = '1' then
			Q <= '0';
		elsif prst = '1' then
			Q <= '1';
		elsif falling_edge(clk) then
			if en = '1' then
				Q <= D;
			end if;
		end if;
	end process proc_ff;
end architecture AsynchRstFallingEdge;
