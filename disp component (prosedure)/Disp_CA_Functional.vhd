Library Ieee;
Use ieee.std_logic_1164.all;
Entity Disp_CA_Functional  is
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
Architecture Disp_CA_Functional Of Disp_CA_Functional  is
procedure SEG_DISP (
signal    Datadig : IN  integer  range 0 to 9         ;
Signal    Clk      : in  std_logic                    ;
signal    Dig     : Out std_logic_vector(6 downto 0)  ) is
Begin

   if clk'event and clk='1' then
          if   datadig=0 then 
             Dig <=    Not "0111111";
          elsif   datadig=1 then  
             Dig <=    Not "0000110";
          elsif   datadig=2 then
             Dig <=    Not "1011011"; 
          elsif   datadig=3 then 
             Dig <=    Not "1001111"; 
          elsif   datadig=4 then           
             Dig <=    Not "1100110";
          elsif   datadig=5 then
             Dig <=    Not "1101101";
          elsif   datadig=6 then 
             Dig <=    Not "1111101"; 
          elsif   datadig=7 then
             Dig <=    Not "0000111";
          elsif   datadig=8 then 
             Dig <=    Not "1111111";
          elsif   datadig=9 then   
             Dig <=    Not "1101111";
         end if;
   end if;
End SEG_DISP;
Begin
Seg_disp(datadig1,clk,dig1);
Seg_disp(datadig2,clk,dig2);
Seg_disp(datadig3,clk,dig3);
Seg_disp(datadig4,clk,dig4);
Seg_disp(datadig5,clk,dig5);
End Architecture;


--TB 
Library Ieee;
Use ieee.std_logic_1164.all;
Entity TB_Disp_CA_Functional  is
End Entity;
Architecture TB_Disp_CA_Functional Of TB_Disp_CA_Functional  is
Component Disp_CA_Functional  is
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
End Component;
signal datadig1,datadig2          :  integer  range 0 to 9          ;
Signal datadig3,datadig4,datadig5 :  integer  range 0 to 9          ;
Signal Clk                        :  std_logic:='0'                 ;
Signal dig1,dig2,dig3,dig4,dig5   :  std_logic_vector(6 downto 0)   ;
Begin
     Process
             Begin
                   clk <= Not clk;
                   wait for 5 ns;
      end process;
QW1 : Disp_CA_Functional Port Map(datadig1,datadig2,datadig3,
                                  datadig4,datadig5,clk,
                                  dig1,dig2,dig3,dig4,dig5);
datadig1 <= 1 , 0 after 10 ns;
datadig2 <= 3 , 2 after 20 ns;
datadig3 <= 4 , 5 after 30 ns;
datadig4 <= 8 , 6 after 40 ns;
datadig5 <= 7 , 9 after 50 ns;
End;
