-- FIFO memory
-- When <push> is asserted, data is stored inside the structure.
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIFO is
    generic(
        WORD_SIZE : natural;
        FIFO_SIZE : natural
    );
    port(
        clk		: in std_logic;							-- Clock
        rst     : in std_logic;							-- Reset
        D       : in signed(WORD_SIZE-1 downto 0);		-- Data input
        push    : in std_logic;							-- Push
        pop     : in std_logic;							-- Pop
        Q       : out signed(WORD_SIZE-1 downto 0);		-- Data output
        empty   : out std_logic							-- Memory empty signal
    );
end entity FIFO;


architecture Behavior of FIFO is
    subtype t_word is signed(WORD_SIZE-1 downto 0);
    type    t_fifo is array(0 to FIFO_SIZE-1) of t_word;

	-- Data pointers
	signal i_ptr, o_ptr : integer range 0 to FIFO_SIZE-1;
	-- Memory signal
    signal memory : t_fifo;
begin
    proc_mem: process(clk)
	variable newi, newo: integer;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                i_ptr <= 0;
                o_ptr <= 0;
            else
                if push = '1' then
                    memory(i_ptr) <= D;
                    newi := i_ptr+1;
                    if newi < mem_size then
                        i_ptr <= newi;
                    else
                        i_ptr <= 0;
                    end if;
                end if;

                if pop = '1' then
                    newo := o_ptr+1;
                    if newo < mem_size then
                        o_ptr <= newo;
                    else
                        o_ptr <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process;

    proc_fifo_empty: process(i_ptr, o_ptr)
    begin
        if i_ptr = o_ptr then
            empty <= '1';
        else
            empty <= '0';
        end if;
    end process;
    Q <= memory(o_ptr);
end architecture Behavior;
