----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/29/2022 04:15:14 PM
-- Design Name: 
-- Module Name: dff - Behavioral
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

entity dff is
  Port (
    clk : in STD_LOGIC;
    d : in STD_LOGIC; -- input
    q : out STD_LOGIC ; --output 
    nq : out STD_LOGIC  --output complement 
);
end dff;

architecture Behavioral of dff is

signal x : STD_LOGIC ; 

begin
process(clk)
begin
if(rising_edge(clk)) then
x <= d;
end if;
end process;
q <= x;
nq <= not x ;
end Behavioral;
