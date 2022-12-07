----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/31/2022 11:00:03 AM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
  Port (
    clk : in STD_LOGIC;
    button : in STD_LOGIC;
    debounced_button : out STD_LOGIC
);
end debounce;

architecture Behavioral of debounce is

signal x,y : STD_LOGIC := '0';
signal nx, ny : STD_LOGIC := '1' ; 

component dff is
    Port (
          clk : in STD_LOGIC;
          d : in STD_LOGIC;
          q : out STD_LOGIC;
          nq : out STD_LOGIC 
      );
 end component;
begin
s1 : dff port map(clk => clk ,
                  d => button, 
                  q =>  x,
                  nq => nx);
s2 : dff port map(clk => clk, 
                   d => x, 
                   q => y,
                   nq => ny );
debounced_button <= x and ny ;
end Behavioral ;
