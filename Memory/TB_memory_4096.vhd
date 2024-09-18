library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  
Entity Memory_4096 is
   port(
         inpm    : in   std_logic_vector(15 downto 0);
         outpm   : out  std_logic_vector(15 downto 0);
         AR      : in   std_logic_vector(11 downto 0);
         w       : in   std_logic;
         clk     : in   std_logic;
         r       : in   std_logic
   );
end entity;

architecture Memory_4096_behave of Memory_4096 is
type MTD is array(4095 downto 0) of std_logic_vector(15 downto 0);
signal data : MTD ;
begin
process(clk)
   begin
      if rising_edge(clk) then
         if r = '1' or w = '0' then
            outpm <= data(to_integer(unsigned(AR)))    ; 
         elsif w = '1' and r = '0' then
            data(to_integer(unsigned(AR))) <= inpm     ;
         end if;
      end if;
   end process;
end architecture;
-- test bench--
library ieee;
use ieee.std_logic_1164.all;
Entity TB_Memory_4096 is
End Entity;
Architecture TB_Memory_4096_behave of TB_Memory_4096 is
Component  Memory_4096 is
   port(
         inpm    : in   std_logic_vector(15 downto 0);
         outpm   : out  std_logic_vector(15 downto 0);
         AR      : in   std_logic_vector(11 downto 0);
         w       : in   std_logic;
         clk     : in   std_logic;
         r       : in   std_logic
   );
end Component;
Signal   inpm    :    std_logic_vector(15 downto 0);
Signal   outpm   :    std_logic_vector(15 downto 0);
Signal   AR      :    std_logic_vector(11 downto 0);
Signal   w       :    std_logic                    ;
Signal   clk     :    std_logic:='1'               ;
Signal   r       :    std_logic                    ;
Begin
Process 
   Begin
        clk<= not clk ;
              wait for 5 ns;
   End process;
QW1 : Memory_4096 port map (inpm,outpm,AR,W,clk,r);
AR<="000000000000","000000000001" after 14 ns , "000000000010" after 28 ns 
   ,"000000000011" after 35 ns,"000000000000" after 44 ns ,"000000000001" after 58 ns 
   , "000000000010" after 68 ns ,"000000000011" after 74 ns ;
inpm<="1000000000000000","1100000000000000" after 11 ns , "1000000000000001" after 27 ns
     ,"1000000000000010" after 36 ns;
w <= '1','0' after 38 ns;
r <= '0','1' after 39 ns;
End Architecture; 