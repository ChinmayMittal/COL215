----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/29/2022 02:32:56 PM
-- Design Name: 
-- Module Name: buttons - Behavioral
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

entity buttons is
  Port ( btnL : in STD_LOGIC ;
         btnC : in STD_LOGIC ; 
         btnR : in STD_LOGIC ; 
         clk : in STD_LOGIC ; 
         not_pause : out STD_LOGIC ; 
         reset : out STD_LOGIC );
end buttons;

architecture Behavioral of buttons is
signal np : STD_LOGIC := '0' ; 
signal res : STD_LOGIC := '0' ; 
signal slow_clock : STD_LOGIC ; 
signal debounced_btnL, debounced_btnC, debounced_btnR  : STD_LOGIC ; 
component debounce is 
  Port (
    clk : in STD_LOGIC;
    button : in STD_LOGIC;
    debounced_button : out STD_LOGIC
    );
end component ; 

component counter_1e5 is
  Port ( clk : in STD_LOGIC ; 
         output : out STD_LOGIC );
end component ;


begin


sc : counter_1e5 port map(
    clk => clk , 
    output => slow_clock
) ; 

db1 : debounce port map (
    clk => slow_clock, 
    button => btnL , 
    debounced_button => debounced_btnL 
) ; 

db2 : debounce port map (
    clk => slow_clock , 
    button => btnC , 
    debounced_button => debounced_btnC

) ;

db3 : debounce port map (
    clk => slow_clock , 
    button => btnR , 
    debounced_button => debounced_btnR
) ;  


 
 
process(clk)
begin 
if( rising_edge(clk) ) then 
    if( debounced_btnL = '1' ) then 
        reset <= '0' ; 
        np <= '1' ; 
    end if ; 
    if( debounced_btnC = '1' ) then 
        np <= '0' ; 
     end if ; 
     if( debounced_btnR = '1' ) then 
        reset <= '1' ;
        np <= '0' ;  
      end if ;
     
end if ;



end process ; 

not_pause <= np ; 
end Behavioral;
