----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2022 11:09:41 AM
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
  Port ( sw : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         led: out STD_LOGIC_VECTOR( 7 downto 0 ) );
end glue;

architecture Behavioral of glue is

component ROM_MEM is 

generic (ADDR_WIDTH     : integer := 10;
         DATA_WIDTH     : integer := 8; 
         IMAGE_SIZE  : integer := 784;
         IMAGE_FILE_NAME : string :="/home/btech/cs1200336/Downloads/imgdata_digit7.mif" ; 
         WEIGHT_FILE_NAME : string := "/home/btech/cs1200336/Downloads/weights_bias.mif" ) ;
  Port ( 
            addr : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
            dout : out STD_LOGIC_VECTOR( 7 downto 0 ) 
        );
end component ; 
signal addr : STD_LOGIC_VECTOR( 15 downto 0 ) ; 
signal dout : STD_LOGIC_VECTOR( 7 downto 0 ) ; 
begin
ROM: ROM_MEM port map (
    addr => sw , 
    dout => led
) ; 

end Behavioral;
