-- Stack with asynchronous random access

-- When <push> is asserted, data is stored and the internal stack pointer is
-- incremented.
-- Output is asynchronous and latched, so <rd> must be asserted when reading.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RandomAccessStack is
    generic (
        WORD_SIZE: natural;
        STACK_SIZE: natural;
        ADDR_SIZE: natural
    );
    port (
        clk : in std_logic;							-- Clock
        rst : in std_logic;							-- Reset
        push: in std_logic;							-- Push
        D 	: in signed(WORD_SIZE-1 downto 0);		-- Data input
        addr: in unsigned(ADDR_SIZE-1 downto 0);	-- Asynch output address
        rd 	: in std_logic;							-- Read enable
        Q 	: out signed(WORD_SIZE-1 downto 0)		-- Data output
    );
end entity RandomAccessStack;

architecture RTL of RandomAccessStack is
	component Counter is
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
	end component;

	-- Memory structure
	type t_memory is array (0 to STACK_SIZE-1) of signed(WORD_SIZE-1 downto 0);
    signal mem: t_memory;
	-- Stack pointer
    signal sp: unsigned(ADDR_SIZE-1 downto 0)

begin
	-- Stack pointer is just a counter incremented at every <push>
	comp_sp_counter: Counter
		generic map (ADDR_SIZE)
		port map (clk, push, rst, '0', (others => 0), sp);

	-- Input process (synchronous)
    proc_in: process(clk)
		begin
			if rising_edge(clk) then
				if push = '1' then
					mem(to_integer(sp)) <= D;
				end if;
			end if;
		end process proc_in;

	-- Output process (combinatorial)
    proc_out: process(rd, addr, mem)
        begin
            if rd = '1' then
                Q <= mem(to_integer(addr));
            end if;
        end process;
end architecture;
