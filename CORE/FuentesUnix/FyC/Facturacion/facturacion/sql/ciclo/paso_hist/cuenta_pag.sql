set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuenta_pag.dat;
select lpad(to_char(count(1)),8,'0') from siscel.co_ultpago_tt where cod_ciclfact = &1 ; 
spool off;
exit;
