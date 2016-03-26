library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t3l_caraan_catalan_tb is
	constant DELAY: time := 10 ns;
end;

architecture t3l_caraan_catalan_gate of  t3l_caraan_catalan_tb is
	component t3l_caraan_catalan is
			port (a: out std_logic;  
				i2,i1,i0,o2,o1,o0: in std_logic );
	end component;
	
	signal a: std_logic;
	signal i2,i1,i0,o2,o1,o0: std_logic;
begin
	uut:component t3l_caraan_catalan port map(a,i2,i1,i0,o2,o1,o0);
	
process 
	variable temp: unsigned(5 downto 0);
	variable expected_alarm: std_logic;
	variable error_count: integer := 0;
	
begin
		report "start simulation";
		
		for i in 0 to 63 loop
			temp := TO_UNSIGNED(i, 6);
			--assign each input a value from temp
			i2 <= temp(5);
			i1 <= temp(4);
			i0 <= temp(3);

			o2 <= temp(2);
			o1 <= temp(1);
			o0 <= temp(0);
			
			wait for DELAY;
			
			if ((i2 = '1' or i1 = '1' or i0 = '1') and (o2 = '1' or o1 = '1' or o0 = '1')) then 
				expected_alarm := '1';
			else
				expected_alarm := '0';
			end if;
			wait for DELAY;
			
			assert(expected_alarm = a)
				report "ERROR: Expected Alarm " & std_logic'image(expected_alarm) & " /= actual alarm " & 
					std_logic'image(a) & " at time " & time'image(now);
				
			if  (expected_alarm /= a)
				then error_count := error_count + 1;
			end if;
		end loop;
		
		wait for DELAY;
		assert (error_count = 0)
			report "ERROR: There were " &
				integer'image(error_count) & " errors!";
			if(error_count = 0)
				then report "Simulation completed with NO errors.";
			end if;
		wait;
	end process;
end architecture;


