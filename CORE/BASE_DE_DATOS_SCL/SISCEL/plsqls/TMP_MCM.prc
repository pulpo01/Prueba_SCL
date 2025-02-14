CREATE OR REPLACE procedure        tmp_mcm (p_num_numeracion in number, p_output out number)
is
begin
	p_output := p_num_numeracion + 1;
end;
/
SHOW ERRORS
