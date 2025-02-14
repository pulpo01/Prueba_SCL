set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_tecno_n.dat;
select lpad(to_char(count(*)),8,'0') from siscel.fa_histecno_th_&1; 
spool off;
exit;
