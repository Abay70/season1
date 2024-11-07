--Memory--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
Entity Memory_4096 is
   port(
         inpm    : in   std_logic_vector(15 downto 0);
         outpm   : out  std_logic_vector(15 downto 0);
         AR      : in   std_logic_vector(11 downto 0);
         w       : in   std_logic;
         clk     : in   std_logic;
         r       : in   std_logic
   );
end entity;

architecture Memory_4096_behave of Memory_4096 is
type MTD is array(0 to 4095) of std_logic_vector(15 downto 0);
signal data : MTD:=(
0      => "0010111111111111",
1      => "0001111111111110",
2      => "1111010000000000",
3      => "0111000000000001",
4094   => "0000000000000101",
4095   => "0000000000000011",
Others => "0000000000000000" );
begin
process(clk)
   begin
      if rising_edge(clk) then
         if r = '1' or w = '0' then
            outpm <= data(to_integer(unsigned(AR)))    ; 
         elsif w = '1' and r = '0' then
            data(to_integer(unsigned(AR))) <= inpm     ;
         end if;
      end if;
   end process;
end architecture;
--AR--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity AR16 is
port (
      inar : in    std_logic_vector(11  downto 0);
      outar: out   std_logic_vector(11  downto 0);
      clk  : in    std_logic                    ;
      load : in    std_logic                    ;
      incr : in    std_logic                    ;
      clr  : in    std_logic                    
      );
End Entity;
Architecture AR16_behave of AR16 is 
signal S_AR : std_logic_vector(11  downto 0):="000000000000";
Begin
 process (clk)
  begin
    if clk'event and clk='1' then
       if    clr='1' then 
             S_AR <= "000000000000" ;
       elsif incr='1' and S_AR /="111111111111"  then
             S_AR <= S_AR + "000000000001" ;
       elsif incr='1' and S_AR  ="111111111111"  then
             S_AR <= "000000000000" ;
       elsif load='1' then
       S_AR <= inar;
       end if;
    end if;
 end process;
outar<=S_AR;
end Architecture;
--PC--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity PC_16 is 
port( 
   inpc  : in   std_logic_vector(11 downto 0)  ;
	  outpc : out  std_logic_vector(11  downto 0) ;
	  clk   : in   std_logic                      ;
	  load  : in   std_logic                      ;
	  clr   : in   std_logic                      ;
	  incr  : in   std_logic 
	  );
End Entity;
Architecture PC_16_behave of PC_16 is
signal S_PC :     std_logic_vector(11 downto 0):="000000000000" ; 	  
Begin
     process (clk) 
     begin 
			 if clk'event and clk='1'	then
		        if              clr='1'                 then
				         S_PC <= "000000000000" ;
				  elsif incr='1' and S_PC/="111111111111" then
				         S_PC <= S_PC + "000000000001" ;
				  elsif incr='1' and  S_PC="111111111111" then		
				         S_PC <= "000000000000" ;
       elsif load='1' then
				         S_PC <= inpc           ;
				  end if;
			end if;
     end process;
outpc <= S_PC ;

End Architecture;	
--DR--
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
Entity DR_16 is 
port (
      indr : in    std_logic_vector(15  downto 0);
      outdr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
    		DR0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
End Entity;
Architecture DR_16_behave of DR_16 is 
signal S_DR : std_logic_vector(15  downto 0):="0000000000000000";
Begin
 process (clk)
  begin
    if clk'event and clk='1' then
       if    clr='1' then 
             S_DR <= "0000000000000000" ;
       elsif incr='1' and S_DR /="1111111111111111"  then
             S_DR <= S_DR + "0000000000000001" ;
       elsif incr='1' and S_DR  ="1111111111111111"  then
             S_DR <= "0000000000000000" ;
       elsif load='1' then
             S_DR <= indr;
       end if;
    end if;
	 if S_DR = "0000000000000000" then
	 DR0<='1';
	 else 
	 DR0<='0';
	 end if;
 end process;
outdr<=S_DR;
end Architecture;
--AC--
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
Entity AC_16 is 
port (
      inac : in    std_logic_vector(15  downto 0);
      outac: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
	    	AC15 : out   std_logic                     ;
		    AC0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
End Entity;
Architecture AC_16_behave of AC_16 is 
signal S_AC : std_logic_vector(15  downto 0):="0000000000000000";
Begin
 process (clk)
  begin
    if clk'event and clk='1' then
    if    clr='1' then 
       S_AC <= "0000000000000000" ;
    elsif incr='1' and S_AC /="1111111111111111"  then
       S_AC <= S_AC + "0000000000000001" ;
    elsif incr='1' and S_AC  ="1111111111111111"  then
       S_AC <= "0000000000000000" ;
    elsif  load='1' then
       S_AC <= inac;
    end if;
    end if;
	 if S_AC="0000000000000000" then
	 AC0<='1';
	 else 
	 AC0<='0';
	 end if;
 end process;
outac<=S_AC;
AC15<=S_AC(15);
end Architecture;
--IR--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity IR_16 is
port(
   inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
End Entity;
Architecture IR_16_behave of IR_16 is
signal S_IR : std_logic_vector(15 downto 0):="0010000000000100";   
Begin
   process (clk)
     begin
          if clk'event and clk='1' then
             if  load='1' then
				     S_IR <= inir ;
				 end if;
			 end if;
		end process;
outir<=S_IR;
end Architecture;		
--TR--
library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
Entity TR_16 is 
port (
      intr : in    std_logic_vector(15  downto 0);
      outtr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
      clr  : in    std_logic                    
      );
End Entity;
Architecture TR_16_behave of TR_16 is 
signal S_TR : std_logic_vector(15  downto 0):="0000000000000000";
Begin
 process (clk)
  begin
    if clk'event and clk='1' then
    if    clr='1' then 
       S_TR <= "0000000000000000" ;
    elsif incr='1' and S_TR /="1111111111111111"  then
       S_TR <= S_TR + "0000000000000001" ;
    elsif incr='1' and S_TR  ="1111111111111111"  then
       S_TR <= "0000000000000000" ;
    elsif  load='1' then
       S_TR <= intr;
    end if;
    end if;
 end process;
outtr<=S_TR;
end Architecture;
--INPR--
library ieee;
use ieee.std_logic_1164.all;
Entity INPR is
  port(
       inin    : in  std_logic_vector(7 downto 0 );
       outin   : out std_logic_vector(7 downto 0 );
       FGI     : in  std_logic                    ;
       clk     : in  std_logic
       );
end entity;
Architecture INPR_behave of INPR is
Begin
 process (clk)
      begin
           if clk'event and clk='1' then
               if FGI='0' then
                       outin <= inin   ;
               end if;
           end if;
       end process;
end Architecture;
--OUTR--
Library ieee;
use ieee.std_logic_1164.all;
Entity OUTR16 is
port(
     inoutr   : in   std_logic_vector(7 downto 0) ;
     outoutr  : out  std_logic_vector(7 downto 0) ;
     FGO      : in   std_logic                    ;
     clk      : in   std_logic                      
     );
End entity;
Architecture OUTR16_behave of OUTR16 is 
Begin
process(clk)
  begin
       if clk'event and clk='1' then
          if FGO='1' or FGO='U' then
             outoutr<= inoutr;
          end if;
       end if;
end process;
end Architecture;
--SC--
library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     En    : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
End Entity;
Architecture SC_behave of SC is
Signal S_SCout : std_logic_vector(3 downto 0):="0000" ;
Begin
Process(clk)
variable  SS_SCout : std_logic_vector(3 downto 0):="0000" ;
    Begin
         if clk'event and clk='1' then
            if EN='1' then
             if clear='1' then
                S_SCout <= "0000" ;
                SS_SCout:= "0000" ;
             else
                S_SCout  <=  SS_SCout    ;
                SS_SCout :=  SS_SCout + "0001" ;
             end if;
            elsif EN='0' then
                S_SCout <= "0000" ;
                SS_SCout:= "0000" ;
            End if;
         end if;
	end process;
SCout<= S_SCout;
End Architecture;
--ALU--
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity MiniALU is
 port (
        Sel     :  in  std_logic_vector(2  downto 0);
        DRin    :  in  std_logic_vector(15 downto 0);
        Acin    :  in  std_logic_vector(15 downto 0);
        ALUout  :  out std_logic_vector(15 downto 0);
        inpr    :  in  std_logic_vector(7 downto 0 );
        Cin     :  in  std_logic                    ;
        Cout    :  out std_logic                   );
End Entity;
Architecture MiniALU_behave of MiniALU is
signal S_ALu  : std_logic_vector(16  downto 0):="00000000000000000" ;
signal W      : std_logic_vector(16  downto 0)                     ;
signal Q      : std_logic_vector(16  downto 0)                     ;
signal S_inpr : std_logic_vector(15  downto 0)                     ;
Begin
S_inpr <= "00000000" & inpr;
W      <= '0'        & ACin;
Q      <= '0'        & DRin;
    process(Sel , DRin , Acin , cin , S_inpr , W ,Q  , S_ALu)
            begin
               case Sel is
                   when "000" =>
                               ALUout <= S_inpr                   ; 
                   when "001" =>
                               S_ALU  <=   W +  Q                 ;
                               --ALUout <= S_ALU(15 downto 0)       ;
                               Cout <= S_ALU(16)                  ;
                   when "010" =>
                               S_ALU <= W and Q                   ;
                   when "011" =>
                               S_ALU <= Q                         ;
                   when "100" =>
                               S_ALU <= not W                     ;
                               S_ALU(16) <= '0'                   ;
                   when "101" =>
                               S_ALU <='0'& Cin & W(15 downto 1) ;
                   when "111" => 
                               S_ALU <='0'&Acin(14 downto 0)&'0' ;
                               Cout   <= w(15)                    ;
                   when others =>
                               S_ALU <= S_ALU                    ;
               end case;
ALUout <= S_ALU(15 downto 0)       ;
    end process;
End Architecture;
--E--
Library Ieee;
use Ieee.std_logic_1164.all;
Entity E is
port(
     inE    : in   std_logic  ;
	    loadE  : in   std_logic  ;
	    clearE : in   std_logic  ;
	    NOTE   : in   std_logic  ; 
     clk    : in   std_logic  ;
     oute   : out  std_logic  
     );
End Entity;
Architecture E_behave of E is
Signal S_E : std_logic:='0';
Begin
     process(clk)
        Begin
              if clk'event and clk='1' then
				     if LoadE='1' then 
					      S_E <=inE     ;
						elsif ClearE='1' then
					      S_E <= '0'    ;
						elsif NOTE='1' then
					      S_E <= Not S_E ;
						end if;
					end if;	
     end process;
end Architecture;
--FGI--
library ieee;
use ieee.std_logic_1164.all;
Entity FGI is
port(
     FGI_in  : in   std_logic     ;
     FGI_out : out  std_logic     ;
     clk     : in   std_logic
     );
End Entity;
Architecture FGI_behave of FGI is
Signal FGI_out_s : std_logic:='0';
Begin
     process (clk)
        begin
            if clk'event and clk='1' then
                   FGI_out_s <= FGI_in ;
            end if;
     end process;
FGI_out<=FGI_out_s;
End Architecture;
--FGO--
library ieee;
use ieee.std_logic_1164.all;
Entity FGO is
port(
     FGO_in  : in   std_logic     ;
     FGO_out : out  std_logic     ;
     clk     : in   std_logic
     );
End Entity;
Architecture FGO_behave of FGO is
Signal FGO_out_s : std_logic:='1';
Begin
     process (clk)
        begin
            if clk'event and clk='1' then
                   FGO_out_s <= FGO_in ;
            end if;
     end process;
FGO_out_s<=FGO_out_s;
End Architecture;
--IEN--
library Ieee;
Use Ieee.std_logic_1164.all;
Entity IEN is
port(
     IENin  :  in   std_logic  ;
     IENout :  out  std_logic  ;
     clk    :  in   std_logic  
     );
End Entity;
Architecture IEN_Behave of IEN is
Begin
  process (clk)
         Begin
               if clk'event and clk='1' then
                    IENout <= IENin  ;
               End if;
   End process;
End Architecture;
--R--
Library Ieee;
Use Ieee.std_logic_1164.all;
Entity R_D is
port(
     inr  : in  std_logic   ;
     outr : out std_logic   ;
     clk  : in  std_logic   
     );
End Entity;
Architecture R_behave of R_D is
SIGNAL outr_s : std_logic:='0';
Begin 
   process(clk)
          Begin
               if clk'event and clk='1' then
                  outr_s <= inr ;
               end if;
   End process;
outr<= outr_s;
End Architecture;
--S--
library Ieee;
Use ieee.std_logic_1164.all;
Entity S is
port(
     inuser  :  in  std_logic  ;
     inCU    :  in  std_logic  ;
     outs    :  out std_logic  ;
     clk     :  in  std_logic 
     );
End Entity;
Architecture S_Behave of S is
Signal S_outs : std_logic:='0';
Begin
     process(clk)
       Begin
            if clk'event and clk='1' then  
                  S_outs <= inuser or inCu ;
            End if;
     End process;
outs<=S_outs;
End Architecture;
--Decoder4*16--
library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
End Entity;
Architecture Decoder4_behave of Decoder4 is
signal  o1 : std_logic_vector(15 downto 0):="0000000000000001";
Begin
 process ( sel , o1 )
   begin
     case sel is
          when "0000" =>
               o1<="0000000000000001" ;
          when "0001" =>
               o1<="0000000000000010" ;
          when "0010" =>
               o1<="0000000000000100" ;
          when "0011" =>
               o1<="0000000000001000" ;
          when "0100" =>
               o1<="0000000000010000" ;
          when "0101" =>
               o1<="0000000000100000" ;
          when "0110" =>      
               o1<="0000000001000000" ;
          when "0111" =>
               o1<="0000000010000000" ;
          when "1000" =>
               o1<="0000000100000000" ;
          when "1001" =>   
               o1<="0000001000000000" ;
          when "1010" =>
               o1<="0000010000000000" ;
          when "1011" =>
               o1<="0000100000000000" ;
          when "1100" =>
               o1<="0001000000000000" ;
          when "1101" =>
               o1<="0010000000000000" ;
          when "1110" =>
               o1<="0100000000000000" ;
          when others =>
               o1<="1000000000000000" ;
     end case;
end process;
o<=o1;
End Architecture;
--Decoder3*8--
library Ieee;
use ieee.std_logic_1164.all;
Entity Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0) ;
      o   : out std_logic_vector(7 downto 0) 
      );
End Entity;
Architecture Decoder3_behave of Decoder3 is
Begin
    o<=
       "00000001" when sel="000" else
       "00000010" when sel="001" else
       "00000100" when sel="010" else
       "00001000" when sel="011" else
       "00010000" when sel="100" else
       "00100000" when sel="101" else
       "01000000" when sel="110" else
       "10000000" when sel="111"       ;
End Architecture;
--CU--
library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity CU_16 is
 port(
      inir     : in    std_logic_vector(15 downto 0) ;
      DR0      : in    std_logic                     ;
      AC15     : in    std_logic                     ;
      T0,T1    : in    std_logic                     ;
      T2,T3    : in    std_logic                     ; 
      T4,T5,T6 : in    std_logic                     ;
      FGIin    : in    std_logic                     ;
      FGOin    : in    std_logic                     ;
      FGIout   : out   std_logic                     ;
      FGOout   : out   std_logic                     ;
      ALUsel   : out   std_logic_vector(2 downto 0)  ;
      laodar   : out   std_logic                     ;
      loadpc   : out   std_logic                     ;
      laoddr   : out   std_logic                     ;
      loadac   : out   std_logic                     ;
      laodir   : out   std_logic                     ;
      loadtr   : out   std_logic                     ;
      loadoutr : out   std_logic                     ;
      w        : out   std_logic                     ;
      r        : out   std_logic                     ;
      clearar  : out   std_logic                     ;
      clearpc  : out   std_logic                     ;
      clearac  : out   std_logic                     ;
      incrar   : out   std_logic                     ;
      incrpc   : out   std_logic                     ;
      incrdr   : out   std_logic                     ;
      incrac   : out   std_logic                     ;
      clearsc  : out   std_logic                     ;
      selb     : out   std_logic_vector(2 downto 0)  ;
      Rin      : in    std_logic                     ;
      IENin    : in    std_logic                     ;
      Rout     : out   std_logic                     ;
      Ein      : in    std_logic                     ;
      loadE    : out   std_logic                     ;
      NotE     : out   std_logic                     ;
      clearE   : out   std_logic                     ;
      AC0      : in    std_logic                     ;
      IENo,So  : out   std_logic                    
      );
End Entity;
Architecture CU_16_behave of CU_16 is
component Decoder3 is
 port(
      sel : in  std_logic_vector(2 downto 0 ) ;
      o   : out std_logic_vector(7 downto 0 ) 
      );
End component;
signal I,rs  : std_logic                       ;
signal OPC   : std_logic_vector( 2 downto 0 )  ;
signal B     : std_logic_vector(11 downto 0 )  ;
signal R_s ,p: std_logic                       ;
signal D     : std_logic_vector( 7 downto 0 )  ;
Begin
I     <= inir(15)                  ;
OPC   <= inir(14 downto 12)        ;
B     <= inir(11 downto 0)         ;
U1: Decoder3 port map(OPC,D)       ;
R_s   <= D(7) and (Not I ) and T3  ;
p     <= D(7) and      I   and T3  ;    
      laodar   <=
           ((Not Rin) and T0) or ((Not Rin) and T2) or ((Not D(7)) and I and T3);
      loadpc   <=
           (D(4) and T4) or (D(5) and T5)                                       ;
      laoddr   <=
           (D(0) and T4) or (D(1) and T4) or (D(2) and T4) or (D(6) and T4)     ;
      loadac   <=
           (D(0) and T5) or (D(1) and T5) or (D(2) and T5) or (R_s and B(9)) or  
           (R_s and B(7))or (R_s and B(6))or (p and B(11))                      ;
      laodir   <=
             (Not Rin) and T1                                                   ;
      loadtr   <=
                  Rin  and T0                                                   ;
      loadoutr <=
                   p   and B(10)                                                ;
      w        <=
           (Rin and T1) or (D(3) and T4) or (D(5) and T4) or (D(6) and T6)      ;
      r        <=
           ((Not Rin) and T1) or ((Not D(7)) and I and T3)or (D(0) and T4) or 
           (D(1) and T4) or (D(2) and T4) or (D(6) and T4)                      ;  
      clearar  <=
                  Rin and T0                                                    ;
      clearpc  <=
                  Rin  and T1                                                   ;
      clearac  <= 
                  R_s and B(11)                                                 ;                  
      incrar   <=
                 D(5) and T5                                                    ;
      incrpc   <=
            ((Not Rin) and T1) or (Rin and T2) or (D(6) and T6 and DR0) or 
            (R_s and B(4) and (Not AC15) ) or (R_s and B(3) and AC15 ) or
            (R_s and B(2) and AC0 ) or (R_s and B(1) and (Not Ein)) or
            (p and B(9) and FGIin) or (p and B(8) and FGOin)                    ;   
      incrdr   <=
               D(6) and T5                                                      ;
      incrac   <=
                  R_s and B(5)                                                  ;
      rs       <=
           ((Not Rin) and T1) or ((Not D(7)) and I and T3)or (D(0) and T4) or 
           (D(1) and T4) or (D(2) and T4) or (D(6) and T4)                      ;
      selb     <=
                 "001" when (D(4) and T4)='1' or (D(5) and T5)='1'                   else
                 "010" when (((Not Rin) and T0) or (Rin and T0) or(D(5) and T4))='1' else
                 "011" when ((D(2) and T5) or (D(6) and T6))='1'                     else
                 "100" when (D(3) and T4)='1' or (p and B(10))='1'                   else
                 "101" when (((Not Rin) and T2))='1'                                 else
                 "110" when ( Rin and T2)='1'                                        else
                 "111" when rs='1'                                                   else
                 "000"                                                                   ;
      clearsc  <=
            (Rin  and T2) or (D(0) and T5) or (D(1) and T5) or (D(2) and T5) or
            (D(3) and T4) or (D(4) and T4) or (D(5) and T5) or (D(6) and T6) or
             p or R_s                                                           ;         
      FGIout   <=
                  (Not  (p and B(9)))                                           ;
      FGOout   <=
                  ( Not  (p and B(8)))                                          ;
      loadE    <=
                   (D(1) and T3) or (R_s and B(7)) or (R_s and B(6))            ;
      NOTE     <=
                    R_s and B(8)                                                ;
      clearE   <=
                    R_s and B(10)                                               ;
      IENo     <= 
                   '0' when (Rin and T2)='1' or (p and B(6))='1'   else 
                   '1' when (p and B(7))='1' else                                    
                   '0'                                                          ;
      So       <=
                   '0' when (Rin and B(0))='1' else
                   '1'                                                          ;                                  
      Rout     <=
                   '0' when (Rin and T2)='1' else
                   '1' when ((Not(T0)) and (Not(T1)) and (Not(T2)) and
                             (FGIin or FGOin) and IENin)='1'                   ;
      ALUsel   <=  "000" when (p     and B(11))='1' else
                   "001" when (D(1)  and T5   )='1' else
                   "010" when (D(0)  and T5   )='1' else 
                   "011" when (D(2)  and T5   )='1' else
                   "100" when (R_S and B(9)   )='1' else
                   "101" when (R_S and B(7)   )='1' else
                   "111" when (R_S and B(6)   )='1' else
                   "110"                                 ;
End Architecture ;
--Bus--
library ieee;
use ieee.std_logic_1164.all;
Entity BUS16 is
port(
    inb1 :  in  std_logic_vector(11 downto 0);
	  inb2  :  in  std_logic_vector(11 downto 0);
	  inb3  :  in  std_logic_vector(15 downto 0);
	  inb4  :  in  std_logic_vector(15 downto 0);
	  inb5  :  in  std_logic_vector(15 downto 0);
	  inb6  :  in  std_logic_vector(15 downto 0);
	  inb7  :  in  std_logic_vector(15 downto 0);
	  outb  :  out std_logic_vector(15 downto 0);
	  selm  :  in  std_logic_vector(2  downto 0)
	  );
End entity;
Architecture BUS16_Behave of BUS16 is
Signal S_BUS :    std_logic_vector(15 downto 0);
Begin
process (inb1,inb2,inb3,inb4,inb5,inb6,inb7,selm)
begin
    case selm is  
       when "001" =>
          S_BUS <= "0000" & inb1  ;
       when "010" =>   
          S_BUS <= "0000" & inb2  ;
       when "011" =>
          S_BUS <= inb3           ;
       when "100" =>
			      S_BUS <= inb4           ;
       when "101" =>
			      S_BUS <= inb5           ;
       when "110" =>
		     	 S_BUS <= inb6           ;
       when "111" =>
			      S_BUS <= inb7           ;
       when others =>
		       S_BUS <=	S_BUS  ;
end case;
end process;
outb <= S_BUS				;
end Architecture;
--------------------------------------------------------------------------------------------



--Mano Machine--


Library Ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_Unsigned.all;
Entity Mano_Machine is
   Port(
         St      :  in      std_logic                      ;
         clk     :  in      std_logic                      ;
         Inuser  :  in      std_logic_vector( 7 downto 0 ) ;
         Output  :  out     Std_logic_vector( 7 downto 0 ) 
        );
End Entity;
Architecture Mano_Machine_Behave of Mano_Machine is
------------ Components -------------
Component Memory_4096 is
   port(
         inpm    : in   std_logic_vector(15 downto 0);
         outpm   : out  std_logic_vector(15 downto 0);
         AR      : in   std_logic_vector(11 downto 0);
         w       : in   std_logic;
         clk     : in   std_logic;
         r       : in   std_logic
   );
End Component;
Component AR16 is
port (
      inar : in    std_logic_vector(11  downto 0);
      outar: out   std_logic_vector(11  downto 0);
      clk  : in    std_logic                    ;
      load : in    std_logic                    ;
      incr : in    std_logic                    ;
      clr  : in    std_logic                    
      );
End Component;
Component  PC_16 is 
port( 
   inpc  : in   std_logic_vector(11 downto 0)  ;
	  outpc : out  std_logic_vector(11  downto 0) ;
	  clk   : in   std_logic                      ;
	  load  : in   std_logic                      ;
	  clr   : in   std_logic                      ;
	  incr  : in   std_logic 
	  );
End Component;
Component DR_16 is 
port (
      indr : in    std_logic_vector(15  downto 0);
      outdr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
    		DR0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component AC_16 is 
port (
      inac : in    std_logic_vector(15  downto 0);
      outac: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
	    	AC15 : out   std_logic                     ;
		    AC0  : out   std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component IR_16 is
port(
   inir  : in   std_logic_vector(15 downto 0);
	  outir : out  std_logic_vector(15 downto 0);
	  clk   : in   std_logic                    ;
	  load  : in   std_logic                     
	  );
END Component;
Component TR_16 is 
port (
      intr : in    std_logic_vector(15  downto 0);
      outtr: out   std_logic_vector(15  downto 0);
      clk  : in    std_logic                     ;
      load : in    std_logic                     ;
      incr : in    std_logic                     ;
      clr  : in    std_logic                    
      );
END Component;
Component  INPR is
  port(
       inin    : in  std_logic_vector(7 downto 0 );
       outin   : out std_logic_vector(7 downto 0 );
       FGI     : in  std_logic                    ;
       clk     : in  std_logic
       );
END Component;
Component  OUTR16 is
port(
     inoutr   : in   std_logic_vector(7 downto 0) ;
     outoutr  : out  std_logic_vector(7 downto 0) ;
     FGO      : in   std_logic                    ;
     clk      : in   std_logic                      
     );
END Component;
Component SC is
port( 
     clk   : in  std_logic                    ;
     clear : in  std_logic                    ;
     En    : in  std_logic                    ;
     SCout : out std_logic_vector(3 downto 0) 
     );
END Component;
Component  MiniALU is
 port (
        Sel     :  in  std_logic_vector(2  downto 0);
        DRin    :  in  std_logic_vector(15 downto 0);
        Acin    :  in  std_logic_vector(15 downto 0);
        ALUout  :  out std_logic_vector(15 downto 0);
        inpr    :  in  std_logic_vector(7 downto 0 );
        Cin     :  in  std_logic                    ;
        Cout    :  out std_logic                   
       );
END Component;
Component E is
port(
     inE    : in   std_logic  ;
	    loadE  : in   std_logic  ;
	    clearE : in   std_logic  ;
	    NOTE   : in   std_logic  ; 
     clk    : in   std_logic  ;
     oute   : out  std_logic  
     );
END Component;
Component FGI is
port(
     FGI_in  : in   std_logic     ;
     FGI_out : out  std_logic     ;
     clk     : in   std_logic
     );
END Component;
Component FGO is
port(
     FGO_in  : in   std_logic     ;
     FGO_out : out  std_logic     ;
     clk     : in   std_logic
     );
END Component;
Component IEN is
port(
     IENin  :  in   std_logic  ;
     IENout :  out  std_logic  ;
     clk    :  in   std_logic  
     );
End Component;
Component  S is
port(
     inuser  :  in  std_logic  ;
     inCU    :  in  std_logic  ;
     outs    :  out std_logic  ;
     clk     :  in  std_logic 
     );
END Component;
Component  R_D is
port(
     inr  : in  std_logic   ;
     outr : out std_logic   ;
     clk  : in  std_logic   
     );
END Component;
Component  Decoder4 is
 port(
      sel : in  std_logic_vector(3 downto 0) ;
      o   : out std_logic_vector(15 downto 0) 
      );
END Component;
Component  CU_16 is
 port(
      inir     : in    std_logic_vector(15 downto 0) ;
      DR0      : in    std_logic                     ;
      AC15     : in    std_logic                     ;
      T0,T1    : in    std_logic                     ;
      T2,T3    : in    std_logic                     ; 
      T4,T5,T6 : in    std_logic                     ;
      FGIin    : in    std_logic                     ;
      FGOin    : in    std_logic                     ;
      FGIout   : out   std_logic                     ;
      FGOout   : out   std_logic                     ;
      ALUsel   : out   std_logic_vector(2 downto 0)  ;
      laodar   : out   std_logic                     ;
      loadpc   : out   std_logic                     ;
      laoddr   : out   std_logic                     ;
      loadac   : out   std_logic                     ;
      laodir   : out   std_logic                     ;
      loadtr   : out   std_logic                     ;
      loadoutr : out   std_logic                     ;
      w        : out   std_logic                     ;
      r        : out   std_logic                     ;
      clearar  : out   std_logic                     ;
      clearpc  : out   std_logic                     ;
      clearac  : out   std_logic                     ;
      incrar   : out   std_logic                     ;
      incrpc   : out   std_logic                     ;
      incrdr   : out   std_logic                     ;
      incrac   : out   std_logic                     ;
      clearsc  : out   std_logic                     ;
      selb     : out   std_logic_vector(2 downto 0)  ;
      Rin      : in    std_logic                     ;
      IENin    : in    std_logic                     ;
      Rout     : out   std_logic                     ;
      Ein      : in    std_logic                     ;
      loadE    : out   std_logic                     ;
      NotE     : out   std_logic                     ;
      clearE   : out   std_logic                     ;
      AC0      : in    std_logic                     ;
      IENo,So  : out   std_logic                    
      );
END Component;
Component BUS16 is
port(
    inb1 :  in  std_logic_vector(11 downto 0);
	  inb2  :  in  std_logic_vector(11 downto 0);
	  inb3  :  in  std_logic_vector(15 downto 0);
	  inb4  :  in  std_logic_vector(15 downto 0);
	  inb5  :  in  std_logic_vector(15 downto 0);
	  inb6  :  in  std_logic_vector(15 downto 0);
	  inb7  :  in  std_logic_vector(15 downto 0);
	  outb  :  out std_logic_vector(15 downto 0);
	  selm  :  in  std_logic_vector(2  downto 0)
	  );
END Component;
signal      DR0      :    std_logic                     ;-- if DR=0
signal      AC15     :    std_logic                     ;--AC High Bit
--Time Pulse
signal      T0,T1    :    std_logic                     ;
signal      T2,T3    :    std_logic                     ; 
signal      T4,T5,T6 :    std_logic                     ;
--
signal      FGIin    :    std_logic                     ;--Flag Cuurent Value
signal      FGOin    :    std_logic                     ;--Flag Cuurent Value
signal      FGIout   :    std_logic                     ;--To flag
signal      FGOout   :    std_logic                     ;--To flag
signal      ALUsel   :    std_logic_vector(2 downto 0)  ;--Alu select
-- Load clear incr w r
signal      laodar   :    std_logic                     ;
signal      loadpc   :    std_logic                     ;
signal      laoddr   :    std_logic                     ;
signal      loadac   :    std_logic                     ;
signal      laodir   :    std_logic                     ;
signal      loadtr   :    std_logic                     ;
signal      loadoutr :    std_logic                     ;
signal      w        :    std_logic                     ;
signal      r        :    std_logic                     ;
signal      clearar  :    std_logic                     ;
signal      clearpc  :    std_logic                     ;
signal      clearac  :    std_logic                     ;
signal      incrar   :    std_logic                     ;
signal      incrpc   :    std_logic                     ;
signal      incrdr   :    std_logic                     ;
signal      incrac   :    std_logic                     ;
signal      clearsc  :    std_logic                     ;
--
signal      selb     :    std_logic_vector(2 downto 0)  ;--Bus Select
signal      Rin      :    std_logic                     ;-- R Current Value
signal      IENin    :    std_logic                     ;--IEN Current Value
signal      Rout     :    std_logic                     ;--To R
signal      Ein      :    std_logic                     ;--E Current Value
signal      loadE    :    std_logic                     ;--Load E
signal      NotE     :    std_logic                     ;--Not E
signal      clearE   :    std_logic                     ;--Clear E
signal      AC0      :    std_logic                     ;--If AC=0
signal      IENo,So  :    std_logic                     ;--To IEN,S
signal      DECODER  :    std_logic_vector(15 downto 0) ;--Decoder4*16 Output
signal      S_time   :    std_logic_vector(3  downto 0) ;--SC Output
Signal      AR_DATA  :    std_logic_vector(11 downto 0) ;--AR out
Signal      PC_DATA  :    std_logic_vector(11 downto 0) ;--PC out
Signal      DR_DATA  :    std_logic_vector(15 downto 0) ;--DR out
Signal      AC_DATA  :    std_logic_vector(15 downto 0) ;--AC out
Signal      IR_DATA  :    std_logic_vector(15 downto 0) ;--IR out
Signal      TR_DATA  :    std_logic_vector(15 downto 0) ;--TR out
Signal      MM_DATA  :    std_logic_vector(15 downto 0) ;--Memory out
Signal      ALU_DATA :    std_logic_vector(15 downto 0) ;--Alu out
signal      E_SSS    :    std_logic                     ;--E in - out from ALU
signal      S_DATA   :    std_logic_vector(15 downto 0) ;--Bus Out
Signal      SS_DATA  :    std_logic_vector(11 downto 0) ;--Bus out for 12bit
Signal      In_Data  :    std_logic_vector(7 downto  0) ;--INPR Out
Signal      STA_ST   :    Std_logic                     ;--S Current Value -SC Enable     
Begin
QQ1 : Decoder4   port map (S_time,DECODER);
T0 <= DECODER(0);
T1 <= DECODER(1);
T2 <= DECODER(2);
T3 <= DECODER(3);
T4 <= DECODER(4);
T5 <= DECODER(5);
T6 <= DECODER(6);
BB1 : BUS16       port map(AR_DATA,PC_DATA,DR_DATA,AC_DATA,IR_DATA,TR_DATA,MM_DATA,S_DATA,selb);
CC1 : CU_16       port map(IR_DATA,DR0,AC15,T0,T1,T2,T3,T4,T5,T6,FGIin,FGOin,FGIout,FGOout
                          ,ALUsel,laodar,loadpc,laoddr,loadac,laodir,loadtr,loadoutr,w,r,
                          clearar,clearpc,clearac,incrar,incrpc,incrdr,incrac,clearsc,selb
                          ,Rin,IENin,Rout,Ein,loadE,NotE,clearE,AC0,IENo,So);
MA1 : MiniALU     port map(ALUsel,DR_DATA,AC_DATA,ALU_DATA,In_Data,Ein,E_SSS) ;
SS_DATA <= S_DATA(11 downto 0 );
R1  : Memory_4096 port map(S_DATA,MM_DATA,AR_DATA,w,clk,r);
R2  : AR16        port map(SS_DATA,AR_DATA,clk,laodar,incrAR,clearAR);
R3  : PC_16       port map(SS_DATA,PC_DATA,clk,loadpc,clearpc,incrpc);
R4  : DR_16       port map(S_DATA,DR_DATA,clk,laoddr,incrDR,DR0,'0');
R5  : AC_16       port map(ALU_DATA,AC_DATA,clk,loadac,incrac,AC15,AC0,clearac);
R6  : IR_16       port map(S_DATA,IR_DATA,clk,laodir);
R7  : TR_16       port map(S_DATA,TR_DATA,clk,LoadTR,'0','0');
R8  : INPR        port map(inuser,In_Data,FGIin,clk);
R9  : OUTR16      port map(AC_DATA(7 downto 0),Output,FGOin,clk);
R10 : SC          port map(clk,clearsc,STA_ST,S_time);
DF1 : E           port map(E_SSS,loadE,clearE,NotE,clk,Ein);
DF2 : R_D         port map(Rout,Rin,clk);
DF3 : FGI         port map(FGIOut,FGIin,clk);
DF4 : FGO         port map(FGOout,FGOin,clk);
DF5 : IEN         port map(IENo,IENin,clk);
DF6 : S           port map(st,So,STA_ST,clk);
End Architecture;

--TB 
Library Ieee;
Use Ieee.Std_Logic_1164.all;
Entity TB_Mano_Machine is
End Entity;
Architecture TB_Mano_Machine_Behave Of TB_Mano_Machine is
component  Mano_Machine is
   Port(
         St      :  in      std_logic                      ;
         clk     :  in      std_logic                      ;
         Inuser  :  in      std_logic_vector( 7 downto 0 ) ;
         Output  :  out     Std_logic_vector( 7 downto 0 ) 
        );
End Component;
Signal Clk     : Std_Logic:='1' ;
Signal St      : std_logic:='1' ;
Signal Inuser  : std_logic_vector( 7 downto 0 ) ;
Signal Output  : Std_logic_vector( 7 downto 0 ) ;
Begin
Process
 Begin
     Clk <= Not Clk ;
     Wait For 5 ns;
 End Process;
QQQQW : Mano_Machine Port Map ( St,Clk,Inuser,Output);
End;
        