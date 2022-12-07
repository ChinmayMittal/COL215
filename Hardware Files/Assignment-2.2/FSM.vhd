library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
  Port (  clk : in STD_LOGIC ; 
      ROM_addr : out STD_LOGIC_VECTOR(15 downto 0 ) ; 
      RAM1_we , RAM1_re , RAM2_we , RAM2_re : out STD_LOGIC ; 
      RAM1_addr  : out STD_LOGIC_VECTOR( 9 downto 0 ) ; 
      RAM2_addr : out STD_LOGIC_VECTOR( 6 downto 0 ) ; 
      reg1_re , reg1_we , reg2_re ,reg2_we , MAC_first, reg3_we, reg3_re , reg1_select , max_en  : out STD_LOGIC ;
      idx : out INTEGER ; 
      an : out STD_LOGIC_VECTOR( 3 downto 0 )   );
end FSM;

architecture Behavioral of FSM is
signal state : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal count0 : INTEGER range 0 to 786 := 0 ; 
signal count1 : INTEGER range 0 to 50496 := 0 ; -- 789 * 64 ( every intermediate neuron takes some extra cycles )
signal count2 : INTEGER range 0 to 690 := 0; -- 68*10
signal count3 : INTEGER range 0 to 11 := 0 ; 
signal input_idx : INTEGER range -1 to 1000 := 0 ; 
signal output_idx : INTEGER range 0 to 100 := 0 ;  
begin
process(clk)

begin 
--ROM_addr <= x"0000" ; 
if( rising_edge(clk)) then 
 if (state = "000") then
    an <= "1111" ; 
     count0 <= count0 + 1;
     ROM_addr <= std_logic_vector( to_unsigned( count0, 16 )) ; 
     RAM1_we <= '1' ; 
     RAM1_addr <= std_logic_vector( to_unsigned( count0-1, 10 )) ; 
     if(count0 = 786) then
          state <= "001";
          RAM1_we <= '0' ; -- no longer writing to RAM
          RAM1_re <= '1' ; -- reading from RAM from next state
          RAM1_addr <= "0000000000" ; -- for next state 
          ROM_addr <= x"0310" ; -- first weight from ROM for first layer 
          reg1_we <= '1' ; 
          reg1_re <= '1' ; 
          reg2_we <= '1' ; 
          reg2_re <= '1' ; 
          reg1_select <= '0' ; 
     end if;
end if;
if (state = "001") then 
     count1 <= count1 + 1;
     input_idx <= input_idx + 1 ; 
     RAM2_addr <= std_logic_vector( to_unsigned( output_idx, 7)) ; -- address to store the intermediate activation in RAM-2 
     RAM1_addr <= std_logic_vector( to_unsigned( input_idx+1, 10 )) ; -- for image activation / 1 from RAM-1 
     ROM_addr <= std_logic_vector( to_unsigned(  output_idx*784 + (input_idx+1 )  + 1 + 783 ,16))   ; -- weight/bias from ROM     
    if( input_idx = 1 ) then -- after 2 cycle delay the first multiplication value will be available and we need to ensure that it is not accumulated
        MAC_first <= '1' ; 
    else 
        MAC_first <= '0' ; 
    end if ; 
    if( input_idx = 786 ) then 
        reg3_we <= '1' ; 
    else 
        reg3_we <= '0' ;  
    end if ; 
    if( input_idx = 783 ) then 
        -- next weight has to be a bias
        ROM_addr <= std_logic_vector( to_unsigned( 784*64 + 783 + output_idx + 1 ,16)) ;
    end if ; 
    if( input_idx = 787 ) then 
        RAM2_we <= '1' ; 
    else
        RAM2_we <= '0' ; 
    end if ;  
    if( input_idx = 788 ) then --  changed from 784 weight a few cycles to complete the computations of this particular neuron  
        input_idx <= 0 ; 
        RAM1_addr <= "0000000000" ;                   
        output_idx <= output_idx+1 ; 
        ROM_addr <= std_logic_vector( to_unsigned(  (output_idx+1)*784 + (0)  + 1 + 783 ,16))   ; -- first weight address for next neuron 
    end if ; 
        if(count1 = 50495) then
          state <= "011"; -- intermediate state for writing 1 to RAM2 for handling bias
          input_idx <= 0 ; 
          output_idx <= 0 ; 
          RAM2_addr <= "1000000" ; -- address to store activation-1 
          RAM2_we <= '1' ; 
        end if;
 end if;
 if(state = "011" ) then 
    state <= "010" ; 
    RAM2_we <= '0' ; 
    RAM2_re <= '1' ; 
    reg1_select <= '1' ; -- register 1 will now get value from RAM-2 instead of RAM-1
    RAM2_addr <= "0000000" ; -- first value for intermediate activation from RAM-2 
    ROM_addr <= std_logic_vector( to_unsigned( 783 + 785*64 + (0) + 1  , 16)) ; -- first weight value for second layer
 end if ; 
 if (state = "010") then
     count2 <= count2 + 1;
     input_idx <= input_idx + 1 ; 
     ROM_addr <= std_logic_vector( to_unsigned( 783 + 785*64 + output_idx*64 + ( input_idx + 1 ) + 1 , 16 ) ) ; 
     RAM2_addr <= std_logic_vector ( to_unsigned ( input_idx+1 , 7 ) )  ;
     if( input_idx = 1 ) then 
          MAC_first <= '1' ; 
     else 
          MAC_first <= '0' ; 
     end if ;      
     if( input_idx = 63 ) then 
        ROM_addr <= std_logic_vector( to_unsigned(  783 + 785*64 + 64*10 + (output_idx) + 1 , 16)) ; -- next weight should be a bias 
     end if ;     
    if( input_idx = 66 ) then 
         reg3_we <= '1' ; 
     else 
         reg3_we <= '0' ;  
     end if ;    
    if( input_idx = 67 ) then 
         RAM2_we <= '1' ; 
         RAM2_addr <= std_logic_vector ( to_unsigned ( 65 + output_idx  , 7 ) )  ;
     else
         RAM2_we <= '0' ; 
     end if ;          
     if( input_idx = 68 ) then -- some extra results to do computations  
         input_idx <= 0 ; 
         RAM2_addr <= "0000000" ; -- go back to the first activation in the RAM-2
         ROM_addr <= std_logic_vector( to_unsigned( 783 + ( 785*64) + 1 + (output_idx+1)*64, 16 )) ; 
         output_idx <= output_idx+1 ; 
     end if ; 
 
 
     if(count2 = 689) then
          state <= "111";
          RAM2_addr <= std_logic_vector( to_unsigned( 65 , 7) ) ; -- first value for next state 
     end if;
end if;
if(state = "111" ) then 
max_en <= '1' ; 
count3 <= count3 + 1 ; 
idx <= count3  ;
RAM2_addr <= std_logic_vector( to_unsigned( 64 + count3 + 2, 7 )) ;  
if( count3 = 10 ) then 
    state <= "110" ;
    an <= "1110" ;  
    max_en <= '0' ; 
end if ; 
end if ;    
end if ; 
end process ; 

end Behavioral;