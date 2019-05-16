----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2018 04:27:14 PM
-- Design Name: 
-- Module Name: digicode_chenillard - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digicode_chenillard is
    Port (clk : IN STD_LOGIC;
       sw : IN STD_LOGIC_VECTOR(7 downto 0);
       btnR, btnD, btnL, btnU, btnC : IN STD_LOGIC;
       led : OUT STD_LOGIC_VECTOR(7 downto 0));
end digicode_chenillard;

architecture Behavioral of digicode_chenillard is

signal led_s : STD_LOGIC_VECTOR(1 downto 0);
signal led_chenillard_s : STD_LOGIC_VECTOR(15 downto 0);
signal clock_4Hz : STD_LOGIC;
signal reset: std_logic := '1';
signal count: integer := 0; 

component digicode
    Port (clk : IN STD_LOGIC;
       sw : IN STD_LOGIC_VECTOR(7 downto 0);
       btnR, btnD, btnL, btnU, btnC : IN STD_LOGIC;
       led : OUT STD_LOGIC_VECTOR(1 downto 0));
end component;

component chenillard
    Port ( btnC, btnU, btnL, btnR, btnD : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC);
end component;

component clk_div
    Port ( clk : in  STD_LOGIC;
           clk_4hz : inout STD_LOGIC := '0');
end component;


begin

    cmp_digicode : digicode port map (clk => clk, sw => sw, btnR => btnR, btnD => btnD, btnL => btnL, btnU => btnU, btnC => btnC, led => led_s);
    cmp_chenillard : chenillard port map (btnR => btnR, btnD => btnD, btnL => btnL, btnU => btnU, btnC => btnC, sw => "0000000010000000", led => led_chenillard_s, clk => clk);
    
    cmp_clock : clk_div PORT MAP(clk => clk, clk_4hz => clock_4Hz);

    process(clock_4Hz, led_s, btnC)
    begin
    
    if (btnC = '1') then
        reset <= '1';
        count <= 0;
    end if;
    
    if(clock_4hz'event and clock_4hz = '1') then
        if(led_s = "10" and reset='1') then
            led <= led_chenillard_s(7 downto 0);
            count <=  count+1;
        elsif (led_s/="10" and reset='1') then
            led <= "000000"&led_s;
        end if;
        if (count = 8) then
            reset <= '0';
            count <= 0;
            led<= "00000000";
        end if;
    end if;
    end process;   
end Behavioral;