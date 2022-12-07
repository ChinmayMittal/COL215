----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2022 12:00:32 PM
-- Design Name: 
-- Module Name: generic_register - Behavioral
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

entity generic_register is
  Generic(
    DATA_WIDTH : integer := 16 
  );
  Port ( 
    clk : in STD_LOGIC ; 
    we : in STD_LOGIC ;
    re : in STD_LOGIC ; 
    din : in STD_LOGIC_VECTOR( DATA_WIDTH - 1 downto 0 ) ; 
    dout : out STD_LOGIC_VECTOR( DATA_WIDTH -1 downto 0 )
  );
end generic_register;

architecture Behavioral of generic_register is
signal store, outputStore : STD_LOGIC_VECTOR( DATA_WIDTH - 1 downto 0 ) ; 
begin
--dout <= outputStore ; 
dout <= store ; -- making the register asynchronour read, re has no effect 
process( clk )
begin 
if( rising_edge(clk) and we = '1' ) then 
    store <= din ; 
end if ; 
if( rising_edge(clk) and re = '1' ) then 
    outputStore <= store ; 
end if ; 
end process ;

end Behavioral;
