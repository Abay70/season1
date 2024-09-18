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