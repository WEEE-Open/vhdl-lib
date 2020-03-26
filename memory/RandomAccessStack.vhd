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
	-- Memory structure
	type t_memory is array (0 to STACK_SIZE-1) of signed(WORD_SIZE-1 downto 0);
    signal mem: t_memory;
	-- Stack pointer
    signal sp: integer range 0 to mem_size-1;
begin
    proc_stack: process(clk, mem)
            variable newsp: integer;
        begin
            if rising_edge(clk) then
                if rst = '1' then
					-- Reset stack pointer
                    sp <= 0;
                elsif push = '1' then
					-- Store data in current address and increment sp
                    mem(sp) <= D;
                    newsp := sp + 1;
					-- Check for stack pointer overflow
                    if newsp = mem_size then
                        newsp := 0;
                    end if;
                    sp <= newsp;
                end if;
            end if;
        end process;

    proc_out: process(rd, addr, mem)
        begin
            if rd = '1' then
                Q <= mem(to_integer(addr));
            end if;
        end process;
end architecture;
