----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2022 03:16:09 PM
-- Design Name: 
-- Module Name: tbshifter - Behavioral
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

entity tbshifter is
--  Port ( );
end tbshifter;

architecture Behavioral of tbshifter is
signal s1 : std_logic_vector(15 downto  0) := "0000000000010000";
signal s2 : std_logic_vector(15 downto  0);
signal clk : std_logic := '1';
signal en : std_logic := '1';
component shifter is 
	Port ( din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         clk : in STD_LOGIC ; 
         en : in STD_LOGIC ; 
         dout : out STD_LOGIC_VECTOR( 15 downto 0) );
 end component;
     
begin
DUT1 : shifter port map (s1, clk, en, s2);
clk <= not(clk) after 1 ps;
process
begin

s1 <= "0000000000010100";
wait for 10 ps ; 
s1 <=  "1000111000100000" ; 
wait for 10 ps;
s1 <= x"abcd" ;
wait for 10 ps ;
s1 <= x"dbca" ;
wait for 10 ps ; 
en <= '0' ; 
s1 <= x"1111" ; 
wait for 10 ps ; 
end process ; 
end Behavioral;
