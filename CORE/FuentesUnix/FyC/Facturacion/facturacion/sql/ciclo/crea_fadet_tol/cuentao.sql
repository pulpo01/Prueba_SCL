-- Programa : cuentao.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Cuenta la cantidad de filas de la tabla pf_tarificadas.
-- ==================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/cuentao.dat;
select lpad(to_char(count(*)),8,'0') from siscel.pf_toltarifica;
spool off;
exit;
