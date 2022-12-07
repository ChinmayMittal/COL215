----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2022 04:32:16 PM
-- Design Name: 
-- Module Name: display - Behavioral
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


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
  Port ( value : in integer ; 
--         sw  :  in STD_LOGIC_VECTOR (3  downto  0 ) ;
         seg : out STD_LOGIC_VECTOR ( 6 downto 0 )  );
end display;

architecture Behavioral of display is

signal sw : STD_LOGIC_VECTOR( 3 downto 0 )  ;     
begin
    sw <= STD_LOGIC_VECTOR( to_unsigned( value, 4 )) ; 
    seg(6) <= (not(sw(3)) and not(sw(2)) and not(sw(1)) and sw(0)) or (sw(2) and not(sw(1)) and not(sw(0)) );
    seg(5) <= (sw(2) and not(sw(1)) and sw(0)) or (sw(2) and sw(1) and not(sw(0)));
    seg(4) <= not(sw(2)) and sw(1) and not(sw(0));
    seg(3) <= (not(sw(3)) and not(sw(2)) and not(sw(1)) and sw(0)) or (sw(2) and not(sw(1)) and not(sw(0))) or (sw(2) and sw(1) and sw(0));
    seg(2) <= (sw(0)) or (sw(2) and not(sw(1)));
    seg(1) <= (not(sw(3)) and not(sw(2)) and sw(0)) or (not(sw(2)) and sw(1) ) or (sw(1) and sw(0));
    seg(0) <= (not(sw(3)) and not(sw(2)) and not(sw(1)) ) or (sw(2) and sw(1) and sw(0));
        


end Behavioral;