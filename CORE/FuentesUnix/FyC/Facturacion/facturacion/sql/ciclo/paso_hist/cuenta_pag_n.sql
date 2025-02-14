set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_pag_n.dat;
select lpad(to_char(count(1)),8,'0') from siscel.fa_histpago_&1 ; 
spool off;
exit;
