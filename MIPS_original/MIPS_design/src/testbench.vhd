
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all;

entity testbench is
	port(	clk, reset 				: in  std_logic;
			writedata, dataadr	: out STD_LOGIC_VECTOR(31 downto 0);
			certo						: out std_logic);
end;

architecture test of testbench is
  component top
    port(clk, reset:           in  STD_LOGIC;
         writedata, dataadr:   out STD_LOGIC_VECTOR(31 downto 0);
         memwrite:             out STD_LOGIC);
  end component;
  signal s_writedata, s_dataadr:    STD_LOGIC_VECTOR(31 downto 0);
  --signal clk, reset,  memwrite: STD_LOGIC;
  signal s_memwrite: STD_LOGIC;
begin

  -- instantiate device to be tested
  dut: top port map(clk, reset, s_writedata, s_dataadr, s_memwrite);
  
	writedata	<= s_writedata;
	dataadr 		<= s_dataadr;
  -- Generate clock with 10 ns period
  
  --process
  --begin
    --clk <= '1';
	 
--    wait for 5 ns; 
  --  clk <= '0';
	 
    --wait for 5 ns;
	 
  --end process;

  -- Generate reset for first two clock cycles
  --process begin
   -- reset <= '1';
    --wait for 22 ns;
    --reset <= '0';
    --wait;
  --end process;

  -- check that 7 gets written to address 84 at end of program
  process (clk) begin
    if (clk'event and clk = '0' and s_memwrite = '1') then
      if (to_integer(unsigned(s_dataadr)) = 84 and to_integer(unsigned(s_writedata)) = 7) then 
        certo <= '1';
      elsif (to_integer(unsigned(s_dataadr)) = 80) then 
		else
        certo <= '0';
      end if;
    end if;
  end process;
end;
