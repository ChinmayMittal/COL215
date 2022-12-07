----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2022 10:42:00 AM
-- Design Name: 
-- Module Name: ROM_MEM - Behavioral
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
use STD.TEXTIO.ALL ; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_MEM is
generic (ADDR_WIDTH     : integer := 10;
         DATA_WIDTH     : integer := 8; 
         IMAGE_SIZE  : integer := 784;
         IMAGE_FILE_NAME : string :="/home/btech/cs1200336/Downloads/imgdata_digit7.mif" ; 
         WEIGHT_FILE_NAME : string := "/home/btech/cs1200336/Downloads/weights_bias.mif" ) ;
  Port ( 
			addr : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
			clk : in STD_LOGIC ;
            dout : out STD_LOGIC_VECTOR( 7 downto 0 ) 
        );
end ROM_MEM;

architecture Behavioral of ROM_MEM is
TYPE mem_type IS ARRAY(0 TO 51673 ) OF std_logic_vector((DATA_WIDTH-1) DOWNTO 0);
impure function init_mem( img_mif_filename : in string ; wanb_mif_filename : in string  ) return mem_type is
    file img_mif_file : text open read_mode is img_mif_filename ; 
    file wanb_mif_file : text open read_mode is wanb_mif_filename ; 
    variable mif_line : line ; 
    variable temp_bv : bit_vector( DATA_WIDTH - 1 downto 0 ) ; 
    variable temp_mem : mem_type ; 
begin 
    for i in 0 to 783 loop 
        readline( img_mif_file, mif_line ) ; 
        read( mif_line, temp_bv ) ; 
        temp_mem(i) := to_stdlogicvector( temp_bv) ; 
    end loop ;
    for i in 784 to 51673 loop
        readline( wanb_mif_file, mif_line) ; 
        read( mif_line ,temp_bv ) ;
        temp_mem(i) := to_stdlogicvector( temp_bv ) ;
    end loop ; 
    return temp_mem ; 
end function ;  
signal rom_block : mem_type := init_mem( IMAGE_FILE_NAME, WEIGHT_FILE_NAME ) ; 
signal val : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			val <= rom_block( to_integer( unsigned(addr)) ) ; 
		end if;
	end process;
	dout <= val;
end Behavioral;
