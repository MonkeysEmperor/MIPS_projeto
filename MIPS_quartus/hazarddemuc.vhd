
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;

entity hazarddemuc is
	port(	jump, pcsrc, stall, alertmem	: in  std_logic; 
			branchex, previewex				: in  std_logic; 
			enablepc, enableif, enableid	: out std_logic;
			flushif, flushid, flushex		: out std_logic;
			recover							: buffer std_logic);
end	hazarddemuc;

architecture hazarddemuc_arc of hazarddemuc is
begin
	enablepc <= not stall;
	enableif <= not stall;
	enableid <= not stall;
	
	--recover <= (branchex and (previewex xor pcsrc)) or (alertmem and ((branchex and pcsrc)));
	recover <= (branchex and (previewex xor pcsrc));
	
	--flushif <= jump or recover or (alertmem and (jumpex or (branchex and pcsrc))); 
	flushif <= jump or recover;
	flushid <= recover;
	flushex <= (branchex and pcsrc) or stall;
end hazarddemuc_arc;