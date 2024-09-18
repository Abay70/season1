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