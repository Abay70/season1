Library Ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
Entity CC_Seg_disp is
  port (
        intin  : in   integer  range 0 to 9       ;  
        clk    : in   std_logic                   ;
        Seg_d  : out  std_logic_vector(6 downto 0) 
        );
End entity;
Architecture CC_Seg_disp_Behave of CC_Seg_disp is
Begin
Process (Clk)
   Begin
       if clk'event and clk='1' then
           Case intin IS 
        		    When 0 =>
			              seg_d<= "0111111" ;
          			 when 1 => 
	                 seg_d<= "0000110" ;
		         	 when 2 =>
	                 seg_d<= "1011011" ;
       		     when 3 =>
	                 seg_d<= "1001111" ;
	      	     when 4 =>
	                 seg_d<= "1100110" ;
		  	        when 5 =>
                  seg_d<= "1101101" ;
			          when 6 =>
	                 seg_d<= "1111101" ;
			          when 7 =>
	                 seg_d<= "0000111" ;
			          when 8 => 
	                 seg_d<= "1111111" ;
			          when 9 =>
	                 seg_d<= "1101111" ;		
		        End case; 
        End if;
    End process;
End Architecture;