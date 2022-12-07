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
  Port ( clk : in STD_LOGIC ; 
         seg : out STD_LOGIC_VECTOR( 6 downto 0 ) ; 
         an : out STD_LOGIC_VECTOR( 3 downto 0) );
end glue;

architecture Behavioral of glue is

component FSM is
  Port (  clk : in STD_LOGIC ; 
        ROM_addr : out STD_LOGIC_VECTOR(15 downto 0 ) ; 
        RAM1_we , RAM1_re , RAM2_we , RAM2_re : out STD_LOGIC ; 
        RAM1_addr  : out STD_LOGIC_VECTOR( 9 downto 0 ) ; 
        RAM2_addr : out STD_LOGIC_VECTOR( 6 downto 0 ) ; 
        reg1_re , reg1_we , reg2_re ,reg2_we , MAC_first, reg3_we, reg3_re , reg1_select , max_en  : out STD_LOGIC ;
        idx : out INTEGER ; 
        an : out STD_LOGIC_VECTOR( 3 downto 0 )  );
end component;

component ROM_MEM is 

generic (ADDR_WIDTH     : integer := 10;
         DATA_WIDTH     : integer := 8; 
         IMAGE_SIZE  : integer := 784;
         IMAGE_FILE_NAME : string :="/home/btech/cs1200336/Downloads/imgdata_digit4.mif" ; 
         WEIGHT_FILE_NAME : string := "/home/btech/cs1200336/Downloads/weights_bias.mif" ) ;
  Port (    addr : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
            clk : in STD_LOGIC ;
            dout : out STD_LOGIC_VECTOR( 7 downto 0 ) 
         );
end component ;

component RAM is
generic(
    DATA_WIDTH : integer := 16 ; 
    ADDR_WIDTH : integer := 8 ;
    RAM_SIZE : integer := 256  
) ; 
  Port ( 
    clk : in STD_LOGIC ; 
    we : in STD_LOGIC ;
    re : in STD_LOGIC ;
    addr : in STD_LOGIC_VECTOR( ADDR_WIDTH - 1 downto 0 ) ; 
    din : in STD_LOGIC_VECTOR( DATA_WIDTH - 1 downto 0 ) ; 
    dout : out STD_LOGIC_VECTOR( DATA_WIDTH -1 downto 0 )
    
   );
end component ;

component mac is
Port ( 
		din16: in  STD_LOGIC_VECTOR( 15 downto 0 ) ; 
		din8 : in  STD_LOGIC_VECTOR(7 downto 0);
		clk  : in  STD_LOGIC;
		en   : in  STD_LOGIC; -- enable sigal 
		res  : in  STD_LOGIC; -- first signal for accumulator ( when 1 stores mul value else accumulates)
		dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
     );
end component ;

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

component shifter is -- shifter clock and enable removed 
  Port ( din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
--         clk : in STD_LOGIC ; 
--         en : in STD_LOGIC ; 
         dout : out STD_LOGIC_VECTOR( 15 downto 0) );
end component ;
 
component comparator is
  Port ( 
         din : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
         dout : out STD_LOGIC_VECTOR( 15 downto 0 ) 
      );
end component;

component max is
  Port ( 
       clk : in STD_LOGIC ; 
       en : in STD_LOGIC ; 
       value : in STD_LOGIC_VECTOR( 15 downto 0 ) ; 
       idx : in integer ; 
       maxIdx : out integer 
   );
end component;

component display is
  Port ( value : in integer ; 
--         sw  :  in STD_LOGIC_VECTOR (3  downto  0 ) ;
         seg : out STD_LOGIC_VECTOR ( 6 downto 0 )  );
end component;


signal ROM_addr, RAM1_din, RAM1_dout, RAM2_din , RAM2_dout , reg1_din, reg1_dout , reg3_din , reg3_dout, MAC_din16, MAC_dout, relu_din, relu_dout, shifter_din, shifter_dout, value_to_be_checked : STD_LOGIC_VECTOR( 15 downto 0 ) ; 
signal RAM1_addr : STD_LOGIC_VECTOR( 9 downto 0 ) ; 
signal ROM_dout, reg2_din, reg2_dout , MAC_din8 : STD_LOGIC_VECTOR( 7 downto 0 ) ; 
signal RAM2_addr : STD_LOGIC_VECTOR( 6 downto 0 ) ;
signal RAM1_we, RAM1_re, RAM2_we , RAM2_re , reg1_we, reg1_re, reg2_re, reg2_we , reg3_we , reg3_re , MAC_en , MAC_first , shifter_enable  , reg1_select , max_en : STD_LOGIC ; 
signal maxIdx : integer range -1 to 10 ; 
signal idx : integer range 0 to 10 ; 
--signal seg : STD_LOGIC_VECTOR( 6 downto 0 ) ;
--signal an : STD_LOGIC_VECTOR( 3 downto 0 ) ; 
begin
--an <= "1110" ; 
ROM: ROM_MEM 
    generic map (
        ADDR_WIDTH    =>  10 , 
             DATA_WIDTH  => 8 , 
             IMAGE_SIZE  => 784 , 
             IMAGE_FILE_NAME => "/home/btech/cs1200336/Downloads/imgdata_digit7.mif" , 
             WEIGHT_FILE_NAME => "/home/btech/cs1200336/Downloads/weights_bias.mif"
    )
     port map (
    addr => ROM_addr , 
    clk => clk , 
    dout => ROM_dout 
) ;
RAM1_din <=  x"0001" when ( RAM1_addr = "1100010000" ) else  x"00" & ROM_dout   ; -- load activation 1 to RAM for bias 
RAM1: RAM 
            generic map ( 
                DATA_WIDTH => 16 , 
                ADDR_WIDTH => 10 , 
                RAM_SIZE => 1024 
              )
              port map (
                clk => clk , 
                we => RAM1_we , 
                re => RAM1_re , 
                addr => RAM1_addr , 
                din => RAM1_din, 
                dout => RAM1_dout 
              ) ; 

-- stores the activations for the intermediate layer 
RAM2_din <= x"0001" when ( RAM2_addr = "1000000") else reg3_dout ; -- load activation 1 at the end of RAM-2 for the bias 
RAM2: RAM
            generic map (
                DATA_WIDTH => 16 , 
                ADDR_WIDTH => 7 , 
                RAM_SIZE => 128
            )
            port map ( 
                clk => clk , 
                we => RAM2_we , 
                re => RAM2_re , 
                addr => RAM2_addr , 
                din => RAM2_din , 
                dout => RAM2_dout
            ) ; 
            
reg1_din <= RAM2_dout when ( reg1_select = '1' ) else RAM1_dout  ; -- image activations are stored in this register 
REGISTER1: generic_register  -- for activation to be sent to mac
            generic map(
                DATA_WIDTH => 16
            )
            port map(
                clk => clk , 
                we => reg1_we , 
                re => reg1_re , 
                din => reg1_din , 
                dout => reg1_dout 
            ) ;
reg2_din <= ROM_dout ; --  weights / biases are stored in this register
REGISTER2: generic_register  -- for weight to be sent to mac
            generic map(
                DATA_WIDTH => 8
            ) 
            port map (
                clk => clk , 
                we => reg2_we , 
                re => reg2_re , 
                din => reg2_din , 
                dout => reg2_dout 
            ) ; 
reg3_din <= shifter_dout ; -- register 3 stores output of MAC passed through ReLU and shifter 
REGISTER3: generic_register 
            generic map (
                DATA_WIDTH => 16 
            )
            port map (
                clk => clk , 
                we => reg3_we , 
                re => reg3_re , 
                din => reg3_din , 
                dout => reg3_dout  
            ) ; 
relu_din <= MAC_dout ; 
RELU: comparator port map (
    din => relu_din , 
    dout => relu_dout
) ; 

shifter_din <= relu_dout ; 
DIVIDER: shifter port map ( 
    din => shifter_din , 
    dout => shifter_dout 
--    clk => clk , 
--    en => shifter_enable
) ; 

MAC_din16 <= reg1_dout ; 
MAC_din8 <= reg2_dout ;
MAC_en <= '1' ; 
mulacc: mac port map (
        din16 => MAC_din16 , 
        din8 => MAC_din8 , 
        clk => clk , 
        en => MAC_en , 
        res => MAC_first ,
        dout => MAC_dout 
        ) ; 
value_to_be_checked  <= RAM2_dout ; 
MAXOUTPUT: max port map ( 
                clk => clk , 
                en => max_en , 
                value =>  value_to_be_checked ,
                idx => idx , 
                maxIdx => maxIdx
            ) ; 

DECODER: display port map (
        value => maxIdx , 
        seg => seg 
) ;     

Control:  FSM port map (
    clk => clk , 
    ROM_addr => ROM_addr , 
    RAM1_we => RAM1_we , 
    RAM1_re => RAM1_re , 
    RAM2_we => RAM2_we , 
    RAM2_re => RAM2_re , 
    RAM1_addr => RAM1_addr , 
    RAM2_addr => RAM2_addr , 
    reg1_we => reg1_we , reg1_re => reg1_re , 
    reg2_we => reg2_we , reg2_re  =>reg2_re , 
    MAC_first => MAC_first ,
    reg3_we => reg3_we , reg3_re => reg3_re , 
    reg1_select => reg1_select , 
    max_en => max_en , 
    idx => idx ,
    an => an
) ;  

end Behavioral;
