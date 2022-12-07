----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2022 03:24:47 PM
-- Design Name: 
-- Module Name: max - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity max is
  Port ( 
       clk : in STD_LOGIC ; 
       en : in STD_LOGIC ; 
       value : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
       idx : in integer ; 
       maxIdx : out integer 
   );
end max;

architecture Behavioral of max is
signal maxValue : STD_LOGIC_VECTOR( 15 downto 0 ) := x"0000" ; 
signal maxIdxStore : integer range -1 to 10 := -1 ; 
begin
maxIdx <= maxIdxStore ; 
process(clk)
begin 
if( rising_edge(clk)) then 
    if( en = '1' ) then 
        if( to_integer( signed( value)) > to_integer( signed( maxValue))) then 
            maxIdxStore <= idx ; 
            maxValue <= value ; 
        end if ; 
    end if ;
end if ;
end process ; 

end Behavioral;
