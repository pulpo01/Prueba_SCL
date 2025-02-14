set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_doc.dat;
select lpad(to_char(count(*)),8,'0') from siscel.fa_factdocu_&1 ; 
spool off;
exit;
