----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/29/2022 02:02:53 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
 Port ( m : in STD_LOGIC_VECTOR(3 downto 0) ; 
        st : in STD_LOGIC_VECTOR(3 downto 0);
        su : in STD_LOGIC_VECTOR(3 downto 0);
        t : in STD_LOGIC_VECTOR(3 downto 0);
        mux_sel : in STD_LOGIC_VECTOR(1 downto 0);
        dec_in : out STD_LOGIC_VECTOR(3 downto 0));
end mux;

architecture Behavioral of mux is

begin

with mux_sel select dec_in <=
     m when "00",
	 st	when "01",
     su when "10",
     t when "11",
     "0000" when others;
   

end Behavioral;
