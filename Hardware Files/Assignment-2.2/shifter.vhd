----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2022 10:32:31 AM
-- Design Name: 
-- Module Name: shifter - Behavioral
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

entity shifter is
  Port ( din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
--         clk : in STD_LOGIC ; 
--         en : in STD_LOGIC ; 
         dout : out STD_LOGIC_VECTOR( 15 downto 0) );
end shifter;

architecture Behavioral of shifter is

begin
--process(clk)
--begin 
--if( rising_edge(clk) and en = '1' ) then 
--    dout <= "00000" & din( 15 downto 5 ) ; 
--end if ; 
--if( rising_edge(clk) and en = '0' ) then 
--    dout <= din ; 
--end if ; 
--end process ; 
dout <= "00000" & din( 15 downto 5 ) ; 
end Behavioral;
