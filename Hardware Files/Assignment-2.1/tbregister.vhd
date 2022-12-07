----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/17/2022 01:02:09 AM
-- Design Name: 
-- Module Name: tbregister - Behavioral
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

entity tbregister is
--  Port ( );
end tbregister;

architecture Behavioral of tbregister is

component generic_register is 
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
end component;

signal clk : STD_LOGIC := '0' ;
signal we : STD_LOGIC := '1' ; 
signal re : STD_LOGIC  := '1' ; 
signal din, dout : STD_LOGIC_VECTOR( 15 downto 0 ) ;  
 
begin
clk <= not(clk) after 1 ps ;
DUT : generic_register port map(
    clk => clk , 
    we => we,
    re => re, 
    din => din , 
    dout => dout 
);
process 
begin
we <= '0' ;
wait for 10 ps ; 
we <= '1' ; 
din <= x"AB38" ; 
wait for 10 ps ; 
re <= '0' ; 
wait for 10 ps ; 
din <= x"1100" ; 
wait for 10 ps ;
re <= '1' ; 

wait for 10 ps ; 
we <= '1' ; 
din <= x"0011" ; 
wait for 10 ps ; 
we <= '0' ; 
din <= x"ff98" ; 
wait for 10 ps ; 
--we <= '0' ; 
--wait for 10 ps ; 
we <= '1' ; 
wait for 10 ps ; 
wait ;
end process ; 

end Behavioral;
