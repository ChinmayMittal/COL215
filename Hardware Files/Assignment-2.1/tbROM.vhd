----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2022 03:16:09 PM
-- Design Name: 
-- Module Name: tbrom - Behavioral
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

entity tbrom is
--  Port ( );
end tbrom;

architecture Behavioral of tbrom is
signal s1 : std_logic_vector(15 downto  0) := "0000000000010000";
signal s2 : std_logic_vector(7 downto  0);
signal clk : std_logic := '1';

--signal en : std_logic := '1';
component ROM_MEM is 
	Port (
            addr : in STD_LOGIC_VECTOR( 15 downto 0 ) ;
			clk : in STD_LOGIC;
            dout : out STD_LOGIC_VECTOR( 7 downto 0 )
        );
 end component;
--206-00010100
--261-00101000
--548-00111100
--784 - 00000001

begin
DUT1 : ROM_MEM port map (s1, clk, s2);
	clk <= not(clk) after 1 ps;
process
begin
	s1 <= x"00CE";
	wait for 10 ps ; 
	s1 <= x"0105";
	wait for 10 ps ; 
	s1 <= x"0224";
	wait for 10 ps ; 
	s1 <= x"0310";
	wait for 10 ps ; 
--wait ; 
end process ; 
end Behavioral;
