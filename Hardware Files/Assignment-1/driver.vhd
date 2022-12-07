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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity driver is
  Port (
  	clk : in STD_LOGIC;
    not_pause : in STD_LOGIC;
    reset: in STD_LOGIC;
    m : out STD_LOGIC_VECTOR(3 downto 0) ; 
    st : out STD_LOGIC_VECTOR(3 downto 0);
    su : out STD_LOGIC_VECTOR(3 downto 0);
    t : out STD_LOGIC_VECTOR(3 downto 0) );
end driver;

architecture Behavioral of driver is

signal to_t, to_su, to_st, to_m, to_nobody : STD_LOGIC; 

component counter_1e7 is
Port ( clk : in STD_LOGIC ; 
       output : out STD_LOGIC );
end component;
component counter10 is
Port ( clk : in STD_LOGIC ; 
  		np : in STD_LOGIC;
        reset: in STD_LOGIC;
  		digit: out STD_LOGIC_VECTOR(3 downto 0);
         output : out STD_LOGIC );
end component;
component counter6 is
Port ( clk : in STD_LOGIC ; 
  		np : in STD_LOGIC;
        reset: in STD_LOGIC;
  		digit: out STD_LOGIC_VECTOR(3 downto 0);
         output : out STD_LOGIC );
end component;

begin
-- Delay of atmost tenth of a second
x1 : counter_1e7 port map(
clk => clk,
output => to_t
);
t_comp : counter10 port map(
   clk => to_t,
   np => not_pause ,
   reset => reset,
   digit => t,
   output => to_su
);
su_comp : counter10 port map(
   clk => to_su,
   np => not_pause ,
   reset => reset,
   digit => su,
   output => to_st
);
st_comp : counter6 port map(
   clk => to_st,
   np => not_pause ,
   reset => reset,
   digit => st,
   output => to_m
);
m_comp : counter10 port map(
   clk => to_m,
   np => not_pause,
   reset => reset,
   digit => m ,
   output => to_nobody
);

end Behavioral ; 