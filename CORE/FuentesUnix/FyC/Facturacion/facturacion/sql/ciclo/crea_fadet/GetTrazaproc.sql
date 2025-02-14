-- Programa : GetTrazaproc.sql
-- Author   : rao
-- Date     : 20/6/07
-- Remarks  : Obtiene la traza de proceso para ciclo
-- =================================================================
set ver off;
set feedback off;
set echo off;
set pagesize 0;
spool $WORKDIR/GetTrazaproc.dat;
select lpad(to_char(cod_estaproc),8,'0') from siscel.fa_trazaproc where cod_ciclfact = &1 and cod_proceso = &2 ;
spool off;
exit;