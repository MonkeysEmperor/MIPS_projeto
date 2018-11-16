
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;

entity datapath is  -- MIPS datapath
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
       	address, writedata	: out STD_LOGIC_VECTOR(31 downto 0);
       	readdata			: in STD_LOGIC_VECTOR(31 downto 0));
end;

architecture struct of datapath is
  component alu
    port(a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
         alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
         result:     buffer STD_LOGIC_VECTOR(31 downto 0);
         zero:       out STD_LOGIC);
  end component;  
  
  component regfile
    port(clk:           in  STD_LOGIC;
         we3:           in  STD_LOGIC;
         ra1, ra2, wa3: in  STD_LOGIC_VECTOR(4 downto 0);
         wd3:           in  STD_LOGIC_VECTOR(31 downto 0);
         rd1, rd2:      out STD_LOGIC_VECTOR(31 downto 0));
  end component;  
  
  component adder
    port(a, b: in  STD_LOGIC_VECTOR(31 downto 0);
         y:    out STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
  component sl2
    port(a: in  STD_LOGIC_VECTOR(31 downto 0);
         y: out STD_LOGIC_VECTOR(31 downto 0));
  end component;
  
  component signext													 
	  port(a: in  STD_LOGIC_VECTOR(15 downto 0);
	  	   c: in  STD_LOGIC; -- c = '0' arit, c = '1' logical
	       y: out STD_LOGIC_VECTOR(31 downto 0));
  end component; 
  
  component mux2 generic(width: integer);
    port(d0, d1: in  STD_LOGIC_VECTOR(width-1 downto 0);
         s:      in  STD_LOGIC;
         y:      out STD_LOGIC_VECTOR(width-1 downto 0));
  end component;
  
	component registrador_n is
		generic(constant N: integer := 8);
		port(	clock, clear, enable: in STD_LOGIC;
				D: in STD_LOGIC_VECTOR(N-1 downto 0);
				Q: out STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	component registrador_1 is				 
		port(	clock, clear, enable: in STD_LOGIC;
				D: in STD_LOGIC;
				Q: out STD_LOGIC);
	end component;
	
	component fowardingdemuc is
		port(	r1id, r2id									: in std_logic_vector(4 downto 0);
				jumpid, memwriteid, regwriteid, alusrcid	: in std_logic;
				rwex, rwmem									: in std_logic_vector(4 downto 0);
				regwriteex, memtoregex, regwritemem			: in std_logic;
				stall, exr1, exr2, memr1, memr2 			: buffer std_logic);
	end component;	
	
	component hazarddemuc is
		port(	jump, pcsrc, stall				: in  std_logic; 
				branchex, previewex				: in  std_logic; 
				enablepc, enableif, enableid	: out std_logic;
				flushif, flushid, flushex		: out std_logic;
				recover							: buffer std_logic);
	end	component;
  	
	signal zero 				: std_logic;
	signal writereg				: STD_LOGIC_VECTOR( 4 downto 0);
	signal signimm, signimmsh	: STD_LOGIC_VECTOR(31 downto 0);
	signal content1, content2	: STD_LOGIC_VECTOR(31 downto 0);
	signal srca, srcb			: STD_LOGIC_VECTOR(31 downto 0);
	signal wd, aluout			: STD_LOGIC_VECTOR(31 downto 0);
	
	--PC
	signal preview, recover, pcsrc							: std_logic;
	signal pcplus4, pcbranch, pcjump, pcrecover, pcrecover2	: STD_LOGIC_VECTOR(31 downto 0); 
	signal pc_aux1, pc_aux2, pcnext 						: STD_LOGIC_VECTOR(31 downto 0);  
	
	--pipeline
	signal s_if  : std_logic_vector( 63 downto 0);
	signal s_id  : std_logic_vector(153 downto 0);
	signal s_ex  : std_logic_vector(107 downto 0);
	signal s_mem : std_logic_vector( 70 downto 0); 
	
	--hazard 
	signal enablepc, enableif, enableid	: std_logic; 
	signal flushif, flushid, flushex	: std_logic;
	
	--flush
	constant c_flushif : std_logic_vector( 5 downto 0) := "111111";
	constant c_flushid : std_logic_vector(20 downto 0) := "0" & X"00000";
	constant c_flushex : std_logic_vector( 5 downto 0) :=  "000000";
	
	signal s_flushif : std_logic_vector( 5 downto 0);				  
	signal s_flushid : std_logic_vector(20 downto 0);				  
	signal s_flushex : std_logic_vector( 5 downto 0);
	
	--fowarding
	signal stall, s_ex_r1, s_ex_r2, s_mem_r1, s_mem_r2 	: std_logic;
	signal s_a, s_b1, s_b2								: std_logic_vector(31 downto 0);
begin
	
  	pcadd1: adder 
	  port map(pc, X"00000004", pcplus4);
	  
	pcmux1 : mux2
		generic map(32)
		port map(pcplus4, pcbranch, branch and preview, pc_aux1);
		
	pcmux2 : mux2
		generic map(32)
		port map(pc_aux1, pcjump, jump, pc_aux2);
		
	pcmux3 : mux2
		generic map(32)
		port map(pc_aux2, s_ex(101 downto 70), recover, pcnext);
	
	pcreg: registrador_n 
		generic map(32) 
		port map(clk, reset, enablepc, pcnext, pc);
	
	--flush if
	flushifmux : mux2
		generic map(6)
		port map(instr(31 downto 26), c_flushif, flushif, s_flushif);
	
	-----------------------------------------------------
	-- pcplus4 (63 downto 32) | instr (31 downto 0);
	
	IF_reg : registrador_n
		generic map(64)
		port map(	clk, reset,	enableif,
					pcplus4 & s_flushif & instr(25 downto 0),
					s_if);	
	-----------------------------------------------------
	
	op 		<= s_if(31 downto 26);
	funct 	<= s_if( 5 downto  0);
  	
	--reg
	rf: regfile 
	port map(	clk, s_mem(69), 
				s_if(25 downto 21), s_if(20 downto 16), s_mem(4 downto 0), 
				wd, content1, content2);				 					  
	
	--jump
 	pcjump <= pcplus4(31 downto 28) & s_if(25 downto 0) & "00";	
		  
  
	--wr
	wrmux: mux2 
		generic map(5) 
		port map(	s_if(20 downto 16), 
	                s_if(15 downto 11), 
	                regdst, writereg);
	
	--imediate
  	se: signext port map(s_if(15 downto 0),c, signimm);
	
	--branch
	previewreg : registrador_1
		port map(	clk, reset, s_ex(106), 											
					pcsrc, preview);
		
	immsh: sl2 
		port map(signimm, signimmsh);
	
  	pcadd2: adder 
	  	port map(s_if(63 downto 32), signimmsh, pcbranch);
	
	pcrecovermux : mux2
		generic map(32)
		port map(pcbranch, s_if(63 downto 32), preview, pcrecover);
		
	--flush id
	flushidmux : mux2
		generic map(21)
		port map(jump & alusrc & alucontrol & s_if(26) &branch & preview & memwrite & memtoreg & regwrite & s_if(25 downto 16), c_flushid, flushid, s_flushid);
	
	-----------------------------------------------------
	-- jump (153) | alusrc (152) | alucontrol (151 downto 149) || 
	-- op0 (148) | branch (147) | preview (146) | memwrite (145) || writesrc (144) | regwrite (143)
	-- pcrecover (142 downto 111) | R1 (110 downto 106) | R2 (105 downto 101) | content1 (100 downto 69) | content2 (68 downto 37)
	-- imediate (36 downto 5) | wr (4 downto 0)
	
	ID_reg : registrador_n
		generic map(154)
		port map(	clk, reset,	enableid,
					s_flushid(20 downto 10) & pcrecover &
					s_flushid( 9 downto  0) & content1 & content2 & signimm & writereg,
					s_id);	
	-----------------------------------------------------
	
	pcrecoveradder : adder
		port map(s_id(142 downto 111), X"0000000" & '0' & s_id(146) & "00", pcrecover2);
	
	--flowarding
	afowaerdingmux1 : mux2
		generic map(32)
	   	port map(s_id(100 downto 69), wd, s_mem_r1, s_a);
	
	aforwardingmux2 : mux2
		generic map(32)
		port map(s_a, s_ex(68 downto 37), s_ex_r1, srca);
	  
	bfowaerdingmux1 : mux2
		generic map(32)
	   	port map(s_id(68 downto 37), wd, s_mem_r2, s_b1);
	
	bforwardingmux2 : mux2
		generic map(32)
		port map(s_b1, s_ex(68 downto 37), s_ex_r2, s_b2);	
		
	--ALU
	srcbmux: mux2 
		generic map(32) 
		port map(s_b2, s_id(36 downto 5), s_id(152), srcb);	 
		
	mainalu: alu 
		port map(srca, srcb, s_id(151 downto 149), aluout, zero);
	
	--flush ex
	flushexmux : mux2
		generic map(6)
		port map(s_id(148 downto 143), c_flushex, flushex, s_flushex);
	
	-----------------------------------------------------
	-- op0 (107) | branch (106) | preview (105) | memwrite (104) || writesrc (103) | regwrite (102)
	-- pcrecover (101 downto 70) | zero (69) | aluout (68 downto 37) | content2 (36 downto 5) | wr (4 downto 0)
	
	EX_reg : registrador_n
		generic map(108)
		port map(	clk, reset,	'1',
					s_flushex & pcrecover2 & zero & aluout & s_b2 & s_id(4 downto 0),
					s_ex);
	-----------------------------------------------------
	 
	memwritepip	<= s_ex(104);
	address		<= s_ex(68 downto 37);
	writedata	<= s_ex(36 downto  5);
	pcsrc		<= s_ex(106) and (s_ex(69) xor s_ex(107));
	
	-----------------------------------------------------
	-- writesrc (70) | regwrite (69)
	-- readdata (68 downto 37) | aluout (36 downto 5) | wr (4 downto 0)
	
	MEM_reg : registrador_n
		generic map(71)
		port map(	clk, reset,	'1',
					s_ex(103 downto 102) & readdata & s_ex(68 downto 37) & s_ex (4 downto 0),
					s_mem);
	-----------------------------------------------------
	
	resmux: mux2 
		generic map(32) 
		port map(s_mem(36 downto 5), s_mem(68 downto 37), s_mem(70), wd);
					  
	-----------------------------------------------------
	--Fowarding
	FWD : fowardingdemuc 
		port map(	s_id(110 downto 106), s_id(105 downto 101),
					s_id(153), s_id(145), s_id(143), s_id(152),
					s_ex(4 downto 0), s_mem(4 downto 0),
					s_ex(102), s_ex(103), s_mem(69),
					stall, s_ex_r1, s_ex_r2, s_mem_r1, s_mem_r2);				  
	-----------------------------------------------------
	--Hazzard													 
	
	HAZ : hazarddemuc
	port map(	jump, pcsrc, stall, 
				s_ex(106), s_ex(105),
				enablepc, enableif, enableid,
				flushif, flushid, flushex,
				recover);
end struct;
  