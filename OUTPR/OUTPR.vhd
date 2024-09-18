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