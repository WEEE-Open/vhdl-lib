-- N bit up counter
-- cnt is incremented in every rising_edge of the clock in which <cen>
-- is sampled as '1'. When <pl> is asserted, count is set to <pin>.

-- If multiple commands are issued at the same time, this priority is followed:
-- 		Reset
--		Parallel load
--		Count
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter is
	generic (
		N : natural
	);
	port (
		clk:  in std_logic;					-- Clock
		cen:  in std_logic;					-- Count enable
		rst:  in std_logic;					-- Reset
		pl:   in std_logic;					-- Parallel load
		pin:  in unsigned(N-1 downto 0);	-- Parallel in
		cnt: out unsigned(N-1 downto 0)		-- Count
	);
end entity Counter;


architecture RTL of Counter is
	-- Internal register
	signal s_cnt: unsigned(N-1 downto 0);
begin
	proc_cnt: process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				s_cnt <= (others => '0');
			elsif pl = '1' then
				s_cnt <= pin;
			elsif cen = '1' then
				s_cnt <= s_cnt + '1';
			end if;
		end if;
	end process proc_cnt;
	cnt <= s_cnt;
end architecture RTL;
