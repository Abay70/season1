library ieee;
use ieee.std_logic_1164.all;
Entity BUS16 is
port(
     inb1  :  in  std_logic_vector(11 downto 0);
	  inb2  :  in  std_logic_vector(11 downto 0);
	  inb3  :  in  std_logic_vector(15 downto 0);
	  inb4  :  in  std_logic_vector(15 downto 0);
	  inb5  :  in  std_logic_vector(15 downto 0);
	  inb6  :  in  std_logic_vector(15 downto 0);
	  inb7  :  in  std_logic_vector(15 downto 0);
	  outb  :  out std_logic_vector(15 downto 0);
	  selm  :  in  std_logic_vector(2  downto 0)
	  );
End entity;
Architecture BUS16_Behave of BUS16 is
Signal S_BUS :    std_logic_vector(15 downto 0);
Begin
process (inb1,inb2,inb3,inb4,inb5,inb6,inb7,selm)
begin
    case selm is  
       when "001" =>
          S_BUS <= "0000" & inb1  ;
       when "010" =>   
          S_BUS <= "0000" & inb2  ;
       when "011" =>
          S_BUS <= inb3           ;
       when "100" =>
			      S_BUS <= inb4           ;
       when "101" =>
			      S_BUS <= inb5           ;
       when "110" =>
		     	 S_BUS <= inb6           ;
       when "111" =>
			      S_BUS <= inb7           ;
       when others =>
		       S_BUS <=	S_BUS  ;
end case;
end process;
outb <= S_BUS				;
end Architecture;