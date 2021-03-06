
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;

entity fowardingdemuc is
	port(	r1id, r2id									: in  std_logic_vector(4 downto 0);
			jumpid, memwriteid, regwriteid, alusrcid	: in  std_logic;
			rwex, rwmem									: in  std_logic_vector(4 downto 0);
			regwriteex, memtoregex, regwritemem			: in  std_logic;
			stall, exr1, exr2, memr1, memr2 			: buffer std_logic);
end fowardingdemuc;

architecture fowardingdemuc_arc of fowardingdemuc is
	signal s_r1, s_r2 				: std_logic;					
	signal s_exr1, s_exr2, s_memr1, s_memr2 : std_logic;
begin
	s_r1 <= not  jumpid;
	s_r2 <= not (jumpid or (alusrcid and regwriteid)); 
										
	s_exr1  <= '1' when r1id = rwex  and r1id /= "00000" else '0';
	s_exr2  <= '1' when r2id = rwex  and r2id /= "00000" else '0'; 
	s_memr1 <= '1' when r1id = rwmem and r1id /= "00000" else '0';
	s_memr2 <= '1' when r2id = rwmem and r2id /= "00000" else '0';
		
	exr1  <= s_r1 and regwriteex  and s_exr1;
	exr2  <= s_r2 and regwriteex  and s_exr2;
	memr1 <= s_r1 and regwritemem and s_memr1;
	memr2 <= s_r2 and regwritemem and s_memr2;
	
	stall <= (exr1 or exr2) and memtoregex;
end fowardingdemuc_arc;