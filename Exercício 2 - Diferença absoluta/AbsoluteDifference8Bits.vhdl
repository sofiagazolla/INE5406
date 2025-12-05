LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-- Não altere a definição da entidade!
-- Ou seja, não modifique o nome da entidade, nome das portas e tipos/tamanhos das portas!
ENTITY AbsoluteDifference8Bits IS -- declaração da entidade AbsoluteDifference8Bits
	PORT (
        A : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada A, valor sem sinal de 8 bits (0,...,255).
        B : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Entrada B, valor sem sinal de 8 bits (0,...,255).
    	S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- Saída S,   valor sem sinal em 8 bits (0,...,255), representando |A-B|.
    );
END AbsoluteDifference8Bits;

-- Não alterar o nome da arquitetura!
ARCHITECTURE structure OF AbsoluteDifference8Bits IS
    signal subtraido : SIGNED (8 DOWNTO 0);
    signal saida : UNSIGNED ( 7 DOWNTO 0);
BEGIN
    
    SUBTRACAO : ENTITY work.Difference8Bits(arch)
    PORT MAP (A => UNSIGNED(A) , B => UNSIGNED(B) , S => subtraido );
    
    MODULO : ENTITY work.Absolute9Bits(arch)
    PORT MAP (value => subtraido , absoluteValue => saida, overflow => open);
    
    S <=STD_LOGIC_VECTOR (saida);
    
END structure;