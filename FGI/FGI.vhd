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