-- Programa : GetTrazaProcPrec.sql
-- Author   : rao.
-- Date     : 20/7/07
-- Remarks  : Obtiene procesos ejecutados
-- =================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/GetTrazaProcPrec.dat;
select lpad(to_char(count(1)),8,'0') from fa_trazaproc a, fa_procfactprec b  
where a.cod_ciclfact = &1 and b.cod_proceso = &2 and b.cod_procprec  = a.cod_proceso and b.cod_estaprec = a.cod_estaproc  ;
spool off;
exit;
