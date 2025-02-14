set pause off head off
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_his.dat
set serveroutput on
declare
cuenta1 number(8) := 0 ;
cuenta2 number(8) := 0 ;
cuenta3 number(8) := 0 ;

begin
        select count(*) into cuenta1 from siscel.fa_histdocu ;
        select count(*) into cuenta2 from siscel.fa_factdocu_&1;
        select cuenta1+cuenta2 into cuenta3 from dual;
dbms_output.put_line (lpad(to_char(cuenta3),8,'0'));
end;
/
spool off
exit;
