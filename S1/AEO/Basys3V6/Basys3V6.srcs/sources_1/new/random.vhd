----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2018 09:56:17 AM
-- Design Name: 
-- Module Name: random - Behavioral
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

entity random is
    generic ( width : integer :=  32 ); 
    port (
        clk , reset : in std_logic;
        enable : in std_logic;
        random_num : out std_logic_vector (width-1 downto 0)   --output vector            
    );
end random;

architecture Behavioral of random is
    signal r : std_logic_vector(31 downto 0) := x"80000000";
begin

process(clk)
    begin
	   if ( clk'event and clk = '1' ) then
	       if (reset = '1') then
	           r <= x"80000000";
	       elsif(enable = '1') then
	           r(30 downto 0) <= r(31 downto 1);
	           r(31) <= (((r(0) xor r(2)) xor r(3)) xor r(4));
	       end if;
           random_num <= r;
	   end if;
	end process;

end Behavioral;