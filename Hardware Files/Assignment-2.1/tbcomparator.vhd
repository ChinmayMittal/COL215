----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2022 03:16:09 PM
-- Design Name: 
-- Module Name: tbcomparator - Behavioral
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

entity tbcomparator is
--  Port ( );
end tbcomparator;

architecture Behavioral of tbcomparator is
signal s1 : std_logic_vector(15 downto  0) := "0000000000010000";
signal s2 : std_logic_vector(15 downto  0);
component comparator is 
 Port ( 
        din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
        dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );
 end component;
     
begin
DUT1 : comparator port map (s1, s2);
process
begin
s1 <= "0000000000010000";
wait for 10 ps ; 
s1 <=  "1000000000100000" ; 
wait for 10 ps; 
s1 <= x"ABC0";
wait for 10 ps ; 
s1 <=  x"7BC0" ; 
wait for 10 ps; 
s1 <= x"1230";
wait for 10 ps ; 
s1 <=  x"A780" ; 
wait for 10 ps; 
end process ; 
end Behavioral;
