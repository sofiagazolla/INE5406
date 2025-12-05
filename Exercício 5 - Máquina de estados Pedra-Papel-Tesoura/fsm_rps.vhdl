LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fsm_rps IS
	PORT (
		clk : IN std_logic;
		rst_a : IN std_logic; --ativo alto
		ok : IN std_logic;
		play : IN std_logic_vector(1 DOWNTO 0);
		winner : OUT std_logic_vector(1 DOWNTO 0)
	);
END fsm_rps;

ARCHITECTURE arch OF fsm_rps IS

	type Estado is (WAIT_P1, SC_WAIT_P2, RO_WAIT_P2, PA_WAIT_P2, P1_WINS, DRAW, P2_WINS);
	signal EstadoAtual : Estado;
	
BEGIN
    ControleEstados : process (clk, rst_a)
	BEGIN
	    if rst_a = '1' then
	        EstadoAtual <= WAIT_P1;
	        winner <= "00";
	        
	    elsif (rising_edge(clk)) then
	        case EstadoAtual is
	            when WAIT_P1 => --inicio
	               if ok = '0' then
	                    EstadoAtual <= WAIT_P1;
	               elsif (ok = '1' and play = "01") then 
	                    EstadoAtual <= SC_WAIT_P2;
	               elsif (ok = '1' and play = "10") then 
	                    EstadoAtual <= RO_WAIT_P2;
	               elsif (ok = '1' and play = "11") then 
	                    EstadoAtual <= PA_WAIT_P2;
	               else 
	                    EstadoAtual <= WAIT_P1;
	               end if;
	               winner <= "00";
	                    
	           when SC_WAIT_P2 => -- tesoura
	               if ok = '0' then
	                    EstadoAtual <= SC_WAIT_P2;
	                    winner <= "00";
	               elsif (ok = '1' and play = "01") then 
	                    EstadoAtual <= DRAW;
	                    winner <= "11";
	               elsif (ok = '1' and play = "10") then 
	                    EstadoAtual <= P2_WINS;
	                    winner <= "10";
	               elsif (ok = '1' and play = "11") then 
	                    EstadoAtual <= P1_WINS;
	                    winner <= "01";
	               else 
	                    EstadoAtual <= SC_WAIT_P2; -- se a entrada for inválida
	                    winner <= "00";
	               end if; 
	                  
	                  
	           when RO_WAIT_P2 => -- pedra
	               if ok = '0' then
	                    EstadoAtual <= RO_WAIT_P2;
	                    winner <= "00";
	               elsif (ok = '1' and play = "01") then 
	                    EstadoAtual <= P1_WINS;
	                    winner <= "01";
	               elsif (ok = '1' and play = "10") then 
	                    EstadoAtual <= DRAW;
	                    winner <= "11";
	               elsif (ok = '1' and play = "11") then 
	                    EstadoAtual <= P2_WINS;
	                    winner <= "10";
	               else 
	                    EstadoAtual <= RO_WAIT_P2; -- se a entrada for inválida
	                    winner <= "00";
	               end if;
	               
	           when PA_WAIT_P2 => -- papel
	               if ok = '0' then
	                    EstadoAtual <= PA_WAIT_P2;
	                    winner <= "00";
	               elsif (ok = '1' and play = "01") then 
	                    EstadoAtual <= P2_WINS;
	                    winner <= "10";
	               elsif (ok = '1' and play = "10") then 
	                    EstadoAtual <= P1_WINS;
	                    winner <= "01";
	               elsif (ok = '1' and play = "11") then 
	                    EstadoAtual <= DRAW;
	                    winner <= "11";
	               else 
	                    EstadoAtual <= PA_WAIT_P2; -- se a entrada for inválida
	                    winner <= "00";
	               end if;
	               
	           when P1_WINS => -- jogador um ganhou
	               if ok = '0' then
	                    winner <= "01";
	                    EstadoAtual <= P1_WINS;
	               else 
	                    winner <= "00";
	                    EstadoAtual <= WAIT_P1; -- reinicia
	               end if;
	           
	           when DRAW => -- empate
	               if ok = '0' then
	                    winner <= "11";
	                    EstadoAtual <= DRAW;
	               else 
	                    winner <= "00";
	                    EstadoAtual <= WAIT_P1; -- reinicia
	               end if;
	               
	           when P2_WINS => -- jogador dois ganhou
	               if ok = '0' then
	                    winner <= "10";
	                    EstadoAtual <= P2_WINS;
	               else 
	                    winner <= "00";
	                    EstadoAtual <= WAIT_P1; -- reinicia
	               end if;
	               
	       end case;
	    end if;
	   end process;
END arch;