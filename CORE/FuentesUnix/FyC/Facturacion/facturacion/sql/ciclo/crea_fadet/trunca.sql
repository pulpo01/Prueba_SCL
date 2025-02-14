-- Programa : trunca.sql
-- Author   : ACT
-- Date     : 23/9/99
-- Remarks  : Trunca tabla pf_tarificadas una vez que se verifica que la fa_detcelular
--            tiene la misma cantidad de filas que esta tabla.
-- ===============================================================================
set ver off
spool $WORKDIR/trunca
drop table siscel.pf_toltarifica_&1;
spool off
exit;
