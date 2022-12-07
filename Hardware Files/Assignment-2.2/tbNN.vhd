----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 13:31:46
-- Design Name: 
-- Module Name: tbNN - Behavioral
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

entity tbNN is
--  Port ( );
end tbNN;

architecture Behavioral of tbNN is
component glue is
  Port ( clk : in STD_LOGIC ; 
         seg : out STD_LOGIC_VECTOR( 6 downto 0 ) ; 
         an : out STD_LOGIC_VECTOR( 3 downto 0) );
end component;
signal clk : STD_LOGIC := '1' ; 
signal seg : STD_LOGIC_VECTOR( 6 downto 0 ) ; 
signal an : STD_LOGIC_VECTOR( 3 downto 0 ) ; 
begin
clk <= not clk after 1 ps ; 
DUT : glue port map ( clk => clk , seg => seg , an => an  ) ;  

end Behavioral;
