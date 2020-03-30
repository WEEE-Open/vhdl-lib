-- Unsigned Register

-- Reset has precedence over writing
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RegisterUnsigned is
	generic(
		N : natural
	);
	port (
		clk: in std_logic;				-- Clock
		rst: in std_logic;				-- Reset
		en : in std_logic;				-- Enable
		D  : in unsigned(N-1 downto 0);	-- Data input
		Q  : out unsigned(N-1 downto 0)	-- Data output
	);
end entity RegisterUnsigned;

architecture RTL of RegisterUnsigned is
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
