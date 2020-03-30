-- Signed Register

-- Reset has precedence over writing
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegisterSigned is
	generic(
		N : natural
	);
	port (
		clk: in std_logic;				-- Clock
		rst: in std_logic;				-- Reset
		en : in std_logic;				-- Enable
		D  : in signed(N-1 downto 0);	-- Data input
		Q  : out signed(N-1 downto 0)	-- Data output
	);
end entity RegisterSigned;

architecture RTL of RegisterSigned is
begin
	proc_reg: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				Q <= (others => '0');
			elsif en = '1' then
				Q <= D;
			end if;
		end if;
	end process proc_reg;
end architecture RTL;
