----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2022 03:55:53 PM
-- Design Name: 
-- Module Name: counter_1e8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_1e8 is
  Port ( clk : in STD_LOGIC ; 
       output : out STD_LOGIC );
end counter_1e8;

architecture Behavioral of counter_1e8 is
signal count : INTEGER range 0 to 100000000 := 0  ; 
begin

process(clk)
begin

    if ( rising_edge(clk)) then 
        count <= count + 1 ;
        if( count = 100000000 ) then 
            output <= '1' ; 
            count <= 0 ; 
        else 
            if ( count < 50000000 ) then 
            output <= '1' ; 
            else 
                output <= '0' ;
            end if ; 
             
         end if ;
    end if ; 


end process ; 
end Behavioral;
