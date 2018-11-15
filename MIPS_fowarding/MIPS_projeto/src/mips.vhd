
library IEEE; use IEEE.STD_LOGIC_1164.all;

entity mips is -- single cycle MIPS processor
  port(clk, reset:        in  STD_LOGIC;
       pc:                out STD_LOGIC_VECTOR(31 downto 0);
       instr:             in  STD_LOGIC_VECTOR(31 downto 0);
       memwrite:          out STD_LOGIC;
       aluout, writedata: out STD_LOGIC_VECTOR(31 downto 0);
       readdata:          in  STD_LOGIC_VECTOR(31 downto 0));
end;

architecture struct of mips is
  component controller
    port(op, funct:          in  STD_LOGIC_VECTOR(5 downto 0);
         memtoreg, memwrite: out STD_LOGIC;
         branch, alusrc, c:   out STD_LOGIC;
         regdst, regwrite:   out STD_LOGIC;
         jump:               out STD_LOGIC;
         alucontrol:         out STD_LOGIC_VECTOR(2 downto 0));
  end component;   
  
  component datapath
	  port(	clk, reset : in std_logic; 
	  
	  		--imem
	  		pc		: buffer STD_LOGIC_VECTOR(31 downto 0);	
	       	instr	: in STD_LOGIC_VECTOR(31 downto 0);
			   
			--controler
			op, funct 			: out std_logic_vector(5 downto 0);
			memtoreg, memwrite	: in  STD_LOGIC;
	       	branch, alusrc, c	: in  STD_LOGIC;
	       	regdst, regwrite	: in  STD_LOGIC;
	       	jump				: in  STD_LOGIC;
	       	alucontrol			: in  STD_LOGIC_VECTOR(2 downto 0);
		   	
			--dmem
			memwritepip			: out std_logic;
	       	address, writedata	: buffer STD_LOGIC_VECTOR(31 downto 0);
	       	readdata			: in STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
  signal memtoreg, alusrc, regdst, regwrite, jump, branch, c, s_memwrite: STD_LOGIC;
  signal alucontrol: STD_LOGIC_VECTOR(2 downto 0);
  signal op, funct : std_logic_vector(5 downto 0);
begin
	
  	cont: controller 
	  	port map(	op, funct,
	  				memtoreg, s_memwrite, branch, alusrc, c,
	                regdst, regwrite, jump, alucontrol);
				
  	dp: datapath
		port map(	clk, reset,  
  
			  		--imem
			  		pc,
			       	instr,
					   
					--controler
					op, funct,
					memtoreg, s_memwrite,
			       	branch, alusrc, c,
			       	regdst, regwrite,
			       	jump,
			       	alucontrol,
				   	
					--dmem
					memwrite,
			       	aluout, writedata,
			       	readdata);
end;
