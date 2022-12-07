----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2022 04:20:01 PM
-- Design Name: 
-- Module Name: timing - Behavioral
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

entity timing is
  Port ( clkk : in STD_LOGIC ; 
          an : out STD_LOGIC_VECTOR( 3 downto  0 ) ; 
           mux_sel : out STD_LOGIC_VECTOR ( 1 downto 0 ) ; 
           dp  : out STD_LOGIC );
end timing;

architecture Behavioral of timing is
signal count : INTEGER range 0 to 4 := 0 ; 
begin
process(clkk)
begin 
    if ( rising_edge(clkk)) then 
    count <= count + 1 ;
    if( count = 3 ) then 
        count <= 0 ;
     end if ;  
     
     case count is 
     when 0 =>
        mux_sel <= "00" ; 
        an <= "0111" ; 
        dp <= '0' ; 
     when 1 => 
        mux_sel <= "01" ;
        an <= "1011" ; 
        dp <= '1' ; 
     when 2 => 
        mux_sel <= "10" ; 
        an <= "1101" ; 
        dp <= '0' ; 
     when 3 => 
        mux_sel <= "11" ; 
        an <= "1110" ; 
        dp <= '1' ; 
     when others => 
        mux_sel <= "00" ; 
        an <= "1111" ; 
        dp <= '1' ; 
     end case  ; 
     
end if ; 
end process ; 
end Behavioral;
