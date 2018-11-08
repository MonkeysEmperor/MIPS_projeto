 	
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
  port(op:                 in  STD_LOGIC_VECTOR(5 downto 0);
       memtoreg, memwrite: out STD_LOGIC;
       branch, alusrc:     out STD_LOGIC;
       regdst, regwrite:   out STD_LOGIC;
       jump:               out STD_LOGIC;
       aluop:              out STD_LOGIC_VECTOR(1 downto 0));
end;

architecture behave of maindec is
  signal controls: STD_LOGIC_VECTOR(8 downto 0);
begin
  
	with op select
		controls <= 	"110000010" when "000000", -- RTYPE
							"101001000" when "100011", -- LW
							"001010000" when "101011", -- SW
							"000100001" when "000100", -- BEQ
							"101000000" when "001000", -- ADDI
							"000000100" when "000010", -- J
							"000000000" when others; 	-- illegal op
							
	regwrite	<= controls(8);
	regdst	<= controls(7);
	alusrc	<= controls(6);
	branch	<= controls(5);
	memwrite	<= controls(4);
	memtoreg	<= controls(3);
	jump		<= controls(2);
	aluop		<= controls(1 downto 0);
end;
