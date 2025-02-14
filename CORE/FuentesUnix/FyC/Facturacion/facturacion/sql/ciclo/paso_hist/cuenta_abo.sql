set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_abo.dat;
select lpad(to_char(count(*)),8,'0') from siscel.fa_factabon_&1; 
spool off;
exit;
