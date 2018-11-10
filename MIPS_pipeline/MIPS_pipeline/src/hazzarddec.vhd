
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;

entity hazarddec is
	port(	branch, branch_id, branch_ex		: in  std_logic;
			jump, memwrite, alusrc, wid, wex	: in  std_logic;
			r1, r2, rid, rex					: in  std_logic_vector(4 downto 0);
			enablepc, flushid 			: out std_logic);
end hazarddec;

architecture hazarddec_arc of hazarddec is
	signal s_r1, s_r2 : std_logic;			
	signal s_flush1 : std_logic;
	signal s_enable1, s_enable2 : std_logic;
	signal s_r1_rid, s_r1_rex, s_r2_rid, s_r2_rex, s_conflito : std_logic;
	signal s_r1_rid1, s_r1_rex1, s_r2_rid1, s_r2_rex1 : std_logic;
begin	
	--branch
	flushid   <= '1' when (branch_id or branch_ex) else s_flush1; -- esta em branch?
		 
	enablepc  <= '0' when (branch_id or branch) else s_enable1;
	s_enable1 <= '1' when branch_ex else s_enable2;	
		
	--conflito
	s_r1 <= not  jump;
	s_r2 <= not (jump or memwrite or alusrc);
	
	s_r1_rid1 <= '0' when r1 = "00000" else s_r1 and wid;
	s_r1_rex1 <= '0' when r1 = "00000" else s_r1 and wex;
	s_r2_rid1 <= '0' when r2 = "00000" else s_r2 and wid;
	s_r2_rex1 <= '0' when r2 = "00000" else s_r2 and wex;
		
	s_r1_rid <= s_r1_rid1 when r1 = rid else '0'; 
	s_r1_rex <= s_r1_rex1 when r1 = rex else '0'; 
	s_r2_rid <= s_r2_rid1 when r2 = rid else '0'; 
	s_r2_rex <= s_r2_rex1 when r2 = rex else '0'; 		   
		
	s_conflito <= s_r1_rid or s_r1_rex or s_r2_rid or s_r2_rex;
	s_flush1   <=     s_conflito;
	s_enable2  <= not s_conflito;
end hazarddec_arc;