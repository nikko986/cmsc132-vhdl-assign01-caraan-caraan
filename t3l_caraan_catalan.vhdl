library IEEE; use IEEE.std_logic_1164.all;

entity t3l_caraan_catalan is
	port (a: out std_logic; 
		i2,i1,i0,o2,o1,o0: in std_logic );
end t3l_caraan_catalan;

architecture behav of t3l_caraan_catalan is

begin
	 a <= (i2 or i1 or i0) and (o2 or o1 or o0);
end architecture behav;