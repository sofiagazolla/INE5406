library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Não altere o nome da entidade e o nome das portas!
-- Porém, será necessário atualizar a entidade para que o código compile!
-- Você deverá criar o generic N e utilizar para definir o número de bits da porta count
ENTITY counter IS
    GENERIC (N : INTEGER := 4);
	PORT (
		clock  : IN STD_LOGIC;
		reset  : IN STD_LOGIC;
		enable : IN STD_LOGIC;
		count  : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0) 
	);
END counter;

ARCHITECTURE arch OF counter IS
	signal contador : UNSIGNED (N-1 DOWNTO 0);
BEGIN

    process (clock)
    begin
        if (rising_edge(clock)) and (reset = '1') then
            contador <= (others => '0');
        elsif (rising_edge(clock)) and (reset = '0') and (enable = '1') then
            contador <= contador + 1;
        end if;
	END PROCESS;
	
	count <= std_logic_vector (contador);
	
END arch;
