library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity uartBrg is
  generic (
    DIVISOR: natural := 32000000/(16*9600) -- DIVISOR = 100,000,000 / (16 x BAUD_RATE)
    -- 2400 -> 2604
    -- 9600 -> 651
    -- 115200 -> 54
    -- 1562500 -> 4
    -- 2083333 -> 3
  );
  port (
    clk: in std_logic;                         -- clock
    reset: in std_logic;                      -- reset
	 outp : out std_logic
  );
end uartBrg;

architecture Behavioral of uartBrg is

  constant COUNTER_BITS : natural := integer(ceil(log2(real(DIVISOR))));
  signal sample: std_logic; -- 1 clk spike at 16x baud rate
  signal sample_counter: std_logic_vector(COUNTER_BITS-1 downto 0) := (others=> '0'); -- should fit values in 0..DIVISOR-1

begin

  -- sample signal at 16x baud rate, 1 CLK spikes
  sample_process: process (clk,reset) is
  begin
    if reset = '1' then
      sample_counter <= (others => '0');
      sample <= '0';
    elsif rising_edge(clk) then
      if sample_counter = DIVISOR-1 then
        sample <= '1';
        sample_counter <= (others => '0');
      else
        sample <= '0';
        sample_counter <= sample_counter + 1;
      end if;
    end if;
  end process;
  
  outp <= sample;

end Behavioral;