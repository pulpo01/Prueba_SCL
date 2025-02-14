-- Programa : GetProcFact.sql
-- Author   : rao.
-- Date     : 20/7/07
-- Remarks  : Ontiene el indicador de reproceso 
-- =================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/GetProcFact.dat;
select lpad(to_char(ind_reproceso),8,'0') from siscel.fa_procfact where cod_proceso = &1 ;
spool off;
exit;
