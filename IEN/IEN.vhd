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