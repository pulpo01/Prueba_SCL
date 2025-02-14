set serveroutput on 
declare
	   SN_coderror NUMBER;
	   SV_error    VARCHAR2(255);
begin
	 GA_PRELIQ_MISCELANEA_PG.GA_PRELIQ_MISCELANEA_PR(SN_coderror,SV_error);
	 COMMIT;
         EXCEPTION
         WHEN OTHERS THEN
             ROLLBACK;
	     dbms_output.put_line('SN_coderror = '||TO_NUMBER(SN_coderror));
	     dbms_output.put_line('SV_error = '||SV_error);	 
end;
/
exit
