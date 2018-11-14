
library IEEE; use IEEE.STD_LOGIC_1164.all;

entity signext is -- sign extender
  port(a: in  STD_LOGIC_VECTOR(15 downto 0);
  	   c: in  STD_LOGIC; -- c = '0' arit, c = '1' logical
       y: out STD_LOGIC_VECTOR(31 downto 0));
end;

architecture behave of signext is 
	signal s_0, s_1, s_temp : STD_LOGIC_VECTOR(31 downto 0);
begin  
	s_0 <= X"0000" & a;
	s_1 <= X"ffff" & a;	
	
	with a(15) select
		s_temp 	<= s_1 		when '1', 
						s_0 		when '0';
	
	with c select
		y 			<= s_0 		when '1',
						s_temp	when '0';
end;