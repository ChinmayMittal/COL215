
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mac is
Port ( 
		din16: in  STD_LOGIC_VECTOR( 15 downto 0 ) ; 
		din8 : in  STD_LOGIC_VECTOR(7 downto 0);
		clk  : in  STD_LOGIC;
		en   : in  STD_LOGIC;
		res  : in  STD_LOGIC;
		dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );
end mac;

architecture Behavioral of mac is

	component mul is
	Port ( 
		din16: in  STD_LOGIC_VECTOR( 15 downto 0 ) ; 
		din8 : in  STD_LOGIC_VECTOR(7 downto 0);
		dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );

	end component;
	component acc is
	Port ( 
         din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         clk : in STD_LOGIC;
         en : in STD_LOGIC;
         fir : in STD_LOGIC;
         dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
      );
	end component;
	signal mulout : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
--signal val : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin
	DUT0: mul port map (din16, din8, mulout);
	DUT1 : acc port map  (mulout, clk, en, res, dout);
end Behavioral;


