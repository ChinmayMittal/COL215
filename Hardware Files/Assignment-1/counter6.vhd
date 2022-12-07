----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2022 02:31:14 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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
use IEEE.NUMERIC_STD.ALL ;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter6 is
  Port ( clk : in STD_LOGIC ; 
  		np : in STD_LOGIC;
        reset: in STD_LOGIC;
  		digit: out STD_LOGIC_VECTOR(3 downto 0);
         output : out STD_LOGIC );
end counter6;

architecture Behavioral of counter6 is

signal count : INTEGER range 0 to 6 := 0  ; 

begin
process(clk, np, reset)
begin

    if ( rising_edge(clk) and (np = '1' ) ) then 
        count <= count + 1 ;
        if( count = 5 ) then 
            output <= '1' ; 
            count <= 0 ; 
        else 
            output <= '0' ;      
         end if ;
    end if ; 
    if( reset = '1' ) then
    count <= 0;
    end if;


end process ; 
digit <= std_logic_vector(to_unsigned(count, digit'length));
end Behavioral;