
library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_ARITH.all;

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
       	aluout, writedata	: buffer STD_LOGIC_VECTOR(31 downto 0);
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
  
	signal writereg										: STD_LOGIC_VECTOR( 4 downto 0);
	signal signimm, signimmsh							: STD_LOGIC_VECTOR(31 downto 0);
	signal srca, srcb, result							: STD_LOGIC_VECTOR(31 downto 0);
	
	--PC
	signal s_preview, s_recover, s_result		: std_logic;
	signal pcplus4, pcbranch, pcjump, pcrecover	: STD_LOGIC_VECTOR(31 downto 0); 
	signal pc_aux1, pc_aux2, pcnext 			: STD_LOGIC_VECTOR(31 downto 0);  
	
	--pipeline
	signal s_if  : std_logic_vector( 63 downto 0);
	signal s_id  : std_logic_vector(152 downto 0);
	signal s_ex  : std_logic_vector(107 downto 0);
	signal s_mem : std_logic_vector( 70 downto 0); 
	
	--hazard 
	signal enablepc, enableif, enableid, flushif, flushid, flushex	: std_logic;
	constant c_flushif : std_logic_vector(5 downto 0) := "111111";
	signal zero : std_logic;
	
	--fowarding
	signal s_stall : std_logic;
begin
	
  	pcadd1: adder 
	  port map(pc, X"00000004", pcplus4);
	  
	pcmux1 : mux2
		generic map(32)
		port map(pcplus4, pcbranch, branch and s_preview, pc_aux1);
		
	pcmux2 : mux2
		generic map(32)
		port map(pc_aux1, pcjump, jump, pc_aux2);
		
	pcmux3 : mux2
		generic map(32)
		port map(pc_aux2, pcrecover, s_recover, pcnext);             			-- MUDAR AQUI DEPOIS!!!!
	
	pcreg: registrador_n 
		generic map(32) 
		port map(clk, reset, '1', pcnext, pc);
	
	-----------------------------------------------------
	-- pcplus4 (63 downto 32) | instr (31 downto 0);
	
	IF_reg : registrador_n
		generic map(64)
		port map(	clk, reset,	enableid,
					pcplus4 & instr,
					s_if);	
	-----------------------------------------------------
	
	op 		<= s_if(31 downto 26);
	funct 	<= s_if( 5 downto  0);
  	
	--reg
	rf: regfile 
	port map(	clk, regwrite, 
				s_if(25 downto 21), s_if(20 downto 16), writereg, 
				result, srca, writedata);				 -- MUDAR AQUI DEPOIS!!!!  
	
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
		port map(	clk, reset, '1', 											-- MUDAR AQUI DEPOIS!!!! 
					s_result, s_preview);
		
	immsh: sl2 
		port map(signimm, signimmsh);
	
  	pcadd2: adder 
	  	port map(s_if(63 downto 32), signimmsh, pcbranch);
	
	pcrecovermux : mux2
		generic map(32)
		port map(pcbranch, s_if(63 downto 32), s_preview, pcrecover);
	
	-----------------------------------------------------
	-- jump (152) | alusrc (151) | alucontrol (150 downto 148) || branch (147) | preview (146) | memwrite (145) || writesrc (144) | regwrite (143)
	-- pcrecover (142 downto 111) | R1 (110 downto 106) | R2 (105 downto 101) | content1 (100 downto 69) | content2 (68 downto 37)
	-- imediate (36 downto 5) | wr (4 downto 0)
	
	ID_reg : registrador_n
		generic map(153)
		port map(	clk, reset,	enableif,
					jump & alusrc & alucontrol & branch & s_preview & memwrite & memtoreg & regwrite & pcrecover &
					s_if(25 downto 16) & srca & writedata & signimm &writereg,
					s_id);	
	-----------------------------------------------------
					
  resmux: mux2 generic map(32) port map(aluout, readdata, 
                                        memtoreg, result);

  -- ALU logic
  srcbmux: mux2 generic map(32) port map(writedata, signimm, alusrc, 
                                         srcb);
  mainalu: alu port map(srca, srcb, alucontrol, aluout, zero);
end;
  