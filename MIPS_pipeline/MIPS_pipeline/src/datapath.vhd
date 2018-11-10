
library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_ARITH.all;

entity datapath is  -- MIPS datapath
	port(	clk, reset, c:     in  STD_LOGIC;
			memtoreg, branch:  in  STD_LOGIC;
			alusrc, regdst:    in  STD_LOGIC;
			regwrite, jump:    in  STD_LOGIC;
		 	memwrite:		   in  std_logic;
			memwritepip:	   out std_logic;
			alucontrol:        in  STD_LOGIC_VECTOR(2 downto 0);
			pc:                buffer STD_LOGIC_VECTOR(31 downto 0);
			instr:             in  STD_LOGIC_VECTOR(31 downto 0);
			aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0);
			readdata:          in  STD_LOGIC_VECTOR(31 downto 0);
			op, funct:         out std_logic_vector(5 downto 0));
			
end;

architecture struct of datapath is
	component alu
		port(	a, b:       in  STD_LOGIC_VECTOR(31 downto 0);
				alucontrol: in  STD_LOGIC_VECTOR(2 downto 0);
				result:     buffer STD_LOGIC_VECTOR(31 downto 0);
				zero:       out STD_LOGIC);
	end component;  
	
	component regfile
		port(	clk:           in  STD_LOGIC;
				we3:           in  STD_LOGIC;
				ra1, ra2, wa3: in  STD_LOGIC_VECTOR(4 downto 0);
				wd3:           in  STD_LOGIC_VECTOR(31 downto 0);
				rd1, rd2:      out STD_LOGIC_VECTOR(31 downto 0));
	end component;  
	
	component adder
		port(	a, b: in  STD_LOGIC_VECTOR(31 downto 0);
				y:    out STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	component sl2
		port(	a: in  STD_LOGIC_VECTOR(31 downto 0);
	 			y: out STD_LOGIC_VECTOR(31 downto 0));
	end component; 
	
	component signext													 
		port(	a: in  STD_LOGIC_VECTOR(15 downto 0);
	   			c: in  STD_LOGIC; -- c = '0' arit, c = '1' logical
	   			y: out STD_LOGIC_VECTOR(31 downto 0));
	end component;	
  	 
	component mux2 
		generic(width: integer);
		port(	d0, d1: in  STD_LOGIC_VECTOR(width-1 downto 0);
				s:      in  STD_LOGIC;
	         	y:      out STD_LOGIC_VECTOR(width-1 downto 0));
	end component; 
  
	component registrador_n is 
		generic(constant N: integer := 8);
	 	port(	clock, clear, enable: in STD_LOGIC;
				D: in STD_LOGIC_VECTOR(N-1 downto 0);
	        	Q: out STD_LOGIC_VECTOR (N-1 downto 0));
	end component;
	
	component hazarddec is
		port(	branch, branch_id, branch_ex		: in  std_logic;
		    pcsrc, pcsrc_mem					: in  std_logic;
			jump, jumpid, memwrite, alusrc, wid, wex	: in  std_logic;
			r1, r2, rid, rex					: in  std_logic_vector(4 downto 0);
			enablepc, flushid, enableif			: out std_logic);
	end component;
  
	signal writereg:           STD_LOGIC_VECTOR(4 downto 0);
	signal pcjump, pcnext, 
	       pcnextbr, pcplus4, 
	       pcbranch:           STD_LOGIC_VECTOR(31 downto 0);
	signal signimm, signimmsh: STD_LOGIC_VECTOR(31 downto 0);
	signal srca, srcb, result: STD_LOGIC_VECTOR(31 downto 0);
	signal s_aluout, s_writedata : std_logic_vector(31 downto 0);
	signal s_zero, pcsrc : std_logic;
  
	--sinais pos pipeline						   				   
	signal s_if  : std_logic_vector( 63 downto 0); 
	signal s_id  : std_logic_vector(142 downto 0);  
	signal s_ex  : std_logic_vector(106 downto 0);
	signal s_mem : std_logic_vector( 71 downto 0);
	
	signal s_rid, s_rex : std_logic_vector(4 downto 0);
	
	-- hazard control unity
	signal s_enable_pc, s_flush_id, s_enable_if, s_pcsrc_mem : std_logic;	
	signal s_control_id : std_logic_vector(9 downto 0);
	signal s_jump : std_logic;
begin
 
	pcbrmux: mux2 
		generic map(32) 
		port map(pcplus4, pcbranch, pcsrc, pcnextbr);  
		
	pcmux: mux2 
		generic map(32) 
		port map(pcnextbr, pcjump, s_jump, pcnext);
																				 
	pcreg: registrador_n
		generic map(32)
  		port map(	clk, reset, s_enable_pc,
        			pcnext,
        			pc);
		
	pcadd1: adder 
		port map(pc, X"00000004", pcplus4);
	
	----------------------------------	 
	-- PcPlus4 (63 downto 32) |Instruction (31 downto 0)
	if_reg : registrador_n
		generic map(64)
		port map(	clk, reset, s_enable_if,
					pcplus4 & instr,
	  				s_if);
	----------------------------------
	
	op    <= s_if(31 downto 26);
	funct <= s_if( 5 downto  0);
	
	wrmux: mux2 
		generic map(5) 
		port map(	s_if(20 downto 16), 
					s_if(15 downto 11), 
					regdst, writereg);
					
	rf: regfile 
		port map(	clk, s_mem(0),
					s_if(25 downto 21), s_if(20 downto 16),
					s_mem(5 downto 1), result, 
					srca, s_writedata);	
	
	-- Imediate
  	se: signext 
	  	port map(s_if(15 downto 0),c, signimm);
	  
	-- Jump  
	pcjump <= s_if(63 downto 60) & s_if(25 downto 0) & "00"; -- endereço jump 
	s_jump <= jump and not s_flush_id;
	
	--flush	
	 flush_id_mux: mux2 
		generic map(10) 
		port map(	jump & alusrc & alucontrol & s_if(26) & branch & memwrite & memtoreg & regwrite, 
					"00" & X"00", 
					s_flush_id, s_control_id); 
					
	----------------------------------	
	-- jump (142) | alusource (141) | alucontrol (140 downto 138)||
	-- inst0 (137) | branch (136) | memwrite (135) || memtoreg (134)
	-- Pcplus4 (133 downto 102)|Reg1 (101 downto 70)|Reg2 (69 downto 38)|
	-- Imediate (37 dwonto 6)| WriteAddress (5 downto 1) | WriteEnable (0)
	
	id_reg : registrador_n
		generic map(143)
		port map(	clk, reset, '1',
					s_control_id(9 downto 1) &
					s_if(63 downto 32) & srca & s_writedata & signimm & writereg & s_control_id(0),
	  				s_id);
	----------------------------------
	   
	-- PC Logic
	immsh: sl2 
		port map(s_id(37 downto 6), signimmsh);   
	
	pcadd2: adder 
		port map(s_id(133 downto 102), signimmsh, pcbranch);
			
	-- ALU	 
	srcbmux: mux2 
		generic map(32) 
		port map(s_id(69 downto 38), s_id(37 downto 6), s_id(141),srcb);	
	
	mainalu: alu 
		port map(s_id(101 downto 70), srcb, s_id(140 downto 138), s_aluout, s_zero);
		   
	----------------------------------
	-- inst0 (106) | branch (105) | memwrite (104) || memtoreg (103)
	-- PcBranch (102 downto 71)| zero (70)| AluOut (69 downto 38)| Reg2 (37 downto 6)|
	-- WriteAddress (5 downto 1) | WriteEnable (0)
	ex_reg : registrador_n
		generic map(107)
		port map(	clk, reset, '1',
					s_id(137 downto 134) & pcbranch & s_zero & s_aluout & s_id(69 downto 38) & s_id(5 downto 0),
	  				s_ex);
	----------------------------------
									 
	memwritepip <= s_ex(104);
	pcsrc 		<= s_ex(105) and (s_ex(70) xor s_ex(106));
	aluout 		<= s_ex(69 downto 38);
	writedata 	<= s_ex(37 downto 6);
	      
	----------------------------------
	-- pcsrc(71) | memtoreg (70)
	-- ReadData (69 downto 38) | AluOut (37 downto 6) |
	-- WriteAddress (5 downto 1) | WriteEnable (0)
	mem_reg : registrador_n
		generic map(72)
		port map(	clk, reset, '1',
					pcsrc & s_ex(103) & readdata & s_ex(69 downto 38) & s_ex(5 downto 0),
	  				s_mem);
	----------------------------------
	
	resmux: mux2 
		generic map(32) 
		port map(	s_mem(37 downto 6), s_mem(69 downto 38), 
					s_mem(70), result);	
			
	----------------------------------
	-- Hazard control unity
	
	haz : hazarddec
	port map(		branch, s_id(136), s_ex(105), 
					pcsrc, s_mem(71),
					jump, s_id(142), memwrite, alusrc, s_id(0), s_ex(0), 
					s_if(25 downto 21), s_if(20 downto 16), s_id(5 downto 1), s_ex(5 downto 1),
					s_enable_pc, s_flush_id, s_enable_if);	
				
end;
  