----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/22/2022 03:54:52 PM
-- Design Name: 
-- Module Name: glue - Behavioral
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

entity glue is
  Port ( clk : in STD_LOGIC ;
         btnL : in STD_LOGIC ; 
         btnC : in STD_LOGIC ;
         btnR : in STD_LOGIC ; 
         an : out STD_LOGIC_VECTOR ( 3 downto 0 ) ;
         seg : out STD_LOGIC_VECTOR ( 6 downto 0 ) ; 
         dp : out STD_LOGIC  ; 
         D : out STD_LOGIC );
end glue;

architecture Behavioral of glue is 

component counter_1e5 is
    Port ( clk : in STD_LOGIC ; 
            output : out STD_LOGIC ) ; 
end component ; 

component decoder is 
  Port ( sw  :  in STD_LOGIC_VECTOR (3  downto  0 ) ;
       seg : out STD_LOGIC_VECTOR ( 6 downto 0 ) );
 end component ; 
 
component timing is
  Port ( clkk : in STD_LOGIC ; 
         an : out STD_LOGIC_VECTOR( 3 downto  0 ) ; 
         mux_sel : out STD_LOGIC_VECTOR ( 1 downto 0 ) ; 
         dp : out STD_LOGIC );
end component ;

component driver is
  Port (
  	clk : in STD_LOGIC;
    not_pause : in STD_LOGIC;
    reset: in STD_LOGIC;
    m : out STD_LOGIC_VECTOR(3 downto 0) ; 
    st : out STD_LOGIC_VECTOR(3 downto 0);
    su : out STD_LOGIC_VECTOR(3 downto 0);
    t : out STD_LOGIC_VECTOR(3 downto 0) );
end component;

component mux is
 Port ( m : in STD_LOGIC_VECTOR(3 downto 0) ; 
        st : in STD_LOGIC_VECTOR(3 downto 0);
        su : in STD_LOGIC_VECTOR(3 downto 0);
        t : in STD_LOGIC_VECTOR(3 downto 0);
        mux_sel : in STD_LOGIC_VECTOR(1 downto 0);
        dec_in : out STD_LOGIC_VECTOR(3 downto 0));
end component ;

component buttons is

  Port ( btnL : in STD_LOGIC ;
         btnC : in STD_LOGIC ; 
         btnR : in STD_LOGIC ; 
         clk : in STD_LOGIC ; 
         not_pause : out STD_LOGIC ; 
         reset : out STD_LOGIC );
         
         
end component ; 

signal mux_sel : STD_LOGIC_VECTOR( 1 downto  0 ) ; 
signal clkk : STD_LOGIC ; 
signal reset : STD_LOGIC  ; 
signal not_pause : STD_LOGIC ; 
signal m, st, su, t, dec_in: STD_LOGIC_VECTOR(3 downto 0); 

begin
 
 
D<= not_pause ; 

x1 : counter_1e5 port map(
    clk => clk , 
    output => clkk
) ; 

x2 : decoder port map(
    sw => dec_in , 
    seg => seg
) ; 

x3 : timing port map (
    clkk => clkk  , 
    an => an , 
    mux_sel => mux_sel , 
    dp => dp
) ; 

x4 : driver port map (

	clk => clk,
	not_pause => not_pause,
    reset => reset,
    m => m, 
    st => st,
    su => su,
    t => t
) ; 

x5 : mux port map(
	m => m,
    st => st,
    su => su,
    t => t,
    mux_sel => mux_sel,
    dec_in => dec_in
);

x6 :  buttons port map (
    btnL => btnL , 
    btnC =>  btnC , 
    btnR => btnR , 
    clk => clk , 
    not_pause => not_pause , 
    reset => reset 
) ; 

end Behavioral;
