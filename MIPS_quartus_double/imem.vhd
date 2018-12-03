
library IEEE; 
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.all;  

entity imem is -- instruction memory
  port(a:  in  STD_LOGIC_VECTOR(5 downto 0);
       rd: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of imem is
	type arranjo_memoria is array(0 to 63) of std_logic_vector(31 downto 0);
	signal memoria : arranjo_memoria;
	attribute ram_init_file: string;
	attribute ram_init_file of memoria: signal is "instrucao_inicial.mif";
	
begin
  rd <= memoria(to_integer(unsigned(a)));
end;
