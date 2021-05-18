----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2020 15:58:08
-- Design Name: 
-- Module Name: test_bench_SPI_Slave - Behavioral
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
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench_SPI_Slave is
--  Port ( );
end test_bench_SPI_Slave;

architecture Behavioral of test_bench_SPI_Slave is
component SPI_Slave_Block is
	port(
		rst		:in std_logic;
		SCK 	:in std_logic;
		MOSI 	:in std_logic;
		MISO 	:out std_logic;
		SS 		:in std_logic;
		
		--Buffer'lar
		tx_data :in std_logic_vector(7 downto 0); --transmit buffer
		rx_data :out std_logic_vector(7 downto 0) --reciever buffer
	);
end component;

signal rst		: std_logic; 
signal SCK 	    : std_logic; 
signal MOSI 	: std_logic;
signal MISO 	: std_logic;
signal SS 		: std_logic;
signal tx_data  : std_logic_vector(7 downto 0);
signal rx_data  : std_logic_vector(7 downto 0);

begin

Slave : SPI_Slave_Block port map(
    rst	 => rst	,
    SCK  => SCK ,
    MOSI => MOSI,
    MISO => MISO,
    SS 	 => SS,
    tx_data => tx_data,
    rx_data => rx_data
);

process
begin

rst     <= '1';
MOSI    <= '0';
SS 	    <= '1';
SCK <= '0';

wait for 30ns;

rst <= '0';

wait for 30ns;

SS <= '0';
tx_data <= "11100010";

wait for 20ns;

MOSI <= '1';
wait for 10ns;
SCK <= '1';  --1
wait for 10ns;
SCK <= '0';
wait for 10ns;
SCK <= '1'; --2
wait for 10ns;
SCK <= '0';
MOSI <= '0';
wait for 10ns;
SCK <= '1'; --3
wait for 10ns;
SCK <= '0';
wait for 10ns;
SCK <= '1'; --4
wait for 10ns;
SCK <= '0';
MOSI <= '1';
wait for 10ns;
SCK <= '1'; --5
wait for 10ns;
SCK <= '0';
MOSI <= '0';
wait for 10ns;
SCK <= '1'; --6
wait for 10ns;
SCK <= '0';
MOSI <= '1';
wait for 10ns;
SCK <= '1'; --7
wait for 10ns;
SCK <= '0';
MOSI <= '0';
wait for 10ns;
SCK <= '1'; --8
wait for 10ns;
SCK <= '0';
wait for 10ns;

wait;

end process;

end Behavioral;
