

library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.NUMERIC_STD.all;

entity alu is 
  port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
       alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
       result:     buffer STD_LOGIC_VECTOR(31 downto 0);
       zero:       out STD_LOGIC);
end;

architecture behave of alu is
  signal condinvb, sum, s_slt: STD_LOGIC_VECTOR(31 downto 0);
  signal a_int, b_int, c_int, sum_int : integer;
begin
	with alucontrol(2) select
		condinvb <= not b when '1',
						b		when '0';
  
	a_int <= to_integer(unsigned(a));
	b_int <= to_integer(unsigned(condinvb));
	c_int <= to_integer(unsigned(alucontrol(2 downto 2)));
	
	sum_int <= a_int + b_int + c_int;
	
	sum <= std_logic_vector(to_unsigned(sum_int,32));
	
	s_slt <= std_logic_vector(to_unsigned(0,31)) & sum(31);
  
	with alucontrol(1 downto 0) select
		result <= 	a and b 	when "00",
						a or  b 	when "01",
						sum		when "10",
						s_slt		when others;

	with result select
		zero <= 	'1' when std_logic_vector(to_unsigned(0,32)),
					'0' when others;
end;
