
library IEEE; use IEEE.STD_LOGIC_1164.all;

entity aludec is -- ALU control decoder
  port(funct:      in  STD_LOGIC_VECTOR(5 downto 0);
       aluop:      in  STD_LOGIC_VECTOR(1 downto 0);
       alucontrol: out STD_LOGIC_VECTOR(2 downto 0));
end;

architecture behave of aludec is
	signal s_alucontrol : std_logic_vector(2 downto 0);
	
begin 
 
	with funct select
		s_alucontrol <= 	"010" when "100000", -- add 
								"110" when "100010", -- sub
								"000" when "100100", -- and
								"001" when "100101", -- or
								"111" when "101010", -- slt
								"011" when others; 	-- ???
	
	with aluop select
      alucontrol <= 	"010" 			when "00", 		-- add (for lw/sw/addi)
							"110" 			when "01", 		-- sub (for beq)
							s_alucontrol	when others;	-- R-type instructions
							
end;
