
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
    port(clk, reset, c:     in  STD_LOGIC;
         memtoreg, branch:   in  STD_LOGIC;
         alusrc, regdst:    in  STD_LOGIC;
         regwrite, jump:    in  STD_LOGIC;
		 memwrite:			in std_logic;  
		 memwritepip:		out std_logic;
         alucontrol:        in  STD_LOGIC_VECTOR(2 downto 0);
         pc:                buffer STD_LOGIC_VECTOR(31 downto 0);
         instr:             in STD_LOGIC_VECTOR(31 downto 0);
         aluout, writedata: buffer STD_LOGIC_VECTOR(31 downto 0);
         readdata:          in  STD_LOGIC_VECTOR(31 downto 0);
		 op, funct:         out std_logic_vector(5 downto 0));
  end component;
  
  signal memtoreg, alusrc, regdst, regwrite, jump, branch, s_c, s_memwrite: STD_LOGIC;
  signal alucontrol: STD_LOGIC_VECTOR(2 downto 0);
  signal s_op, s_funct: std_logic_vector(5 downto 0);
begin
  cont: controller port map(s_op, s_funct,
  							memtoreg, s_memwrite, branch, alusrc, s_c,
                            regdst, regwrite, jump, alucontrol);
  dp: datapath port map(clk, reset, s_c, memtoreg, branch, alusrc, regdst,
                        regwrite, jump, s_memwrite, memwrite, alucontrol, pc, instr,
                        aluout, writedata, readdata, s_op, s_funct);
end;
