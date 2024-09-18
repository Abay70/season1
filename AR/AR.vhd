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