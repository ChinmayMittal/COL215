
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity acc is
  Port ( 
         din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         clk : in STD_LOGIC;
         en : in STD_LOGIC;
         fir : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
      );
end acc;

architecture Behavioral of acc is
signal val : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin

process(clk)
begin
if(rising_edge(clk)) then
if(en = '1') then
	if(fir = '1') then
    	val <= din;
	else
    	val <= std_logic_vector(to_signed(to_integer(signed(val)) + to_integer(signed(din)), val'length));
    end if;
end if;
end if;
end process;
dout <= val;

end Behavioral;
