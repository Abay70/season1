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