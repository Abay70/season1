Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Entity ALU_Full is
 port (
        Sel     :  in  std_logic_vector(3  downto 0);
        DRin    :  in  std_logic_vector(15 downto 0);
        Acin    :  in  std_logic_vector(15 downto 0);
        ALUout  :  out std_logic_vector(15 downto 0);
        cin     :  in  std_logic                    ;
        inpr    :  in  std_logic_vector(7 downto 0) ;
        FGI     :  out std_logic                    ;
        Cout    :  out std_logic                   );
End Entity;
Architecture ALU_Full_behave of ALU_Full is
signal S_ALu  : std_logic_vector(16 downto 0)                     ;
signal W      : std_logic_vector(15 downto 0):="0000000000000001" ;
signal Q      : std_logic_vector(15 downto 0):="1111111111111111" ;
signal S_inpr : std_logic_vector(15 downto 0)                     ;
Begin
S_inpr <= "00000000" & inpr;

    process(Sel , DRin , Acin , cin , S_inpr )
            begin
               case Sel is
                   when "0000" =>
                          if cin = '0' then
                               ALUout <= S_inpr                 ;
                               FGI    <='0'                     ; 
                          else
                               if Acin = Q then
                                  Cout   <= '1'                 ;
                                  ALUout <= (others => '0')     ;
                               else 
                               ALUout <= Acin + W               ;
                               end if;
                          end if;
                   when "0001" =>
                          if cin = '0' then
                               S_ALU <="00000000000000000"      ;
                               S_ALU <= DRin + Acin             ;
                               ALUout   <= S_ALU(15 downto 0)   ;
                               Cout     <= S_ALU(16)            ;
                          else
                               S_ALU <="00000000000000000"      ;
                               S_ALU <= DRin + Acin + W         ;
                               ALUout   <= S_ALU(15 downto 0)   ;
                               Cout     <= S_ALU(16)            ;
                          end if;
                   when "0010" =>
                          if cin = '0' then
                               ALUout <= (not DRin) + Acin      ;
                          else
                               ALUout <= (not DRin) + Acin + W  ;
                          end if;
                   when "0011" =>
                          if cin = '0' then
                               ALUout <= Acin - w               ;
                          else
                               ALUout <= DRin                   ;
                          end if;
                   when "0100" =>
                               ALUout <= Acin and DRin          ;
                   when "0101" =>
                               ALUout <= Acin or DRin           ;
                   when "0110" =>
                               ALUout <= Acin xor DRin          ;
                   when "0111" =>
                               ALUout <= not Acin               ;
                   when "1000"|"1001"|"1010"|"1011" =>
                               ALUout <= '0' & Acin(15 downto 1);
                   when "1100"|"1101"|"1110"|"1111" => 
                               ALUout <= Acin(14 downto 0) & '0';
                               Cout   <= Acin(15)               ;
                   when others =>
                               ALUout <= (others => '0')        ;
               end case;
    end process;

End Architecture;