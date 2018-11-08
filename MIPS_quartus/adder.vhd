 
library IEEE; use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all;

entity adder is -- adder
  port(a, b: in  STD_LOGIC_VECTOR(31 downto 0);
       y:    out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of adder is
	signal y_int, a_int, b_int : integer;
	
begin
	
	a_int <= to_integer(unsigned(a));
	b_int <= to_integer(unsigned(b));

	y_int <= a_int + b_int;
	
	y <= std_logic_vector(to_unsigned(y_int,32));
	
end;
