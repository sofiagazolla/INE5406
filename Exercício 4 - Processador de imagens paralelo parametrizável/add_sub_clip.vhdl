library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addSubClip is
	generic (N : positive := 8);
	port (
		inputA: in unsigned(N-1 downto 0);
		inputB: in unsigned(N-1 downto 0);
		add: in std_logic;
		clipped: out unsigned(N-1 downto 0) 
	);
end addSubClip;

architecture arch of addSubClip is
	
	signal a_plus_or_minus_b, clipped_a_plus_or_minus_b : signed(N+1 downto 0); -- dois signals com sinal - clip opera com signed

begin -- ele opera com números signed, então é preciso converter de unsigned para signed

	a_plus_or_minus_b <= signed(resize(inputA, N+2)) + signed(resize(inputB, N+2)) when add = '1'   -- acho q add devia ser um pq faz mais sentido -- o numero de bits é aumentado pois no código qu realiza a clipagem, as entradas e saídas tem 9 bits
		   else signed(resize(inputA, N+2)) - signed(resize(inputB, N+2));

	CLIP: entity work.clip
		generic map(
			N    => a_plus_or_minus_b'length,
			LOW  => 0,
			HIGH => (2**N)-1
		)
		port map(
			value => a_plus_or_minus_b,
			clipped_value => clipped_a_plus_or_minus_b -- nao esta conectado em nada. precisa conectar onde? 
		);

	clipped <= unsigned(clipped_a_plus_or_minus_b(N-1 downto 0)); -- a saída deve ser sem sinal então é preciso converter novamente

end arch;