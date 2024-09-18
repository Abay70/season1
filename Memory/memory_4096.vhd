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