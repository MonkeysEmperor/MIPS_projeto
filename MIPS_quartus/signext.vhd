
library IEEE; use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity signext is -- sign extender
  port(a: in  STD_LOGIC_VECTOR(15 downto 0);
       y: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of signext is
	signal s_pos, s_neg : std_logic_vector(15 downto 0);
begin
	s_pos <= std_logic_vector(to_unsigned(    0,16));
	s_neg <= std_logic_vector(to_unsigned(65535,16));
	
	with a(15) select
		y <= s_neg & a when '1', s_pos & a when '0';
end;