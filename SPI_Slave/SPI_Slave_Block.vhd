-- Bu projede SPI (Serial Periperhal Interface) Slave yapýsýna bir ornek gerceklestirecegiz.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity SPI_Slave_Block is
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

end entity;

architecture arh of SPI_Slave_Block is

signal bit_cnt	: std_logic_vector(2 downto 0); --Bufferler icin bit sayýcý (sck ya gore sayýyor)
signal rx_reg	: std_logic_vector(7 downto 0);

begin

--Bit Counter
process(rst, sck, ss)
begin
	if(rst = '1' or ss = '1') then
		bit_cnt <= "111"; --Gondermeye MSB'den baslýyor. Tercih ve tasarim sebebidir "000" yapilarak gondermeye LSB'den baslanabilirdi.
	elsif(rising_edge(sck) and ss = '0') then
		if(bit_cnt = "000") then
			bit_cnt <= "111";
		else
		bit_cnt <= bit_cnt - "001";
		end if;
	end if;
		
end process;

--rx bufferini doldurma
process(rst, ss, sck)
begin
	if(rst = '1' or ss = '1') then
		rx_reg <= (others => '0');
	elsif(ss = '0' and rising_edge(sck)) then
		rx_reg(to_integer(unsigned(bit_cnt))) <= MOSI;
	end if;
end process;
rx_data <= rx_reg;

--tx bufferini gonderme
process(rst, ss, sck)
begin
	if(rst = '1' or ss = '1') then
		MISO <= '0';
	elsif(ss = '0' and rising_edge(sck)) then
		MISO <=  tx_data(to_integer(unsigned(bit_cnt)));
	end if;
end process;

end architecture;
