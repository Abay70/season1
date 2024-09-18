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