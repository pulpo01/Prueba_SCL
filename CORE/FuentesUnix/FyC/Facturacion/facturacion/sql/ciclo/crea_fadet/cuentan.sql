-- Programa : cuentan.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Cuenta la cantidad de filas de la nueva fa_detcelular.
-- =================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuentan.dat;
select lpad(to_char(count(*)),8,'0') from siscel.fa_detcelular_&1 ; 
spool off;
exit;
