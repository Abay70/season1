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