Library Ieee;
Use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
Entity Disp_CC is
  Port(
       datadig1 : in  integer  range 0 to 9          ;
       datadig2 : in  integer  range 0 to 9          ;
    	  datadig3 : in  integer  range 0 to 9          ;
    	  datadig4 : in  integer  range 0 to 9          ;
       datadig5 : in  integer  range 0 to 9          ;
       Clk      : in  std_logic                      ;
       dig1     : out std_logic_vector(6 downto 0)   ;
       dig2     : out std_logic_vector(6 downto 0)   ;
    	  dig3     : out std_logic_vector(6 downto 0)   ;
       dig4     : out std_logic_vector(6 downto 0)   ;
       dig5     : out std_logic_vector(6 downto 0)   
       );  
End Entity;
Architecture Disp_CC_Behave Of Disp_CC is
Begin
process(clk)
 Begin
  if clk'event and clk='1' then 
       Case datadig1 IS 
		         When 0 =>
			                 dig1<= "0111111" ;
			        when 1 => 
                     dig1<= "0000110" ;
			        when 2 =>
	                    dig1<= "1011011" ;
		         when 3 =>
	                    dig1<= "1001111" ;
		         when 4 =>
	                    dig1<= "1100110" ;
	     	  	 when 5 =>
                     dig1<= "1101101" ;
	       		 when 6 =>
         	           dig1<= "1111101" ;
	       		 when 7 =>
	                    dig1<= "0000111" ;
	       		 when 8 => 
	                    dig1<= "1111111" ;
		       	 when 9 =>
	                    dig1<= "1101111" ;		
		     End case;
		   Case datadig2 IS 
		         When 0 =>
			                 dig2<= "0111111" ;
			        when 1 => 
	                    dig2<= "0000110" ;
		         when 2 =>
	                    dig2<= "1011011" ;
	     	    when 3 =>
	                    dig2<= "1001111" ;
	     	    when 4 =>
	                    dig2<= "1100110" ;
		       	 when 5 =>
                     dig2<= "1101101" ;
		       	 when 6 =>
	                    dig2<= "1111101" ;
		       	 when 7 =>
	                    dig2<= "0000111" ;
		       	 when 8 => 
	                    dig2<= "1111111" ;
		       	 when 9 =>
	                    dig2<= "1101111" ;		
	    	  End case; 
	     Case datadig3 IS 
		         When 0 =>
			                 dig3<= "0111111" ;
		       	 when 1 => 
	                    dig3<= "0000110" ;
		       	 when 2 =>
	                    dig3<= "1011011" ;
	          when 3 =>
	                    dig3<= "1001111" ;
    		     when 4 =>
     	               dig3<= "1100110" ;
		  	     when 5 =>
                     dig3<= "1101101" ;
      			 when 6 =>
	                    dig3<= "1111101" ;
      			 when 7 =>
	                    dig3<= "0000111" ;
			      when 8 => 
	                    dig3<= "1111111" ;
	      		 when 9 =>
	                   dig3<= "1101111" ;		
		     End case;
		   Case datadig4 IS 
		        When 0 =>
			                dig4<= "0111111" ;
			       when 1 => 
	                   dig4<= "0000110" ;
       			 when 2 =>
	                   dig4<= "1011011" ;
     		    when 3 =>
	                   dig4<= "1001111" ;
     		    when 4 =>
        	           dig4<= "1100110" ;
	    	  	 when 5 =>
                    dig4<= "1101101" ;
	      		 when 6 =>
	                   dig4<= "1111101" ;
	      		 when 7 =>
	                   dig4<= "0000111" ;
		      	 when 8 => 
	                   dig4<= "1111111" ;
			       when 9 =>
	                   dig4<= "1101111" ;		
	    	  End case; 
		    Case datadig5 IS 
		        When 0 =>
			                 dig5<= "0111111" ;
			      when 1 => 
	                   dig5<= "0000110" ;
			      when 2 =>
	                   dig5<= "1011011" ;
      	   when 3 =>
	                   dig5<= "1001111" ;
          when 4 =>
	                   dig5<= "1100110" ;
		       when 5 =>
                    dig5<= "1101101" ;
			      when 6 =>
	                   dig5<= "1111101" ;
			      when 7 =>
	                   dig5<= "0000111" ;
			      when 8 => 
	                   dig5<= "1111111" ;
			      when 9 =>
	                   dig5<= "1101111" ;		
		     End case;
		End if;
End process;
End Architecture;
