CREATE OR REPLACE FUNCTION        FNSEQCASCON return number
is
ihNumProceso number;
begin
	 select co_seq_imput_cascon.nextval into ihNumProceso from dual;
return ihNumProceso;
end;
/
SHOW ERRORS
