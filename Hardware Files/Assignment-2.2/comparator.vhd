----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2022 03:07:42 PM
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
  Port ( 
         din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
      );
end comparator;

architecture Behavioral of comparator is

begin

with din(15) select dout <=
    din when '0', 
    x"0000" when '1' ,
    x"0000" when others ; 


end Behavioral;
