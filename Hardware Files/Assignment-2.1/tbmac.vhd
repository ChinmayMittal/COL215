
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tbmac is
--  Port ( );
end tbmac;

architecture Behavioral of tbmac is
signal s1 : std_logic_vector(15 downto 0) := "0000000000010000";
signal s2 : std_logic_vector(7 downto 0) := x"79";
signal s3 : std_logic_vector(15 downto 0);
signal en : std_logic := '1';
signal clk : std_logic := '1';
signal fir : std_logic := '0';
component mac is 
Port ( 
		din16: in  STD_LOGIC_VECTOR( 15 downto 0 ) ; 
		din8 : in  STD_LOGIC_VECTOR(7 downto 0);
		clk  : in  STD_LOGIC;
		en   : in  STD_LOGIC;
		res  : in  STD_LOGIC;
		dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );
end component;

begin
DUT1 : mac port map (s1, s2, clk, en, fir, s3);
clk <= not(clk) after 1 ps;
en <= not(en) after 3 ps;
fir <= not(fir) after 10 ps;
process 
begin

s1 <= x"AB84";
s2 <= x"BC";
wait for 1 ps;
s1 <= x"2B24";
s2 <= x"6A";
wait for 1 ps;
s1 <= x"5B84";
s2 <= x"39";
wait for 1 ps;



end process;

end Behavioral;
