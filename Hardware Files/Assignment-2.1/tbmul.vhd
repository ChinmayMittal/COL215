-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
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

entity tbmul is
--  Port ( );
end tbmul;

architecture Behavioral of tbmul is
signal s1 : std_logic_vector(15 downto 0) := "0000000000010000";
signal s0 : std_logic_vector(7 downto 0) := x"b9" ; 
signal s2 : std_logic_vector(15 downto 0);
signal en : std_logic := '1';
signal clk : std_logic := '1';
signal fir : std_logic := '0';
component mul is 
Port ( 
		din16: in  STD_LOGIC_VECTOR( 15 downto 0 ) ; 
		din8 : in  STD_LOGIC_VECTOR(7 downto 0);
		dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );
end component;

begin
s0 <= not(s0) after 15 ns;
s1(14) <= not(s1(14)) after 4 ps;
DUT1 : mul port map (s1, s0, s2); 

end Behavioral;
