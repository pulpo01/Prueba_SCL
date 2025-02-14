-- Programa : GetProcFactPrec.sql
-- Author   : rao.
-- Date     : 20/7/07
-- Remarks  : Obtiene los procesos precedentes requeridos 
-- =================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/GetProcFactPrec.dat;
select lpad(to_char(count(1)),8,'0') from siscel.fa_procfactprec where cod_proceso = &1 ;
spool off;
exit;
